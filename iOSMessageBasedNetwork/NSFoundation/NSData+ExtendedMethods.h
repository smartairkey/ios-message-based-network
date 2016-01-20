//
//  NSData+ExtendedMethods.h
//  Buro 247
//
//  Created by Dmitry Lobanov on 12.12.14.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+ExtendedMethods.h"

@interface NSData (ExtendedMethods)
#pragma mark - JSON Serialization

- (NSObject *)jsonObject;

+ (NSObject *)jsonObjectFromData:(NSData *)data;

#pragma mark - Class Jumping

// thanks for answer: http://stackoverflow.com/questions/1305225/best-way-to-serialize-a-nsdata-into-an-hexadeximal-string
+ (NSString *)hexadecimalStringFromData:(NSData *)data;
@property(nonatomic, readonly) NSString *hexadecimalString;

#pragma mark - Number conversions
+ (NSInteger)integerFromData:(NSData *)data;
+ (NSData *)dataFromInteger:(NSInteger)value;
@property(nonatomic, readonly) NSInteger integerValue;

+ (SInt8)int8FromData:(NSData *)data;
+ (NSData *)dataFromInt8:(SInt8)value;
@property(nonatomic, readonly) SInt8 int8Value;

@end
