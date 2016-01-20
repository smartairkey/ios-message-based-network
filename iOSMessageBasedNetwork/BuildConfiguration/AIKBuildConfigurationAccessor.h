//
//  AIKBuildConfigurationAccessor.h
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 09.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIKBuildConfigurationAccessor : NSObject

#pragma mark - Network

+ (NSString *)networkServerAddress;

+ (NSString *)networkServerPort;

+ (NSString *)networkServerFullAddress;

#pragma mark - Config

+ (NSString *)bundleShortVersionString;

+ (NSString *)bundleVersion;

+ (NSString *)configBuildConfigName;

+ (BOOL)debugOrBetaBuild;

+ (NSString *)configVersioningSuffix;

@end
