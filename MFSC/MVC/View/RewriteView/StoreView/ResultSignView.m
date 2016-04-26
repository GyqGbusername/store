//
//  ResultSignView.m
//  MFSC
//
//  Created by mfwl on 16/4/6.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ResultSignView.h"

@implementation ResultSignView


- (instancetype)initWith:(NSString *)str
{
    self = [super init];
    if (self) {
        [self setFrame:kScreen_Frame];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f];
        [self resultView:str];
    }
    return self;
}


- (void)resultView:(NSString *)str {
    
    UIView *viewCenter = [[UIView alloc] init];
    [self addSubview:viewCenter];
    [viewCenter mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 3, kScreen_Width / 3));
    }];
    viewCenter.layer.cornerRadius = 10;
    viewCenter.layer.masksToBounds = YES;
    viewCenter.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    UILabel *label = [[UILabel alloc] init];
    [viewCenter addSubview:label];
    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(viewCenter);
    }];
    label.text = str;
    label.textAlignment = 1;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:22];
    label.backgroundColor = [UIColor clearColor];
    [self delayOperation];
}

#pragma mark  GCD 延时操作
- (void)delayOperation {
    double delayInSeconds = 1.0;
    WS(weakSelf);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf delayMethod]; });
}

- (void)delayMethod {
    [self removeFromSuperview];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
