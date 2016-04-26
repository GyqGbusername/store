//
//  StartView.h
//  StartView
//
//  Created by yang on 16/3/19.
//  Copyright © 2016年 yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

//字符串
- (void)startWithStringCount:(NSString *)count;

//NSNumber
- (void)startWithNumberCount:(NSNumber *)count;

//数字
- (void)startWithIntegerCount:(NSInteger)count;

@end
