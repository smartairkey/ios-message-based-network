//
//  AIKNetworkCustomCommands.m
//  Airkey
//
//  Created by Lobanov Dmitry on 13.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "AIKNetworkCustomCommands.h"

static NSString *HTTPOperationTypeGET = @"GET";
static NSString *HTTPOperationTypePOST = @"POST";
static NSString *HTTPOperationTypePUT = @"PUT";
static NSString *HTTPOperationTypeDELETE = @"DELETE";
static NSString *HTTPOperationTypePATCH = @"PATCH";

static NSString *supportApiPath = @"support";
static NSString *mobileApiPath = @"mobile";

#pragma mark - Helpers

@implementation AIKNetworkMobilePathCommand

- (NSString *)path {
    return mobileApiPath;
}

@end

@interface NSString (Base64Encoding)
- (NSString *)base64String;
@end

@implementation NSString (Base64Encoding)

- (NSString *)base64String {
    return self;
}

@end

@implementation AIKNetworkCommandConvenientPasswords

- (NSString *)password {
    return self[@"Password"];
}

- (void)setPassword:(NSString *)password {
    self[@"Password"] = [password base64String];
}

- (NSString *)pastPassword {
    return self[@"OldPassword"];
}

- (void)setPastPassword:(NSString *)pastPassword {
    self[@"OldPassword"] = [pastPassword base64String];
}

- (NSString *)futurePassword {
    return self[@"NewPassword"];
}

- (void)setFuturePassword:(NSString *)futurePassword {
    self[@"NewPassword"] = [futurePassword base64String];
}

@end

#pragma mark - Custom

@implementation AIKNetworkCommandLogin

//POST
//Unauthorized
//{
//    "Action" : "Login",
//    "PhoneNumber" : "8 999123-45-67",
//    "Password" : "UEBzc3dvb3Jk"
//}

- (NSString *)action {
    return @"Login";
}

- (BOOL)authorized {
    return NO;
}

- (NSDictionary *)queryParams {
    NSString *passwordParameterName = @"Password";
    NSString *phoneNumberParameterName = @"PhoneNumber";

    NSDictionary *params = [super queryParams];

    NSMutableDictionary *queryParams = [params mutableCopy];

    queryParams[phoneNumberParameterName] = self.phoneNumber;
    queryParams[passwordParameterName] = self.password;

    return [queryParams copy];
}

- (NSString *)type {
    return HTTPOperationTypePOST;
}

@end

@implementation AIKNetworkCommandChangePassword

- (NSString *)action {
    return @"ChangePassword";
}

- (BOOL)authorized {
    return YES;
}

- (NSDictionary *)queryParams {
    NSString *pastPasswordParameterName = @"OldPassword";
    NSString *futurePasswordParameterName = @"NewPassword";

    NSDictionary *params = [super queryParams];

    NSMutableDictionary *queryParams = [params mutableCopy];

    queryParams[pastPasswordParameterName] = self.pastPassword;
    queryParams[futurePasswordParameterName] = self.futurePassword;
    return [queryParams copy];
}

- (NSString *)type {
    return HTTPOperationTypePOST;
}

@end

@implementation AIKNetworkCommandRestorePassword

- (NSString *)action {
    return @"RestorePassword";
}

- (BOOL)authorized {
    return NO;
}

- (NSDictionary *)queryParams {
    NSString *phoneNumberParameterName = @"PhoneNumber";

    NSDictionary *params = [super queryParams];

    NSMutableDictionary *queryParams = [params mutableCopy];

    queryParams[phoneNumberParameterName] = self.phoneNumber;

    return [queryParams copy];
}

- (NSString *)type {
    return HTTPOperationTypePOST;
}

@end

//GET
//Authorized
//{
//    "Action" : "GetUserProfile",
//}

@implementation AIKNetworkCommandGetUserProfile

- (NSString *)action {
    return @"GetUserProfile";
}

- (BOOL)authorized {
    return YES;
}

- (NSString *)type {
    return HTTPOperationTypeGET;
}

@end
