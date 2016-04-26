//
//  OnlyvalcodeView.m
//  MFSC
//
//  Created by mfwl on 16/3/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "OnlyvalcodeView.h"

@interface OnlyvalcodeView ()




@end

@implementation OnlyvalcodeView


- (void)dealloc {
    [_valcodeTF removeTarget:self action:@selector(valcodeTF:) forControlEvents:(UIControlEventEditingChanged)];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.nameLable = [[UILabel alloc] init];
        self.resultLB = [[UILabel alloc] init];
        self.valcodeTF = [[UITextField alloc] init];
        self.sumbitBT = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.chaBT = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.chaBT];
        [self addSubview:self.nameLable];
        [self addSubview:self.resultLB];
        [self addSubview:self.valcodeTF];
        [self addSubview:self.sumbitBT];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_chaBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@15);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        
    }];
    [self.chaBT setImage:[UIImage imageNamed:@"cha"] forState:(UIControlStateNormal)];
    [self.chaBT setTintColor:[UIColor lightGrayColor]];
   
    [_nameLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.left.equalTo(self).offset(0.1 * kScreen_Width / 2);
        make.width.equalTo([NSNumber numberWithFloat:0.8 * kScreen_Width / 2]);
        make.height.equalTo(@20);
    }];
    self.nameLable.text = @"输入您收到的验证码:";
    self.nameLable.font = [UIFont systemFontOfSize:13];
    _valcodeTF.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:248 / 255.0 blue:249 / 255.0 alpha:1.0];
    [_valcodeTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.1 * kScreen_Width / 2);
        make.top.equalTo(self.nameLable.mas_bottom).offset(10);
        make.height.equalTo(@30);
        make.width.equalTo([NSNumber numberWithFloat:0.8 * kScreen_Width / 2]);
    }];
    self.valcodeTF.placeholder = @"请输入验证码";
    self.valcodeTF.font = [UIFont systemFontOfSize:15];
    _valcodeTF.layer.cornerRadius = 3;
    _valcodeTF.layer.masksToBounds = YES;
    _valcodeTF.layer.borderWidth = 1;
    _valcodeTF.layer.borderColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0].CGColor;
    [_sumbitBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valcodeTF.mas_bottom).offset(20);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width/ 3]);
        make.height.equalTo(@30);
        make.centerX.equalTo(self);
        
    }];
    
    [_valcodeTF addTarget:self action:@selector(valcodeTF:) forControlEvents:(UIControlEventEditingChanged)];
    self.sumbitBT.layer.cornerRadius = 5;
    self.sumbitBT.layer.masksToBounds = YES;
    [self.sumbitBT setTitle:@"提交" forState:(UIControlStateNormal)];
    self.sumbitBT.backgroundColor = THEMECOLOR;
    [self.sumbitBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    [_resultLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.sumbitBT.mas_bottom).offset(10);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width / 2 * 0.6]);
        make.height.equalTo(@15);
    }];
    self.resultLB.font = [UIFont systemFontOfSize:13];
    self.resultLB.textAlignment = 1;
}

- (void)valcodeTF:(UITextField *)tf {
    if (tf.text.length> 0) {
        _resultLB.text = @"";
    }
}



@end
