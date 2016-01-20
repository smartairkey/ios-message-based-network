//
//  AIKNetworkCustomStructs.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 13.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import "AIKNetworkCustomStructs.h"

@implementation AIKNetworkCustomStructs

@end

@implementation AIKNetworkCustomStruct

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithOptions:0];
    if (self) {
        self.dictionary = dictionary;
    }
    return self;
}

- (NSDictionary *)dictionary {
    return self.items;
}

- (void)setDictionary:(NSDictionary *)dictionary {
    self.items = [self filterDictionary:dictionary];
    [self afterDidSetDictionary:dictionary];
}

- (NSDictionary *)filterDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *result = [[dictionary dictionaryWithValuesForKeys:[self necessaryKeysInDictionary:dictionary]] mutableCopy];
    [result removeObjectsForKeys:[result allKeysForObject:[NSNull null]]];
    return [result copy];
}

- (NSArray *)necessaryKeysInDictionary:(NSDictionary *)dictionary {
    return dictionary.allKeys;
}

- (void)afterDidSetDictionary:(NSDictionary *)dictionary {
    return;
}

@end

@implementation AIKNetworkGestures

- (NSNumber *)useMethod1 {
	return self[@"useMethod1"];
}

- (void)setUseMethod1:(NSNumber *)useMethod1 {
	self[@"useMethod1"] = @(useMethod1.boolValue);
}

- (NSNumber *)useMethod2 {
	return self[@"useMethod2"];
}

- (void)setUseMethod2:(NSNumber *)useMethod2 {
	self[@"useMethod2"] = @(useMethod2.boolValue);
}

- (NSArray *)necessaryKeysInDictionary:(NSDictionary *)dictionary {
    return @[@"useMethod1", @"useMethod2"];
}

- (void) afterDidSetDictionary:(NSDictionary *)dictionary {
    [super afterDidSetDictionary:dictionary];
    self.useMethod1 = self.useMethod1;
    self.useMethod2 = self.useMethod2;
}

@end

@implementation AIKNetworkOnMoving

- (NSNumber *)autoOpen {
	return self[@"autoOpen"];
}

- (void)setAutoOpen:(NSNumber *)autoOpen {
	self[@"autoOpen"] = @(autoOpen.boolValue);
}

- (NSNumber *)autoClose {
	return self[@"autoClose"];
}

- (void)setAutoClose:(NSNumber *)autoClose {
	self[@"autoClose"] = @(autoClose.boolValue);
}

- (NSNumber *)activeDistance {
	return self[@"activeDistance"];
}

- (void)setActiveDistance:(NSNumber *)activeDistance {
	self[@"activeDistance"] = @(ceil(activeDistance.integerValue));
}

- (NSArray *)necessaryKeysInDictionary:(NSDictionary *)dictionary {
    return @[@"autoOpen", @"autoClose", @"activeDistance"];
}

- (void)afterDidSetDictionary:(NSDictionary *)dictionary {
    [super afterDidSetDictionary:dictionary];
    self.autoOpen = self.autoOpen;
    self.autoClose = self.autoClose;
    self.activeDistance = self.activeDistance;
}

@end

@implementation AIKNetworkConnectivity

- (AIKNetworkOnMoving *)onMoving {
	return [[AIKNetworkOnMoving alloc] initWithDictionary:self[@"onMoving"]];
}

- (void)setOnMoving:(AIKNetworkOnMoving *)onMoving {
	self[@"onMoving"] = onMoving.dictionary;
}

- (AIKNetworkGestures *)gestures {
	return [[AIKNetworkGestures alloc] initWithDictionary:self[@"gestures"]];
}

- (void)setGestures:(AIKNetworkGestures *)gestures {
	self[@"gestures"] = gestures.dictionary;
}

- (NSNumber *)activeTime {
	return self[@"activeTime"];
}

- (void)setActiveTime:(NSNumber *)activeTime {
	self[@"activeTime"] = @(ceil(activeTime.integerValue));
}

- (NSArray *)necessaryKeysInDictionary:(NSDictionary *)dictionary {
    return @[@"onMoving", @"gestures", @"activeTime"];
}

- (void)afterDidSetDictionary:(NSDictionary *)dictionary {
    [super afterDidSetDictionary:dictionary];
    self.onMoving = [[AIKNetworkOnMoving alloc] initWithDictionary:dictionary];
    self.gestures = [[AIKNetworkGestures alloc] initWithDictionary:dictionary];
    self.activeTime = self.activeTime;
}

@end

@implementation AIKNetworkMetadata

- (NSString *)title {
	return self[@"title"];
}

- (void)setTitle:(NSString *)title {
	self[@"title"] = title;
}

- (NSArray *)necessaryKeysInDictionary:(NSDictionary *)dictionary {
    return @[@"title"];
}

- (void)afterDidSetDictionary:(NSDictionary *)dictionary {
    [super afterDidSetDictionary:dictionary];
    self.title = self.title;
}

@end

@implementation AIKNetworkPayment

- (NSNumber *)value {
    return self[@"value"];
}

- (void)setValue:(NSNumber *)value {
    self[@"value"] = value;
}

- (NSString *)currency {
    return self[@"currency"];
}

- (void)setCurrency:(NSString *)currency {
    self[@"currency"] = currency;
}

- (NSArray *)necessaryKeysInDictionary:(NSDictionary *)dictionary {
    return @[@"value", @"currency"];
}

- (void)afterDidSetDictionary:(NSDictionary *)dictionary {
    [super afterDidSetDictionary:dictionary];
    self.value = self.value;
    self.currency = self.currency;
}

@end

