//
// Created by Lobanov Dmitry on 17.09.15.
// Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import "NSPointerArray+ExtendedMethods.h"


@implementation NSPointerArray (ExtendedMethods)

- (NSUInteger)firstIndexOfPointer:(void *)pointer {
    NSUInteger result = NSNotFound;
    for (NSUInteger i = 0; i < self.count; ++i) {
        if (pointer == [self pointerAtIndex:i]) {
            result = i;
            break;
        }
    }
    return result;
}

- (BOOL) removePointerEqualsTo:(void *)pointer {
    NSUInteger index = [self firstIndexOfPointer:pointer];
    BOOL result = index != NSNotFound;
    if (result) {
        [self removePointerAtIndex:index];
    }
    return result;
}

- (BOOL) compactAndRemovePointerEqualsTo:(void *)pointer {
    BOOL result = [self removePointerEqualsTo:pointer];
    [self compact];
    return result;
}


@end