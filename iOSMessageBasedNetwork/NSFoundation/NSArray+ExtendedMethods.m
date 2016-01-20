//
//  NSArray+ExtendedMethods.m
//  Buro 247
//
//  Created by Dmitry Lobanov on 12.12.14.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+ExtendedMethods.h"

@implementation NSArray (ExtendedMethods)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {

    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        [result addObject:block(obj, idx)];

    }];

    return result;
}

// remove null and 'nil' from block
- (NSArray *)compactObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        NSObject *resultObject = (NSObject *) (block(obj, idx));
        if ([resultObject isNotNull]) {
            result[result.count] = resultObject;
        }

    }];
    return result;
}


- (id)accumulateObjectsUsingBlock:(id (^)(id accumulatedValue, id obj, NSUInteger idx))block withInitialValue:(id)initialValue {
    // do something with default value
    __block id accumulatedValue = initialValue ? initialValue : nil;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block) {
            accumulatedValue = block(accumulatedValue, obj, idx);
        }
    }];
    return accumulatedValue;
}

- (id)firstObjectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))block {
    NSUInteger index = [self indexOfObjectPassingTest:block];
    return index == NSNotFound ? nil : self[index];
}

- (NSArray *)compactArray {
    return [self compactObjectsUsingBlock:^id(id obj, NSUInteger idx) {
        return obj;
    }];
}

- (NSArray *)arrayByRemovingObject:(NSObject *)object {
    NSMutableArray *mutableArray = [self mutableCopy];
    [mutableArray removeObject:object];
    return [NSArray arrayWithArray:mutableArray];
}

- (NSArray *)arrayByInsertingObject:(id)anObject atIndex:(NSUInteger)index {
    NSMutableArray *mutableArray = [self mutableCopy];
    [mutableArray insertObject:anObject atIndex:index];
    return mutableArray;
}

@end
