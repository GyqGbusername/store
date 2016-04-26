//
//  NSString+Characters.h
//  AddressBook
//
//  Created by Scott on 14-6-10.
//  Copyright (c) 2014年 www.lanou3g.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Characters)

/* 将汉字转换为拼音 */
- (NSString *)pinyinOfName;

/* 汉字转换为拼音后，返回大写的首字母 */
- (NSString *)firstCharacterOfName;

/* 所有汉字全部转换拼音 */
- (NSString *)allPinyinOfNameWith:(NSString *)strHan;

/* 所有汉字全部返回首字母 */
- (NSString *)allCharacterOfNameWith:(NSString *)strHan;;

@end
