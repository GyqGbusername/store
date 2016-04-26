//
//  NSString+Characters.m
//  AddressBook
//
//  Created by Scott on 14-6-10.
//  Copyright (c) 2014年 www.lanou3g.com. All rights reserved.
//

#import "NSString+Characters.h"

@implementation NSString (Characters)

/* 将汉字转换为拼音 */
- (NSString *)pinyinOfName
{
    NSMutableString * name = [[NSMutableString alloc] initWithString:self ];
    
    CFRange range = CFRangeMake(0, 1);
    
    /* 汉字转换为拼音,并去除音调 */
    if ( ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    return name;
}

/* 汉字转换为拼音后，返回大写的首字母 */
- (NSString *)firstCharacterOfName
{
    NSMutableString * first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]] ;
    
    CFRange range = CFRangeMake(0, 1);
    
    /* 汉字转换为拼音,并去除音调 */
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
        ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    return result.uppercaseString;
}

- (NSString *)allPinyinOfNameWith:(NSString *)strHan {
    NSMutableString *strPinyin = nil;
    for (NSInteger i = 0; i < strHan.length; i++) {
        NSString *str  = [strHan substringWithRange:NSMakeRange(i, 1)] ;
        str = [self pinyinOfName];
        [strPinyin appendString:str];
    }
   
    return [strPinyin lowercaseString];
}
- (NSString *)allCharacterOfNameWith:(NSString *)strHan {
    NSMutableString *strPinyin = nil;
    for (NSInteger i = 0; i < strHan.length; i++) {
        NSString *str  = [strHan substringWithRange:NSMakeRange( i, 1)] ;
        str = [str firstCharacterOfName];
        [strPinyin appendString:str];
    }
    return [strPinyin lowercaseString];
}

@end
