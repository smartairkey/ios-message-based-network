//
//  NSManagedObject+ExtendedMethods.h
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 06.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ExtendedMethods)

+ (NSDictionary *)dictionaryDescriptionForObject:(NSManagedObject *)obj;
- (NSDictionary *)dictionaryDescription;

@end
