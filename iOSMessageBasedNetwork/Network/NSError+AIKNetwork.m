//
//  NSError+AIKNetwork.m
//  Airkey
//
//  Created by Lobanov Dmitry on 27.07.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "NSError+AIKNetwork.h"

NS_ENUM(NSInteger, AIKNetworkErrorCode) {
    AIKNetworkErrorCodeUnauthorized = 401,
    AIKNetworkErrorCodeForbidden = 403,
    AIKNetworkErrorCodeInternalServerError = 500,
    AIKNetworkErrorCodeNotImplemented = 501
};

NSString *const errorDomain = @"com.projectErrors.networkDomain";

@implementation NSError (AIKNetwork)

+ (instancetype)customErrorWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict {
    NSError *blessedError = nil;

    if (code == AIKNetworkErrorCodeInternalServerError) {
        // setup internal server error
        NSMutableDictionary *dictionary = [dict mutableCopy];
        dictionary[NSLocalizedDescriptionKey] = @"Internal error";
        dict = [dictionary copy];
        blessedError = [self errorWithDomain:domain code:code userInfo:dict];
    }

    if (!blessedError) {
        blessedError = [self errorWithDomain:domain code:code userInfo:dict];
    }

    return blessedError;
}

+ (instancetype)customNetworkErrorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict {
    return [self customErrorWithDomain:errorDomain code:code userInfo:dict];
}

- (BOOL)kindUnauthorized {
    return self.code == AIKNetworkErrorCodeUnauthorized;
}
- (BOOL)kindForbidden {
    return self.code == AIKNetworkErrorCodeForbidden;
}

- (BOOL)kindInternalServerError {
    return self.code == AIKNetworkErrorCodeInternalServerError;
}
- (BOOL)kindNotImplemented {
    return self.code == AIKNetworkErrorCodeNotImplemented;
}

+ (instancetype)noConnectionError {
    return [NSError errorWithDomain:errorDomain code:1000 userInfo:@{NSLocalizedDescriptionKey : @"No connection error"}];
}

@end
