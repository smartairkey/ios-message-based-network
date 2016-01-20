//
//  AIKAPIClientCommandSerializer.h
//  Airkey
//
//  Created by Lobanov Dmitry on 13.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIKNetworkCommand.h"

@interface AIKNetworkCommandSerializer : NSObject

+ (NSString *)serialize:(AIKNetworkCommand *)command;

+ (AIKNetworkCommand *)deserialize:(NSString *)string;

@end
