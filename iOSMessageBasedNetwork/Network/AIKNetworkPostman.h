//
// Created by Lobanov Dmitry on 23.10.15.
// Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIKNetworkCommand.h"

@interface AIKNetworkPostman : NSObject

+ (instancetype)postman;
- (void)setup;

#pragma mark - Send
- (void)sendMail:(AIKNetworkCommand *)mail;
- (void)sendMails:(NSArray *)mails;
@end