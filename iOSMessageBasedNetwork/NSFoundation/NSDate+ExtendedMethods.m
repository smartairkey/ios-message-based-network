//
//  NSDate+ExtendedMethods.m
//  Airkey
//
//  Created by Lobanov Dmitry on 22.06.15.
//  Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "NSDate+ExtendedMethods.h"

@implementation NSDate (ExtendedMethods)

+ (NSUInteger)units:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
    NSCalendar *gregorianCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [gregorianCalendar components:unit
                                                        fromDate:fromDate
                                                          toDate:toDate
                                                         options:NSCalendarWrapComponents];
    return [components valueForComponent:unit];
}

- (NSUInteger)units:(NSCalendarUnit)unit toDate:(NSDate *)toDate {
    return [self.class units:unit fromDate:self toDate:toDate];
}

- (NSUInteger)units:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate {
    return [self.class units:unit fromDate:fromDate toDate:self];
}

+ (NSDate *)takeMinimumDateBetweenFirst:(NSDate *)first andSecond:(NSDate *)second {
    if (first == nil) {
        return second;
    }
    
    if (second == nil) {
        return first;
    }
    
    
    BOOL isSecondMaximum = [first compare:second] == NSOrderedAscending;
    
    NSDate *result = isSecondMaximum ? first : second;
    
    return result;
}

+ (NSDate *)dateFromDate:(NSDate *)fromDate byAddingAmount:(NSInteger)amount ofUnits:(NSCalendarUnit)unit {
    return [[NSCalendar currentCalendar] dateByAddingUnit:unit value:amount toDate:fromDate options:0];
}

- (NSDate *)dateByAddingAmount:(NSInteger)amount ofUnits:(NSCalendarUnit)unit {
    return [self.class dateFromDate:self byAddingAmount:amount ofUnits:unit];
}

@end
