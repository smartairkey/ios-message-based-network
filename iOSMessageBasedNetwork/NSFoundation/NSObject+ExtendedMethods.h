//
//  NSObject+NSObject_ExtendedMethods.h
//  Buro 247
//
//  Created by Lobanov Dmitry on 09.07.14.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (ExtendedMethods)

- (NSData *)jsonData;

+ (NSData *)jsonDataFromObject:(NSObject *)object;

- (NSString *)jsonString;

+ (NSString *)jsonStringFromObject:(NSObject *)object;

- (instancetype)weakSelf;

- (BOOL)isNotNull;

+ (BOOL)isObjectNotNull:(NSObject *)object;

+ (BOOL)isObjectNull:(NSObject *)object;

@end
