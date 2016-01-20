//
//  AIKAPIClientCommandSerializer.m
//  Airkey
//
//  Created by Lobanov Dmitry on 13.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "AIKNetworkCommandSerializer.h"
#import "AIKNetworkCommandFactory.h"

#import "NSFoundationExtendedMethods.h"

@implementation AIKNetworkCommandSerializer

+ (NSString *)serialize:(AIKNetworkCommand *)command {
    NSString *resultString = nil;

    NSDictionary *serialized = command.serialized;
    NSString *action = [NSString takeVisibleStringOrEmptyOtherwise:command.action];

    NSDictionary *descriptionDictionary =
            @{
                    @"serialized" : serialized ? serialized : @{},
                    @"action" : action,
            };

    resultString = [descriptionDictionary jsonString];

    return resultString;
}

+ (AIKNetworkCommand *)deserialize:(NSString *)string {
    NSDictionary *descriptionDictionary = (NSDictionary *) [string jsonObject];

    if (![descriptionDictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }

    NSDictionary *serialized = descriptionDictionary[@"serialized"];
    NSString *action = descriptionDictionary[@"action"];

    AIKNetworkCommand *command = [AIKNetworkCommandFactory commandByAction:action andParameters:serialized];

    // choose right command here
    return command;
}

@end
