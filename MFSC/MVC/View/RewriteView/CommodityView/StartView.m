//
//  StartView.m
//  StartView
//
//  Created by yang on 16/3/19.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "StartView.h"

#define kSpace 5
#define kStartWidth 20
#define kStartHeight 20

@implementation StartView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSubViewsWithFrame:frame];
    }
    return self;
}

//布局
- (void)setSubViewsWithFrame:(CGRect)frame
{
    CGFloat startY = (frame.size.height - kStartHeight) / 2.0;
    for (int i = 0;  i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( (kStartWidth + kSpace) * i, startY, kStartWidth, kStartHeight)];
        imageView.image = [UIImage imageNamed:@"mai128hui"];
        [self addSubview:imageView];
    }
    
}

//字符串
- (void)startWithStringCount:(NSString *)count
{
    NSInteger num = [count integerValue];
    [self startWithIntegerCount:num];
}

//NSNumber
- (void)startWithNumberCount:(NSNumber *)count
{
    NSInteger num = [count intValue];
    [self startWithIntegerCount:num];
}

//满分10分 2分的红色 1分的蓝色  0分的浅灰色
- (void)startWithIntegerCount:(NSInteger)count
{
    
    if (count == 0) {
        return;
    }
    if (count > 10 || count < 0) {
        NSLog(@"已超出范围");
    }
    UIImageView *imageView = nil;
    for (NSInteger i = 0; i < count / 2; i++) {
        imageView = [self.subviews objectAtIndex:i];
        imageView.image = [UIImage imageNamed:@"mai128"];
    }
    switch (count % 2) {
        case 0:
            for (NSInteger i = count / 2; i < 5; i++) {
                imageView = [self.subviews objectAtIndex:i];
                imageView.image = [UIImage imageNamed:@"mai128hui"];
            }
            break;
        case 1:
            imageView = [self.subviews objectAtIndex:count / 2];
            imageView.image = [UIImage imageNamed:@"mai128ban"];
            break;
    }
}

@end
