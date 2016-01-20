//
//  AIKBaseDictionaryStorage.h
//  Airkey
//
//  Created by Lobanov Dmitry on 03.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, BaseDictionaryStorageInitOptions) {
    initOptionsStorageTypeNSDictionary = 1 << 0,
    initOptionsStorageTypeNSMapTableWeakToWeak = 1 << 1
};

@interface AIKBaseDictionaryStorage : NSObject

#pragma mark - Subscription

- (instancetype)initWithOptions:(BaseDictionaryStorageInitOptions)options;

- (id)objectForKeyedSubscript:(id <NSCopying>)key;

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

#pragma mark - Getters / Setters

@property(nonatomic, strong) NSDictionary *items;

- (void)setItem:(id)item forKey:(id <NSCopying>)key;

- (id)itemForKey:(id <NSCopying>)key;

- (void)removeItemForKey:(id <NSCopying>)key;

@end
