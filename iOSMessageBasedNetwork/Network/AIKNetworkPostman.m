//
// Created by Lobanov Dmitry on 23.10.15.
// Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "AIKNetworkPostman.h"

#import "AIKAPIClient.h"
#import <LITEventMachine/LITEMEventMachine.h>

@interface AIKNetworkPostman() <LITEMBaseListenerProtocol>

@end

@implementation AIKNetworkPostman

#pragma mark - Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
//        [self setup];
    }
    return self;
}

#pragma mark - Setup
- (void)setup {
    // subscribe, for example, on LITEMEventBase
    [[LITEMEventMachine eventMachine].eventBus subscribeDelegate:self withName:NSStringFromClass(self.class) onEvent:[LITEMEventBase new]];
}

#pragma mark - Shared Instance
+ (instancetype)postman {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });

    return sharedInstance;
}

#pragma mark - Send
- (void)sendMail:(AIKNetworkCommand *)mail {
    [[AIKAPIClient sharedInstance] executeCommand:mail successBlock:nil errorBlock:nil];
}

- (void)sendMails:(NSArray *)mails {
    for (AIKNetworkCommand *mail in mails) {
        [self sendMail:mail];
    }
}

#pragma mark - Delegate / EventMachine
- (void)emListenEvent:(LITEMEventBase *)event {
    if (event.class == [LITEMEventBase class]) {
        // do something when somebody send message to get something from network
    }
}

@end