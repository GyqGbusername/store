//
//  ClearBV.m
//  MFSC
//
//  Created by mfwl on 16/4/7.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ClearBV.h"

@implementation ClearBV


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    [self.delegate closeSelf];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
