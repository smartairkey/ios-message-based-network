//
//  AIKAPIClientReachabilityMonitor.h
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 21.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIKAPIClientReachabilityMonitor : NSObject

- (instancetype)initWithBaseDomain:(NSString *)baseDomain;

@property (nonatomic, readonly) BOOL reachable;
@property (copy, nonatomic) NSString *baseDomain;

#pragma mark - Monitoring

- (void)startMonitoring;

@end
