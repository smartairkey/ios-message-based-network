//
//  AIKAPIClientCommand.h
//  Airkey
//
//  Created by Lobanov Dmitry on 11.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIKNetworkCommand : NSObject

#pragma mark - Subscription

- (id)objectForKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@property(nonatomic, readonly) NSError *shouldStopError;
@property(nonatomic, readonly) BOOL shouldStop;
@property(copy, nonatomic) NSString *shouldStopMessage;
@property(nonatomic, readonly) NSString *action;
@property(nonatomic, readonly) BOOL authorized;
@property(nonatomic, readonly) NSString *path;
@property(nonatomic, readonly) NSString *type;

// query parameters - used only by api client
@property(nonatomic, readonly) NSDictionary *queryParams;

// parameters - used for serialization

@property(nonatomic, readonly) NSDictionary *serialized;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end