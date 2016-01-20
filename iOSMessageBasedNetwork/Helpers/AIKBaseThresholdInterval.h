//
//  AIKBaseThresholdInterval.h
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 04.12.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @class AIKBaseThresholdInterval
 *
 * @discussion This class take care about borders.
 *
 */
@interface AIKBaseThresholdInterval : NSObject

/*!
 *  @property minimum
 *
 *  @discussion The minimum value of a border. Could be nil
 *
 *  @see <code>minimum</code>
 */
@property(strong, nonatomic) NSNumber *minimum;

/*!
 *  @property maximum
 *
 *  @discussion The maximum value of a border. Could be nil
 *
 *  @seealso minimum
 */
@property(strong, nonatomic) NSNumber *maximum;

/*!
 *  @property labelName
 *
 *  @discussion The title label of threshold. Could be used for determining threshold for debug purposes
 *
 */
@property(strong, nonatomic) NSString *labelName;

- (BOOL)belowMinimum:(NSNumber *)value;

- (BOOL)aboveMaximum:(NSNumber *)value;

- (BOOL)between:(NSNumber *)value;

#pragma mark - Inspection

- (NSString *)stringBetween:(NSNumber *)value;

- (BOOL)descriptiveBetween:(NSNumber *)value;

@end
