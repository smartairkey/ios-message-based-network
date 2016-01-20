//
//  NSDictionary+ExtendedMethods.m
//  SmartAirkey
//
//  Created by Lobanov Dmitry on 08.10.15.
//  Copyright © 2015 AirkeyTeam. All rights reserved.
//

#import "NSDictionary+ExtendedMethods.h"

@implementation NSDictionary (ExtendedMethods)

@end

@implementation NSDictionary (ImmerseComparasion)

- (BOOL)isImmersedIntoParent:(NSDictionary *)parent {
    return [self.class isChild:self immersedIntoParent:parent];
}

+ (BOOL)isChild:(NSDictionary *)child immersedIntoParent:(NSDictionary *)parent {
    return [child.allKeys indexOfObjectPassingTest:^BOOL(NSString *obj, NSUInteger idx, BOOL *stop) {
        return ![child[obj] isEqualToString:parent[obj]];
    }] == NSNotFound;
}

@end