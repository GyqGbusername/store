//
//  UserButtonView.m
//  MFSC
//
//  Created by mfwl on 16/2/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "UserButtonView.h"

@interface UserButtonView ()

@property (nonatomic, strong) UILabel *firup;
@property (nonatomic, strong) UILabel *firdown;
@property (nonatomic, strong) UILabel *secup;
@property (nonatomic, strong) UILabel *secdown;


@end

@implementation UserButtonView

- (void)dealloc {
    [_vouchers removeTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
 
    [_comments removeTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.vouchers = [[UIButton alloc] init];
        self.vouchers.tag = 11;
        self.comments = [[UIButton alloc] init];
        self.comments.tag = 12;
      
        self.firup = [[UILabel alloc] init];
        self.firdown = [[UILabel alloc] init];
        self.secup = [[UILabel alloc] init];
        self.secdown = [[UILabel alloc] init];
    
        
        [self addSubview:self.vouchers];
        [self addSubview:self.comments];
    
        [self addSubview:self.firup];
        [self addSubview:self.firdown];
        [self addSubview:self.secup];
        [self addSubview:self.secdown];
    
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.vouchers mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).with.offset(1);
        make.height.equalTo([NSNumber numberWithInteger:self.frame.size.height]);
        make.width.equalTo ([NSNumber numberWithFloat:self.frame.size.width / 2 - 1.5]);
    }];
    [self.firup mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).with.offset(1);
        make.height.equalTo([NSNumber numberWithInteger:self.frame.size.height/2]);
        make.width.equalTo ([NSNumber numberWithInteger:self.frame.size.width / 2 - 1.5]);
    }];
    [self.firdown mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firup.mas_bottom);
        make.left.equalTo(self.mas_left).with.offset(1);
        make.height.equalTo([NSNumber numberWithInteger:self.frame.size.height / 2]);
        make.width.equalTo ([NSNumber numberWithFloat:self.frame.size.width / 2 - 1.5]);
    }];
    [self.comments mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right).with.offset(-1);
        make.height.equalTo([NSNumber numberWithInteger:self.frame.size.height]);
        make.width.equalTo ([NSNumber numberWithFloat:self.frame.size.width / 2 - 1.5]);
    }];
    [self.secup mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right).with.offset(1);
        make.height.equalTo([NSNumber numberWithInteger:self.frame.size.height/2]);
        make.width.equalTo ([NSNumber numberWithInteger:self.frame.size.width / 2 - 1.5]);
    }];
    [self.secdown mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secup.mas_bottom);
        make.right.equalTo(self.mas_right).with.offset(1);
        make.height.equalTo([NSNumber numberWithInteger:self.frame.size.height / 2]);
        make.width.equalTo ([NSNumber numberWithFloat:self.frame.size.width / 2 - 1.5]);
    }];
    self.firup.font = [UIFont systemFontOfSize:13];
    self.firup.textAlignment = 1;
    self.firup.textColor = [UIColor whiteColor];
    self.firdown.font = [UIFont systemFontOfSize:13];
    self.firdown.textAlignment = 1;
    self.firdown.textColor = [UIColor whiteColor];
    self.secup.font = [UIFont systemFontOfSize:13];
    self.secup.textAlignment = 1;
    self.secup.textColor = [UIColor whiteColor];
    self.secdown.font = [UIFont systemFontOfSize:13];
    self.secdown.textAlignment = 1;
    self.secdown.textColor = [UIColor whiteColor];
    self.comments.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.vouchers.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.firdown.text = @"麦丰券";
    self.secdown.text = @"评价";
   
    self.firup.text = @"0";
    
    self.secup.text = @"0";
    
  
    [self.vouchers addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.comments addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)buttonClick:(UIButton *)button {
    
    [mFNotiCenter postNotificationName:@"UserButtonView" object:@"button" userInfo:@{@"push":[NSString stringWithFormat:@"%ld",(long)button.tag]}];
}


- (void)setUserMode:(UserInfoModel *)userMode {
    if (_userMode != userMode) {
        _userMode = userMode;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
