//
//  NSString+ExtendedMethods.h
//  Kula
//
//  Created by Lobanov Dmitry on 14.02.13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ExtendedMethods)

#pragma mark - Common Helpers

// create valid string from json values like string, number and null/nil
+ (NSString *)stringify:(NSObject *)object;

- (NSString *)stringValue;

- (NSString *)uppercaseFirstLetter;

#pragma mark - JSON

- (NSObject *)jsonObject;

+ (NSObject *)jsonObjectFromString:(NSString *)string;

#pragma mark - Visibility

- (BOOL)isVisible;

+ (BOOL)isStringVisible:(NSString *)string;

+ (BOOL)isStringInvisible:(NSString *)string;

+ (NSString *)takeVisibleStringOrEmptyOtherwise:(NSString *)string;

+ (NSString *)takeVisibleString:(NSString *)string orAlternative:(NSString *)alternative;

#pragma mark - Between class jumping

+ (NSString *)stringFromDictionary:(NSDictionary *)dictionary;

- (NSString *)stringByAddingDictionary:(NSDictionary *)dictionary;

+ (NSString *)stringFromURLParamsDictionary:(NSDictionary *)dictionary;

- (NSString *)stringByAddingURLParamsDictionary:(NSDictionary *)dictionary;

- (NSMutableDictionary *)dictionaryFromStringFormattedLikeURLParameters;

+ (NSString *)arrayOfObjects:(NSArray *)sourceArray
        joinedByFieldWithKey:(NSString *)key
                andSeparator:(NSString *)separator;

+ (NSString *)visibleStrings:(NSArray *)strings joinedByString:(NSString *)string;

+ (NSString *)stringWithFloat:(CGFloat)floatNumber;

+ (NSString *)stringWithInteger:(NSInteger)integerNumber;

#pragma mark - String Pattern improvements

- (NSString *)stringByReplacingOccurrencesOfStringPattern:(NSString *)targetPattern withString:(NSString *)replacement;

- (BOOL)doesStringMatchRegularExpression:(NSRegularExpression *)expression withOptions:(NSMatchingOptions)options;

- (BOOL)doesStringMatchStringPattern:(NSString *)targetPattern;

- (BOOL)doesStringMatchTextCheckingType:(NSTextCheckingType)type;

#pragma mark - Currency

+ (NSNumberFormatter *)currencyFormatter;

+ (NSString *)priceWithNumber:(NSNumber *)price;

+ (NSString *)priceWithFloat:(CGFloat)price;

+ (NSString *)priceWithDecimal:(NSDecimal)price;

+ (NSString *)priceSign;
@end
