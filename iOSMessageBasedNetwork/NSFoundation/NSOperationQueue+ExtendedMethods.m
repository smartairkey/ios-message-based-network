//
//  NSOperationQueue+ExtendedMethods.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 12.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import "NSOperationQueue+ExtendedMethods.h"

@implementation NSOperationQueue (ExtendedMethods)

- (void)addOperation:(NSOperation *)op withDelayInNanoseconds:(int64_t)nanoseconds {
    int64_t timeInterval = (int64_t)nanoseconds;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, timeInterval), dispatch_get_main_queue(), ^{
        [self addOperation:op];
    });
}

@end
