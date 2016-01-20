//
//  AIKAPIClientResponseAnalyzer.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#import "AIKAPIClientResponseAnalyzer.h"
#import "NSFoundationExtendedMethods.h"
#import "NSError+AIKNetwork.h"

#import "AIKAPIClient.h"
#import <LITEventMachine/LITEMEventMachine.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

static const DDLogLevel ddLogLevel = DDLogLevelDebug;

@implementation AIKAPIClientResponseAnalyzer

- (NSError *)specialError:(NSError *)error withContext:(NSDictionary *)context {
    if (![context[self.domainReachableContextAttribute] boolValue] && ![context[self.backgroundOperationContextAttribute] boolValue]) {
        // tell them that you not reachable
        return [error.class noConnectionError];
    }
    return error;
}

- (void)reactOnError:(NSError *)error withContext:(NSDictionary *)context {
    // special kind - has credentials?
    if (error.kindUnauthorized && [context[self.hasCredentialsContextAttribute] boolValue]) {
        // we should do something?
        [[LITEMEventMachine eventMachine].eventBus fireEvent:[LITEMBaseEventFactory eventWithType:@"SpecialEvent"]];
    }
}

- (NSString *)hasCredentialsContextAttribute {
    return @"hasCredentialsContextAttribute";
}

- (NSString *)domainReachableContextAttribute {
    return @"domainReachableContextAttribute";
}

- (NSString *)backgroundOperationContextAttribute {
    return @"backgroundOperationContextAttribute";
}

- (NSError *)analyzeResponseWithOperation:(NSURLSessionDataTask *)operation withContext:(NSDictionary *)context withParameters:(NSDictionary *)parameters withError:(NSError *)error {
    [self analyzeResponseWithOperation:operation withContext:context withParameters:parameters];
    // try to retrieve error description
    // messy, I know, but who cares if it works?
    NSDictionary *errorServerDescription = (NSDictionary *)
    [NSData jsonObjectFromData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey]];
    
    // form correct error
    NSHTTPURLResponse *response = (NSHTTPURLResponse *) operation.response;
    NSError *blessedError = [NSError customErrorWithDomain:error.domain code:response.statusCode userInfo:error.userInfo];
    
    // if error exists, we should replace our error with this one
    NSMutableDictionary *errorDictionary = [blessedError.userInfo mutableCopy];
    errorDictionary[NSLocalizedDescriptionKey] = errorServerDescription[@"error"];
    
    blessedError = [NSError customErrorWithDomain:blessedError.domain code:blessedError.code userInfo:[errorDictionary copy]];
    
    DDLogDebug(@"%@ error: %@", self.class, errorServerDescription[@"error"]);
    DDLogDebug(@"%@ our error: %@", self.class, blessedError);

    NSError *specialError = [self specialError:blessedError withContext:context];

    DDLogDebug(@"%@ error changed: %@", self.class, specialError);

    [self reactOnError:specialError withContext:context];

    return specialError;
}

- (NSError *)analyzeResponseWithOperation:(NSURLSessionDataTask *)operation withContext:(NSDictionary *)context withParameters:(NSDictionary *)parameters {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *) operation.response;
    DDLogDebug(@"%@ in context: %@", self.class, context);
    DDLogDebug(@"%@ have status: %@", self.class, @(response.statusCode));
    DDLogDebug(@"%@ have response: %@", self.class, response);
    DDLogDebug(@"%@ parameters were: %@", self.class, parameters);
    DDLogDebug(@"%@ parameters as json: %@", self.class, [parameters jsonString]);
    DDLogDebug(@"%@ headers are: %@", self.class, operation.currentRequest.allHTTPHeaderFields);
    return nil;
}

@end
