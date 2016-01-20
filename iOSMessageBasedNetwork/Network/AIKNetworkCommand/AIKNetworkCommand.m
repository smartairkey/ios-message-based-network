//
//  AIKAPIClientCommand.m
//  Airkey
//
//  Created by Lobanov Dmitry on 11.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "AIKNetworkCommand.h"
#import "NSFoundationExtendedMethods.h"
#import "NSError+AIKNetwork.h"

@interface AIKNetworkCommand ()

@property(nonatomic, strong) NSDictionary *serialized;

@property(nonatomic, strong) NSString *appVersion;
@property(nonatomic, strong) NSString *deviceId;

@end

@implementation AIKNetworkCommand

#pragma mark - Subscription

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
    //
    if (key) {
        return self.serialized[key];
    }
    else {
        return nil;
    }
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
    if (key) {
        if (obj) {
            NSMutableDictionary *dictionary = [self.serialized mutableCopy];
            dictionary[key] = obj;
            self.serialized = [dictionary copy];
        }
        else {
            NSMutableDictionary *dictionary = [self.serialized mutableCopy];
            [dictionary removeObjectForKey:key];
            self.serialized = [dictionary copy];
        }
    }
}


#pragma mark - Error Handling

- (NSError *)shouldStopError {
    return [NSError customNetworkErrorWithCode:100 userInfo:@{NSLocalizedDescriptionKey : [NSString takeVisibleStringOrEmptyOtherwise:self.shouldStopMessage]}];
}

- (BOOL)shouldStop {
    return self.shouldStopMessage != nil;
}

#pragma mark - Basic Getters

+ (NSString *)action {
    return [[self new] action];
}

- (NSString *)action {
    return nil;
}

- (BOOL)authorized {
    return NO;
}

- (NSString *)path {
    return nil;
}

- (NSString *)type {
    return nil;
}

#pragma mark - Network

- (NSDictionary *)queryParams {
    assert(self.action != nil);

    NSString *actionParameterName = @"Action";
    NSString *appVersionParameterName = @"AppVersion";
    NSString *deviceIdParameterName = @"DeviceId";

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[actionParameterName] = self.action;
    params[appVersionParameterName] = @"AppVersion";
    params[deviceIdParameterName] = @"DeviceID";

    return [params copy];
}

#pragma mark - Instantiation

- (instancetype)init {
    return [self initWithDictionary:@{}];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        _serialized = dictionary;
    }

    return self;
}

#pragma mark - Base
- (NSString *)description {
    return [NSString stringWithFormat:@"path: %@\n type: %@\n action: %@\n authorized: %@\n queryParams: %@\n shouldStopMessage:%@\n", self.path, self.type, self.action, @(self.authorized), self.queryParams, self.shouldStopMessage];
}

@end