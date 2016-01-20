//
// Created by Lobanov Dmitry on 17.09.15.
// Copyright (c) 2015 AirkeyTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSPointerArray (ExtendedMethods)

- (NSUInteger)firstIndexOfPointer:(void *)pointer;
- (BOOL) removePointerEqualsTo:(void *)pointer;
- (BOOL) compactAndRemovePointerEqualsTo:(void *)pointer;

@end