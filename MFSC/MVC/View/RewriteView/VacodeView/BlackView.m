//
//  blackView.m
//  MFSC
//
//  Created by mfwl on 16/3/1.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "blackView.h"
#import "ValidationView.h"
#import "TitleView.h"

@interface BlackView ()

@end
@implementation BlackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ValidationView *validationView = [[ValidationView alloc] init];
        //[validationView setFrame:CGRectMake(25, 20, 325, 325)];
        [self addSubview:validationView];
        [validationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo([NSNumber numberWithFloat:kScreen_Width * 2 / 3] );
            make.center.equalTo(self);
        }];
        validationView.layer.cornerRadius = 15;
        validationView.layer.masksToBounds  = YES;
        
        [validationView.titleView.backButton addTarget:self action:@selector(backButton:) forControlEvents:(UIControlEventTouchUpInside)];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
    }
    return self;
}

- (void)backButton:(UIButton *)button {
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
