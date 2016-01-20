//
//  NSOperationQueue+ExtendedMethods.h
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 12.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (ExtendedMethods)

- (void)addOperation:(NSOperation *)op withDelayInNanoseconds:(int64_t)nanoseconds;

@end
