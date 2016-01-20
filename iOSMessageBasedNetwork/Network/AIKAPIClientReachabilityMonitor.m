//
//  AIKAPIClientReachabilityMonitor.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 21.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <AFNetworking/AFNetworkReachabilityManager.h>

#import "AIKAPIClientReachabilityMonitor.h"

@interface AIKAPIClientReachabilityMonitor ()

@property (nonatomic, strong) AFNetworkReachabilityManager *manager;

@end

@implementation AIKAPIClientReachabilityMonitor

#pragma mark - Instantiation
- (instancetype)initWithBaseDomain:(NSString *)baseDomain {
    self = [super init];
    if (self) {
        self.baseDomain = baseDomain;
    }
    return self;
}

#pragma mark - Getters
- (void)setBaseDomain:(NSString *)baseDomain {
    _baseDomain = baseDomain;
    self.manager = [AFNetworkReachabilityManager managerForDomain:baseDomain];
}

- (BOOL)reachable {
    return self.manager.reachable;
}

#pragma mark - Monitoring
- (void)startMonitoring {
    [self.manager startMonitoring];
}

@end
