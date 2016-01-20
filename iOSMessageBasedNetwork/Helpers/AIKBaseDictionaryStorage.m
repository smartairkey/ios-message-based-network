//
//  AIKBaseDictionaryStorage.m
//  Airkey
//
//  Created by Lobanov Dmitry on 03.08.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "AIKBaseDictionaryStorage.h"

@implementation AIKBaseDictionaryStorage

- (instancetype)initWithOptions:(BaseDictionaryStorageInitOptions)options {
    self = [super init];
    if (self) {
        _items = options & initOptionsStorageTypeNSMapTableWeakToWeak ? (NSDictionary *)[NSMapTable weakToWeakObjectsMapTable] : [NSDictionary new];
    }
    return self;
}

#pragma mark - Subscription

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
    return [self itemForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
    [self setItem:obj forKey:key];
}

#pragma mark - Getters / Setters

- (NSDictionary *)items {
    if (!_items) {
        _items = [NSDictionary new];
    }
    return _items;
}

- (void)setItem:(id)item forKey:(id <NSCopying>)key {
    
    if (!key) {
        return;
    }
    
    if (!item) {
        [self removeItemForKey:key];
        return;
    }

    NSMutableDictionary *items = [self.items mutableCopy];
    items[key] = item;
    self.items = [items copy];
}

- (id)itemForKey:(id <NSCopying>)key {
    
    if (!key) {
        return nil;
    }
    
    return self.items[key];
}

- (void)removeItemForKey:(id <NSCopying>)key {
    
    if (!key) {
        return;
    }
    
    NSMutableDictionary *items = [self.items mutableCopy];
    [items removeObjectForKey:key];
    self.items = [items copy];
}


@end
