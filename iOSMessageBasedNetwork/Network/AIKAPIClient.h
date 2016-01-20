//
//  AKIAPIClient.h
//  Airkey
//
//  Created by Alexandr Novikov on 16.06.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIKNetworkCommand.h"

typedef void (^AIKAPIClientSuccessBlock)(id responseObject);

typedef void (^AIKAPIClientErrorBlock)(NSError *error);

typedef void (^AIKAPIClientNoNetworkBlock)(AIKNetworkCommand *command);

@interface AIKAPIClient : NSObject

+ (instancetype)sharedInstance;

#pragma mark - Accessors

@property(nonatomic, readonly) NSString *apiKey;
@property(nonatomic, readonly) NSString *token;
@property(nonatomic, readonly) BOOL networkIsReady;
@property(nonatomic, readonly) NSError *noConnectionError;

- (void)startNetworkMonitoring;

#pragma mark - Available Now
#pragma mark - Executing

- (void)executeCommand:(AIKNetworkCommand *)command
          inBackground:(BOOL)background
          successBlock:(AIKAPIClientSuccessBlock)successBlock
            errorBlock:(AIKAPIClientErrorBlock)errorBlock;

- (void)executeCommand:(AIKNetworkCommand *)command
          successBlock:(AIKAPIClientSuccessBlock)successBlock
            errorBlock:(AIKAPIClientErrorBlock)errorBlock;

- (void)executeCommandRemotely:(AIKNetworkCommand *)command
                  successBlock:(AIKAPIClientSuccessBlock)successBlock
                    errorBlock:(AIKAPIClientErrorBlock)errorBlock
                noNetworkBlock:(AIKAPIClientNoNetworkBlock)noNetworkBlock;

@end
