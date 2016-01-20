//
//  AIKAPIClientCommandFactory.m
//  Airkey
//
//  Created by Lobanov Dmitry on 13.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "AIKNetworkCommandFactory.h"
#import "AIKNetworkCustomCommands.h"
#import "NSFoundationExtendedMethods.h"

static NSDictionary *commandsDictionary = nil;

@implementation AIKNetworkCommandFactory

+ (NSDictionary *)createCommandsDictionary {
    NSDictionary *resultDictionary = nil;

    NSArray *allCommands =
            @[[AIKNetworkCommandLogin new],
                    [AIKNetworkCommandRestorePassword new],
                    [AIKNetworkCommandGetUserProfile new],
            ];

    resultDictionary = [allCommands accumulateObjectsUsingBlock:^id(NSDictionary *accumulatedValue, AIKNetworkCommand *obj, NSUInteger idx) {

        NSMutableDictionary *value = [accumulatedValue mutableCopy];

        value[obj.action] = obj;

        accumulatedValue = [value copy];

        return accumulatedValue;
    } withInitialValue:@{}];

    return resultDictionary;
}

+ (NSDictionary *)commandsDictionary {
    if (!commandsDictionary) {
        commandsDictionary = [self createCommandsDictionary];
    }
    return commandsDictionary;
}

+ (AIKNetworkCommand *)commandByAction:(NSString *)action andParameters:(NSDictionary *)parameters {
    AIKNetworkCommand *command = [self commandsDictionary][action];
    return [command initWithDictionary:parameters];
}

@end
