//
//  AIKBuildConfigurationAccessor.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 09.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import "AIKBuildConfigurationAccessor.h"
#import "NSFoundationExtendedMethods.h"

@implementation AIKBuildConfigurationAccessor

+ (NSDictionary *)userDefinedSettings {
    return [[NSBundle mainBundle] infoDictionary][@"UserDefinedSettings"];
}

+ (NSDictionary *)network {
    return [self userDefinedSettings][@"Network"];
}

+ (NSDictionary *)config {
    return [self userDefinedSettings][@"Config"];
}

+ (NSDictionary *)services {
    return [self userDefinedSettings][@"Services"];
}

+ (NSDictionary *)build {
    return [self config][@"Build"];
}

+ (NSDictionary *)versioning {
    return [self config][@"Versioning"];
}

#pragma mark - Network

+ (NSString *)networkServerAddress {
    return [self network][@"ServerAddress"];
}

+ (NSString *)networkServerPort {
    return [self network][@"ServerPort"];
}

+ (NSString *)networkServerFullAddress {
    return [NSString visibleStrings:@[[self networkServerAddress], [self networkServerPort]] joinedByString:@":"];
}

#pragma mark - Config

+ (NSString *)bundleShortVersionString {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)bundleVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)configBuildConfigName {
    return [self build][@"ConfigName"];
}

+ (BOOL)debugOrBetaBuild {
    return ![[self configBuildConfigName] isEqualToString:@"Release"];
}

+ (NSString *)configVersioningSuffix {
    return [self versioning][@"Suffix"];
}

@end
