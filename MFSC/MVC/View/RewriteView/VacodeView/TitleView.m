//
//  TitleView.m
//  MFSC
//
//  Created by mfwl on 16/3/1.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "TitleView.h"

#define titlbHeight [NSNumber numberWithFloat:kScreen_Width * 2 / 3 / 5 - 2]


@interface TitleView () {
    UILabel *titleLable;
    UILabel *lineLable;
}


@end

@implementation TitleView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        titleLable = [[UILabel alloc] init];
        lineLable = [[UILabel alloc] init];
        [self addSubview:titleLable];
        [self addSubview:lineLable];
        self.backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.backButton];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backButton.tintColor = [UIColor lightGrayColor];
   
    [self.backButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@20);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
    }];
    [self.backButton setImage:[UIImage imageNamed:@"cha"] forState:(UIControlStateNormal)];

    [titleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self);
        make.width.equalTo(@60);
        make.height.equalTo(titlbHeight);
    }];
    titleLable.textAlignment = 1;
    [lineLable setFrame:CGRectMake(0, self.frame.size.height - 2, self.frame.size.width, 2)];
    [lineLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.height.equalTo(@2);
        make.top.equalTo(titleLable.mas_bottom);
        make.right.left.equalTo(self);
    }];
    
    titleLable.text = @"提示";
    titleLable.font = [UIFont systemFontOfSize:20];
    titleLable.textColor = THEMECOLOR;
    lineLable.backgroundColor = THEMECOLOR;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
