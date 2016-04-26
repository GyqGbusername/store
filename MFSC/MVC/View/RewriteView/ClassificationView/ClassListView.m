//
//  ClassListView.m
//  MFSC
//
//  Created by mfwl on 16/3/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ClassListView.h"

#define cHeight (kScreen_Height - 113) / 7

@interface ClassListView ()
@property (nonatomic, strong) UIButton *soyButton;
@property (nonatomic, assign) NSInteger tempNum;

@end

@implementation ClassListView

- (instancetype)initWith:(NSArray *)titleArr with:(NSInteger)selectedIndex {
    self = [super init];
    if (self) {
        self.tempNum = titleArr.count;
        for (NSInteger i = 0; i < titleArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            [button setTitle:titleArr[i] forState:(UIControlStateNormal)];
            button.titleLabel.text = titleArr[i];
            if (i == selectedIndex) {
                button.backgroundColor = BACKCOLOR;
            } else {
                button.backgroundColor = [UIColor whiteColor];
            }
            [self addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (NSInteger i = 0; i < self.tempNum; i++) {
        self.soyButton = self.subviews[i];
        [_soyButton addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [_soyButton setTitleColor:TEXTCOLOR forState:(UIControlStateNormal)];
        _soyButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_soyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(cHeight * i);
            make.left.equalTo(self);
            make.width.equalTo(self);
            make.height.equalTo([NSNumber numberWithFloat:cHeight]);
        }];
        
    }
}

- (void)buttonClick:(UIButton *)button {
    for (NSInteger i = 0; i < self.tempNum; i++) {
        _soyButton = self.subviews[i];
        _soyButton.backgroundColor = [UIColor whiteColor];
    }
    button.backgroundColor = BACKCOLOR;
    [self.delegate ClassListViewDidSelectTitleName:button.titleLabel.text];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
