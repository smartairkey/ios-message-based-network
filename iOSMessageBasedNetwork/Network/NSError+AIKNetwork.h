//
//  NSError+AIKNetwork.h
//  Airkey
//
//  Created by Lobanov Dmitry on 27.07.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (AIKNetwork)

+ (instancetype)customErrorWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict;
+ (instancetype)customNetworkErrorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;
@property (nonatomic, readonly) BOOL kindUnauthorized;
@property (nonatomic, readonly) BOOL kindForbidden;
@property (nonatomic, readonly) BOOL kindInternalServerError;
@property (nonatomic, readonly) BOOL kindNotImplemented;

+ (instancetype)noConnectionError;

@end
