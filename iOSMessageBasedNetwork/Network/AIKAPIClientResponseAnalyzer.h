//
//  AIKAPIClientResponseAnalyzer.h
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 14.09.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIKAPIClientResponseAnalyzer : NSObject

@property (copy, nonatomic) NSString *hasCredentialsContextAttribute;
@property (copy, nonatomic) NSString *domainReachableContextAttribute;
@property (copy, nonatomic) NSString *backgroundOperationContextAttribute;

- (NSError *)analyzeResponseWithOperation:(NSURLSessionDataTask *)operation withContext:(NSDictionary *)context withParameters:(NSDictionary *)parameters withError:(NSError *)error;

- (NSError *)analyzeResponseWithOperation:(NSURLSessionDataTask *)operation withContext:(NSDictionary *)context withParameters:(NSDictionary *)parameters;

@end
