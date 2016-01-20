//
//  NSNumber+ExtendedMethods.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 03.12.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import "NSNumber+ExtendedMethods.h"

@implementation NSNumber (ExtendedMethods)

+ (NSNumber *)numberFromString:(NSString *)string {
    // take only digits:
    NSString *newString = string;
    NSArray *allDigits = [newString componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    
    NSString *onlyDigits = [allDigits componentsJoinedByString:@""];
    NSNumber *number = @(onlyDigits.longLongValue);
    
    return number;
}


@end
