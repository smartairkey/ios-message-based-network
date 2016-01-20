//
//  NSManagedObject+ExtendedMethods.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 06.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import "NSManagedObject+ExtendedMethods.h"

@implementation NSManagedObject (ExtendedMethods)

+ (NSDictionary *)dictionaryDescriptionForObject:(NSManagedObject *)obj {
    NSArray *keys = [[[obj entity] attributesByName] allKeys];
    NSDictionary *dict = [obj dictionaryWithValuesForKeys:keys];
    return dict;
}

- (NSDictionary *)dictionaryDescription {
    NSManagedObject *obj = self;
    return [self.class dictionaryDescriptionForObject:obj];
}

@end
