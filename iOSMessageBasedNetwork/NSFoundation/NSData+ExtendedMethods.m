//
//  NSData+ExtendedMethods.m
//  Buro 247
//
//  Created by Dmitry Lobanov on 12.12.14.
//
//

#import <Foundation/Foundation.h>

@implementation NSData (ExtendedMethods)

- (NSObject *)jsonObject {
    return [self.class jsonObjectFromData:self];
}

+ (NSObject *)jsonObjectFromData:(NSData *)data {

    NSObject *jsonObject = nil;
    NSError *error = nil;

    if (data) {
        jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingAllowFragments
                                                       error:&error];
    }

    return error ? nil : jsonObject;
}

+ (NSString *)hexadecimalStringFromData:(NSData *)data {
    /* Returns hexadecimal string of NSData. Empty string if data is empty.   */

    const unsigned char *dataBuffer = (const unsigned char *) [data bytes];

    if (!dataBuffer)
        return [NSString string];

    NSUInteger dataLength = [data length];
    NSMutableString *hexString = [NSMutableString stringWithCapacity:(dataLength * 2)];

    for (int i = 0; i < dataLength; ++i)
        [hexString appendString:[NSString stringWithFormat:@"%02lx", (unsigned long) dataBuffer[i]]];

    return [NSString stringWithString:hexString];
}

- (NSString *)hexadecimalString {
    return [self.class hexadecimalStringFromData:self];
}

#pragma mark - Number conversions
+ (NSInteger)integerFromData:(NSData *)data {
    NSInteger number = 0;
    [data getBytes:&number length:sizeof(number)];
    return number;
}

+ (NSData *)dataFromInteger:(NSInteger)value {
    NSInteger number = value;
    return [[NSData alloc] initWithBytes:&number length:sizeof(number)];
}

- (NSInteger)integerValue {
    return [self.class integerFromData:self];
}

+ (SInt8)int8FromData:(NSData *)data {
    SInt8 number = 0;
    [data getBytes:&number length:sizeof(number)];
    return number;
}

+ (NSData *)dataFromInt8:(SInt8)value {
    SInt8 number = value;
    return [[NSData alloc] initWithBytes:&number length:sizeof(number)];
}

- (SInt8)int8Value {
    return [self.class int8FromData:self];
}

@end
