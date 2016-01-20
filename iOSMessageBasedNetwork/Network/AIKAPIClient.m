//
//  AKIAPIClient.m
//  Airkey
//
//  Created by Alexandr Novikov on 16.06.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AIKAPIClient.h"
#import "NSFoundationExtendedMethods.h"
#import "AIKBuildConfigurationAccessor.h"
#import "AIKAPIClientResponseAnalyzer.h"
#import "AIKAPIClientReachabilityMonitor.h"

#import "AIKNetworkCustomCommands.h"

#import <CocoaLumberjack/CocoaLumberjack.h>

// helper
//  pbpaste | perl -ne '/-/ && do { @s = split(/:/, $_); $_ = $s[0]; $_ =~ s/-(void)//; $_=~ s/(\w+)With\w+//; $_ = ucfirst($1); $string = join("\n", map{"\@property(nonatomic, strong) ".$_.";\n"  } map{ $_ =~ m/\(([\s\w\*]+)\)(\w+)/ && $1.$2  } (@s[1..$#s - 2]) );  print qq(\@interface AIKAPIClientCommand$_ : AIKAPIClientCommand \n $string \n\@end\n)}' |pbcopy

static const DDLogLevel ddLogLevel = DDLogLevelDebug;

static NSString *authorizationHeaderName = @"Authorization";
static NSString *timestampHeaderName = @"Timestamp";

@interface AIKAPIClient ()

@property(nonatomic, strong) AIKAPIClientReachabilityMonitor *reachabilityMonitor;
@property(nonatomic, strong) AIKAPIClientResponseAnalyzer *responseAnalyzer;

@end

@implementation AIKAPIClient

#pragma mark - Creation

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reachabilityMonitor = [self createReachabilityMonitor];
    }
    return self;
}

#pragma mark - Reachability

- (NSString *)reachabilityDomain {
    return [self baseDomain];
}

- (AIKAPIClientReachabilityMonitor *)createReachabilityMonitor {
    AIKAPIClientReachabilityMonitor *manager = [[AIKAPIClientReachabilityMonitor alloc] init];
    manager.baseDomain = [self reachabilityDomain];
    DDLogDebug(@"%@ reachability hosted at: %@", self.class, manager.baseDomain);
    return manager;
}

- (BOOL)networkIsReady {
    return self.reachabilityMonitor.reachable;
}

- (void)startNetworkMonitoring {
    [self.reachabilityMonitor startMonitoring];
}

#pragma mark - Response Analysis
- (AIKAPIClientResponseAnalyzer *)responseAnalyzer {
    if (!_responseAnalyzer) {
        _responseAnalyzer = [[AIKAPIClientResponseAnalyzer alloc] init];
    }
    return _responseAnalyzer;
}

#pragma mark - Network Managers

- (AFHTTPSessionManager *)createManager {
    NSString *baseURL = [self baseURL];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    manager.requestSerializer = [AFJSONRequestSerializer new];
    DDLogDebug(@"%@ manager request serializer: %@", self.class, manager.requestSerializer.class);
    DDLogDebug(@"%@ manager hosted at %@", self.class, manager.baseURL);
    return manager;
}

- (NSString *)baseDomain {
    return [AIKBuildConfigurationAccessor networkServerAddress];
}

- (NSString *)basePort {
    return [AIKBuildConfigurationAccessor networkServerPort];
}

- (NSString *)baseHost {
    NSString *host = [AIKBuildConfigurationAccessor networkServerFullAddress];
    return host;
}

- (NSString *)baseURL {
    NSString *host = [self baseHost];
    NSString *APIPath = @"api"; // don't needed later

    return [self baseURLForHost:host andAPIPath:APIPath andUseSSL:YES];
}

- (NSString *)baseURLForHost:(NSString *)host andAPIPath:(NSString *)apiPath andUseSSL:(BOOL)useSSL {

    NSMutableString *urlString = [NSMutableString stringWithFormat:@"%@://%@", useSSL ? @"https" : @"http", host];

    if (apiPath) {
        [urlString appendFormat:@"/%@", apiPath];
    }
    return urlString;
}

#pragma mark - Private Methods

- (void)commonHttpOperationWithType:(NSString *)type
                           withPath:(NSString *)path
                     withParameters:(NSDictionary *)initialParameters
                         authorized:(BOOL)authorizedOperation
                         background:(BOOL)backgroundOperation
                       successBlock:(AIKAPIClientSuccessBlock)successBlock
                         errorBlock:(AIKAPIClientErrorBlock)errorBlock {

    NSMutableDictionary *parameters = [initialParameters mutableCopy];

    if (!parameters) {
        parameters = [NSMutableDictionary dictionary];
    }

    AFHTTPSessionManager *manager = [self createManager];

    if (authorizedOperation) {
        // add headers
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:timestampHeaderName];
        [manager.requestSerializer setValue:@"" forHTTPHeaderField:authorizationHeaderName];
    }
    
    NSDictionary *context = @{
      self.responseAnalyzer.hasCredentialsContextAttribute : @([NSString isStringVisible:self.apiKey] || [NSString isStringVisible:self.token]),
      @"apiKey" : [NSString takeVisibleString:self.apiKey orAlternative:@"API_KEY"],
      @"token" : [NSString takeVisibleString:self.token orAlternative:@"TOKEN"],
      self.responseAnalyzer.domainReachableContextAttribute : @(self.networkIsReady),
      self.responseAnalyzer.backgroundOperationContextAttribute : @(backgroundOperation)
    };

    NSDictionary *operationInfoHash = @{
            @"type" : type,
            @"path" : path,
            @"parameters" : parameters,
            @"headers" : [manager.requestSerializer valueForKey:@"mutableHTTPRequestHeaders"]
    };

    void (^responseSuccessBlock)(NSURLSessionDataTask *operation, id responseObject) = ^(NSURLSessionDataTask *operation, id responseObject) {
        [self.responseAnalyzer analyzeResponseWithOperation:operation withContext:context withParameters:parameters];
        
        if (successBlock) {
            successBlock(responseObject);
        }
    };
    
    void (^responseErrorBlock)(NSURLSessionDataTask *operation, NSError *error) = ^(NSURLSessionDataTask *operation, NSError *error) {
        NSError *resultError = [self.responseAnalyzer analyzeResponseWithOperation:operation withContext:context withParameters:parameters withError:error];
        
        if (errorBlock) {
            errorBlock(resultError);
        }
    };
    
    DDLogDebug(@"I will perform operation: %@", operationInfoHash);

    if ([type isEqualToString:@"GET"]) {
        [manager GET:path parameters:parameters success:responseSuccessBlock failure:responseErrorBlock];
    } else if ([type isEqualToString:@"POST"]) {
        [manager POST:path parameters:parameters success:responseSuccessBlock failure:responseErrorBlock];
    } else if ([type isEqualToString:@"PUT"]) {
        [manager PUT:path parameters:parameters success:responseSuccessBlock failure:responseErrorBlock];
    } else if ([type isEqualToString:@"DELETE"]) {
        [manager DELETE:path parameters:parameters success:responseSuccessBlock failure:responseErrorBlock];
    } else if ([type isEqualToString:@"PATCH"]) {
        [manager PATCH:path parameters:parameters success:responseSuccessBlock failure:responseErrorBlock];
    }
}

- (NSString *)signatureWithToken:(NSString *)token
                integrityMessage:(NSString *)message {
    // custom logic here
    return token;
}

- (NSString *)authorizationHeaderValueWithApiKey:(NSString *)apiKey
                                       signature:(NSString *)signature {
    // custom logic here
    return apiKey;
}

#pragma mark - Accessors

- (NSString *)apiKey {
    return [self secretWithName:@"apiKey"];
}

- (NSString *)token {
    return [self secretWithName:@"token"];
}

- (NSString *)secretWithName:(NSString *)name {
    NSString *defaultValue = @"";
    DDLogDebug(@"try to retrieve from memory %@: ", name);
    // custom logic here, for example
    return name;
}

#pragma mark - Available Now

#pragma mark - Helpers
#pragma mark - Command PreProcessing
- (BOOL)canExecuteCommand:(AIKNetworkCommand *)command {
    return !command.shouldStop;
}

- (BOOL)canExecuteCommand:(AIKNetworkCommand *)command errorBlock:(AIKAPIClientErrorBlock)errorBlock {
    BOOL canExecuteCommand = [self canExecuteCommand:command];
    if (!canExecuteCommand) {
        DDLogDebug(@"operation should stop with message: %@", command.shouldStopMessage);
        if (errorBlock) {
            errorBlock(command.shouldStopError);
        }
    }
    return canExecuteCommand;
}

#pragma mark - Executing

- (void)executeCommand:(AIKNetworkCommand *)command
          inBackground:(BOOL)background
          successBlock:(AIKAPIClientSuccessBlock)successBlock
            errorBlock:(AIKAPIClientErrorBlock)errorBlock {

    NSString *type = command.type;
    NSString *path = command.path;
    NSDictionary *params = command.queryParams;
    BOOL authorized = command.authorized;
    
    if ([self canExecuteCommand:command errorBlock:errorBlock]) {
        [self commonHttpOperationWithType:type withPath:path withParameters:params authorized:authorized background:background successBlock:successBlock errorBlock:errorBlock];
    }
}

- (void)executeCommand:(AIKNetworkCommand *)command
          successBlock:(AIKAPIClientSuccessBlock)successBlock
            errorBlock:(AIKAPIClientErrorBlock)errorBlock {

    [self executeCommand:command inBackground:NO successBlock:successBlock errorBlock:errorBlock];
}

- (void)executeCommandRemotely:(AIKNetworkCommand *)command
                  successBlock:(AIKAPIClientSuccessBlock)successBlock
                    errorBlock:(AIKAPIClientErrorBlock)errorBlock
                noNetworkBlock:(AIKAPIClientNoNetworkBlock)noNetworkBlock
                   localForced:(BOOL)localForced {
    
    if (localForced && noNetworkBlock) {
        // put into database
        noNetworkBlock(command);
    }
    
    if (![self canExecuteCommand:command errorBlock:errorBlock]) {
        return;
    }
    
    [self executeCommand:command inBackground:NO successBlock:successBlock errorBlock:errorBlock];
}

- (void)executeCommandRemotely:(AIKNetworkCommand *)command
                  successBlock:(AIKAPIClientSuccessBlock)successBlock
                    errorBlock:(AIKAPIClientErrorBlock)errorBlock
                noNetworkBlock:(AIKAPIClientNoNetworkBlock)noNetworkBlock {

    [self executeCommandRemotely:command successBlock:successBlock errorBlock:errorBlock noNetworkBlock:noNetworkBlock localForced:YES];
}

@end
