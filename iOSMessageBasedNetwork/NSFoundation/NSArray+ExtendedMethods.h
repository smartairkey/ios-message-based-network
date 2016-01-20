//
//  NSArray+ExtendedMethods.h
//  Buro 247
//
//  Created by Dmitry Lobanov on 12.12.14.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+ExtendedMethods.h"

@interface NSArray (ExtendedMethods)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

- (NSArray *)compactObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

- (id)accumulateObjectsUsingBlock:(id (^)(id accumulatedValue, id obj, NSUInteger idx))block withInitialValue:(id)initialValue;

- (id)firstObjectPassingTest:(BOOL (^)(id obj, NSUInteger idx, BOOL *stop))block;

@property(nonatomic, readonly) NSArray *compactArray;

- (NSArray *)arrayByRemovingObject:(NSObject *)object;

- (NSArray *)arrayByInsertingObject:(id)anObject atIndex:(NSUInteger)index;
//Examples:
//id accumulate =
//[@[@1,@3,@5,@3,@6] accumulateObjectsUsingBlock:^id(id accumulatedValue, id obj, NSUInteger idx) {
//    return @([(NSNumber*) obj integerValue] * [(NSNumber*)accumulatedValue integerValue]);
//} withInitialValue:@1];
//DLog(@"I have mult: %@",(NSNumber*)accumulate);
// I have mult 270 = 3 * 5 * 3 * 6 = 9 * 30 = 270
@end
