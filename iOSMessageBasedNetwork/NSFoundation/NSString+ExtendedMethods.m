//
//  NSString+ExtendedMethods.m
//  Kula
//
//  Created by Lobanov Dmitry on 14.02.13.
//
//

#import "NSString+ExtendedMethods.h"
#import "NSObject+ExtendedMethods.h"
#import "NSData+ExtendedMethods.h"
#import "NSArray+ExtendedMethods.h"

@implementation NSString (ExtendedMethods)

#pragma mark - Common Helpers

+ (NSString *)stringify:(NSObject *)object {

    NSString *resultString = @"";

    if ([NSObject isObjectNull:object]) {
        // object is Null or nil
        // so, empty string
    }
    else {
        // object not null

        if ([object respondsToSelector:@selector(stringValue)]) {
            // string value
            resultString = [(NSNumber *) object stringValue];
        }
        else {
            // description
            resultString = [object description];
        }
    }
    return resultString;
}

- (NSString *)stringValue {
    return self;
}

#pragma mark - JSON

- (NSObject *)jsonObject {
    return [self.class jsonObjectFromString:self];
}

+ (NSObject *)jsonObjectFromString:(NSString *)string {
    NSObject *jsonObject = nil;

    if (!string) {
        return nil;
    }

    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    if (!data) {
        return nil;
    }

    jsonObject = [data jsonObject];

    return jsonObject;
}

#pragma mark - Visibility

- (BOOL)isVisible {
    return [NSString isStringVisible:self];
}

+ (BOOL)isStringVisible:(NSString *)string {
    return ![NSString isStringInvisible:string];
}

+ (BOOL)isStringInvisible:(NSString *)string {
    return (!string) || ([[NSNull null] isEqual:string]) || ([string isEqualToString:@""]);
}

// this method doesn't work properly
- (NSString *)takeVisibleMeOrAlternative:(NSString *)alternative {
    return [NSString takeVisibleString:self orAlternative:alternative];
}

+ (NSString *)takeVisibleStringOrEmptyOtherwise:(NSString *)string {
    return [self takeVisibleString:string orAlternative:@""];
}

+ (NSString *)takeVisibleString:(NSString *)string orAlternative:(NSString *)alternative {
    NSString *resultString = nil;

    resultString = [NSString isStringInvisible:string] ? alternative : string;
    resultString = [NSString isStringInvisible:resultString] ? @"" : resultString;

    return resultString;
}

- (NSString *)uppercaseFirstLetter {
    NSString *resultString = [self stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                                           withString:[[self substringToIndex:1] capitalizedString]];
    return resultString;
}

#pragma mark - Between class jumping

+ (NSString *)stringFromDictionary:(NSDictionary *)dictionary {
    NSMutableString *resultString = [[NSMutableString alloc] init];
    for (NSString *key in [dictionary allKeys]) {
        if ([resultString length]) {
            [resultString appendString:@"&"];
        }
        [resultString appendFormat:@"%@=%@", key, [dictionary objectForKey:key]];
    }
    return resultString;
}

- (NSString *)stringByAddingDictionary:(NSDictionary *)dictionary {
    return [self stringByAppendingString:[NSString stringFromDictionary:dictionary]];
}

+ (NSString *)stringFromURLParamsDictionary:(NSDictionary *)dictionary {
    NSString *resultString = nil;

    // take sorted array
    resultString =
            [[[[dictionary allKeys] sortedArrayUsingSelector:@selector(compare:)] mapObjectsUsingBlock:^id(id obj, NSUInteger idx) {

                NSString *key = (NSString *) obj;
                return [NSString stringWithFormat:@"%@=%@", key, dictionary[key]];
            }] componentsJoinedByString:@"&"];

    return resultString;
}

- (NSString *)stringByAddingURLParamsDictionary:(NSDictionary *)dictionary {
    return [self stringByAppendingString:[NSString stringFromURLParamsDictionary:dictionary]];
}


- (NSMutableDictionary *)dictionaryFromStringFormattedLikeURLParameters {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *keysAndValues = [self componentsSeparatedByString:@"&"];
    for (NSString *object in keysAndValues) {
        NSArray *elements = [object componentsSeparatedByString:@"="];
        result[elements[0]] = elements[1];
    }
    return result;
}

+ (NSString *)arrayOfObjects:(NSArray *)sourceArray
        joinedByFieldWithKey:(NSString *)key
                andSeparator:(NSString *)separator {

    NSString *resultString = nil;
    NSMutableArray *array = [NSMutableArray array];
    for (id object in sourceArray) {
        if ([object valueForKey:key]) {
            [array addObject:[object valueForKey:key]];
        }
    }
    resultString = [array componentsJoinedByString:separator];
    return resultString;
}

+ (NSString *)visibleStrings:(NSArray *)strings joinedByString:(NSString *)string {
    return [[strings compactObjectsUsingBlock:^id(id obj, NSUInteger idx) {
        return [obj isVisible] ? obj : nil;
    }] componentsJoinedByString:string];
}

+ (NSString *)stringWithFloat:(CGFloat)floatNumber {
    NSString *resultString = [NSString stringWithFormat:@"%@", [[NSNumber numberWithFloat:floatNumber] stringValue]];
    return resultString;
}

+ (NSString *)stringWithInteger:(NSInteger)integerNumber {
    NSString *resultString = [NSString stringWithFormat:@"%@", [[NSNumber numberWithInteger:integerNumber] stringValue]];
    return resultString;
}

#pragma mark - String Pattern improvements

- (NSString *)stringByReplacingOccurrencesOfStringPattern:(NSString *)targetPattern withString:(NSString *)replacement {

    NSString *resultString = nil;

    if (targetPattern != nil && replacement != nil) {

        NSMutableString *stringToReplace = [self mutableCopy];

        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:targetPattern options:0 error:nil];

        [regex replaceMatchesInString:stringToReplace
                              options:NSMatchingReportCompletion
                                range:NSMakeRange(0, [stringToReplace length])
                         withTemplate:replacement];

        resultString = [stringToReplace copy];
    }


    return resultString;
}

- (BOOL)doesStringMatchRegularExpression:(NSRegularExpression *)expression withOptions:(NSMatchingOptions)options {
    BOOL resultBOOL = NO;

    NSString *stringToSearch = self;

    CGFloat numberOfMatches = [expression numberOfMatchesInString:stringToSearch
                                                          options:options
                                                            range:NSMakeRange(0, [stringToSearch length])];

    resultBOOL = numberOfMatches != 0;

    return resultBOOL;
}

- (BOOL)doesStringMatchStringPattern:(NSString *)targetPattern {


    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:targetPattern options:0 error:nil];

    return [self doesStringMatchRegularExpression:regex withOptions:NSMatchingReportCompletion];
}

- (BOOL)doesStringMatchTextCheckingType:(NSTextCheckingType)type {

    NSDataDetector *detector = [[NSDataDetector alloc] initWithTypes:type error:nil];

    return [self doesStringMatchRegularExpression:detector withOptions:NSMatchingReportCompletion];
}

+ (NSString *)priceWithFloat:(CGFloat)price {
    return [self priceWithNumber:@(price)];
}

+ (NSNumberFormatter *)currencyFormatter {

    static dispatch_once_t onceToken;
    static NSNumberFormatter *formatter = nil;
    dispatch_once(&onceToken, ^{
        formatter = [NSNumberFormatter new];
        formatter.numberStyle = NSNumberFormatterCurrencyStyle;
        formatter.currencyGroupingSeparator = @" ";
        formatter.maximumFractionDigits = 0;
        formatter.currencySymbol = @"руб.";
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"ru_Ru"];
        formatter.locale = locale;
    });

    return formatter;
}

// decomposite this code, especially part with replacing coin sign
+ (NSString *)priceWithNumber:(NSNumber *)price {
    NSNumberFormatter *formatter = [self currencyFormatter];
    NSString *resultString = [formatter stringFromNumber:price];
    return resultString;
}

+ (NSString *)priceWithDecimal:(NSDecimal)price {
    // algorithm here
    return nil;
}

+ (NSString *)priceSign {
    return nil;
}

@end
