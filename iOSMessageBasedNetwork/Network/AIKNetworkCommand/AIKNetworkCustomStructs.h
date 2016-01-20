//
//  AIKNetworkCustomStructs.h
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 13.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AIKBaseDictionaryStorage.h"

@interface AIKNetworkCustomStructs : NSObject

@end

@interface AIKNetworkCustomStruct : AIKBaseDictionaryStorage

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (copy, nonatomic) NSDictionary *dictionary;

- (NSDictionary *)filterDictionary:(NSDictionary *)dictionary;
- (NSArray *)necessaryKeysInDictionary:(NSDictionary *)dictionary;
- (void) afterDidSetDictionary:(NSDictionary *)dictionary;
@end

@interface AIKNetworkGestures : AIKNetworkCustomStruct

@property (copy, nonatomic) NSNumber *useMethod1;
@property (copy, nonatomic) NSNumber *useMethod2;

@end

@interface AIKNetworkOnMoving : AIKNetworkCustomStruct

@property (copy, nonatomic) NSNumber *autoOpen;
@property (copy, nonatomic) NSNumber *autoClose;
@property (copy, nonatomic) NSNumber *activeDistance;

@end

@interface AIKNetworkConnectivity : AIKNetworkCustomStruct

@property (copy, nonatomic) AIKNetworkOnMoving *onMoving;
@property (copy, nonatomic) AIKNetworkGestures *gestures;
@property (copy, nonatomic) NSNumber *activeTime;

@end

@interface AIKNetworkMetadata : AIKNetworkCustomStruct

@property (copy, nonatomic) NSString *title;

@end

@interface AIKNetworkPayment : AIKNetworkCustomStruct

@property (copy, nonatomic) NSNumber *value;
@property (copy, nonatomic) NSString *currency;

@end