//
//  AIKNetworkCustomCommands.h
//  Airkey
//
//  Created by Lobanov Dmitry on 13.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIKNetworkCommand.h"
#import "AIKNetworkCustomStructs.h"
#pragma mark - Helpers

@interface AIKNetworkMobilePathCommand : AIKNetworkCommand

@end

@interface AIKNetworkCommandConvenientPasswords : AIKNetworkMobilePathCommand

@property(nonatomic, strong) NSString *password;
@property(nonatomic, strong) NSString *pastPassword;
@property(nonatomic, strong) NSString *futurePassword;

@end

#pragma mark - Custom

@interface AIKNetworkCommandLogin : AIKNetworkCommandConvenientPasswords

@property(nonatomic, strong) NSString *phoneNumber;

@end

@interface AIKNetworkCommandChangePassword : AIKNetworkCommandConvenientPasswords

@property(nonatomic, strong) NSString *email;

@end

@interface AIKNetworkCommandRestorePassword : AIKNetworkCommandConvenientPasswords

@property(nonatomic, strong) NSString *phoneNumber;

@end

@interface AIKNetworkCommandGetUserProfile : AIKNetworkMobilePathCommand

@end