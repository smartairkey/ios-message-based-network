//
//  AIKBaseThresholdInterval.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 04.12.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

#import "AIKBaseThresholdInterval.h"
#import "NSFoundationExtendedMethods.h"

static const DDLogLevel ddLogLevel = DDLogLevelDebug;

@implementation AIKBaseThresholdInterval

- (BOOL)belowMinimum:(NSNumber *)value {
    
    if (!value) {
        return NO;
    }
    
    
    // value exists but minimum does not exists
    if (!self.minimum) {
        return YES;
    }
    
    // value <= minimum : not descending
    return [value compare:self.minimum] != NSOrderedDescending;
}

- (BOOL)between:(NSNumber *)value {
    
    // nil is not a number :3
    if (!value) {
        return NO;
    }
    
    // (minimum value maximum]
    if (self.maximum && self.minimum) {
        // both exists
        
        // value > minimum : descending
        // value <= maximum : not descending
        return [value compare:self.minimum] == NSOrderedDescending &&
        [value compare:self.maximum] != NSOrderedDescending;
    }
    
    // inf<- value ->inf
    if (!self.maximum && !self.minimum) {
        return YES;
    }
    
    // inf<- value maximum]
    if (!self.minimum) {
        // check for maximum
        // value <= maximum : not descending
        return [value compare:self.maximum] != NSOrderedDescending;
    }
    
    // (minimum value -> inf
    if (!self.maximum) {
        // check for minimum
        // value > minimum : descending
        return [value compare:self.minimum] == NSOrderedDescending;
    }
    
    return NO;
}

- (BOOL)aboveMaximum:(NSNumber *)value {
    
    if (!value) {
        return NO;
    }
    
    // value exists but minimum does not exists
    if (!self.maximum) {
        return YES;
    }
    
    // value > maximum : descending
    return [value compare:self.maximum] == NSOrderedDescending;
}

#pragma mark - Inspection

- (NSString *)stringMinimum {
    return self.minimum ? [NSString stringWithFormat:@"%.4f",self.minimum.floatValue] : @"-INF";
}

- (NSString *)stringMaximum {
    return self.maximum ? [NSString stringWithFormat:@"%.4f",self.maximum.floatValue] : @"+INF";
}

- (NSString *)stringBetween:(NSNumber *)value {
    NSString *formattedString = [NSString stringWithFormat:@"%@ have %@ < %@ <= %@", [NSString takeVisibleString:self.labelName orAlternative:NSStringFromClass(self.class)], [self stringMinimum], value, [self stringMaximum]];
    return formattedString;
}

- (BOOL)descriptiveBetween:(NSNumber *)value {
    DDLogDebug(@"%@", [self stringBetween:value]);
    return [self between:value];
}

@end
