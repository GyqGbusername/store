//
//  ValidationView.m
//  MFSC
//
//  Created by mfwl on 16/3/1.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ValidationView.h"
#import "AuthCodeView.h"
#import "TitleView.h"

#define avCodeWidth [NSNumber numberWithFloat:kScreen_Width * 2 / 3 * 0.8]
#define avCodeHeight [NSNumber numberWithFloat:kScreen_Width * 2 / 3 / 5]
#define lbHeight [NSNumber numberWithFloat:kScreen_Width * 2 / 3 / 10]
#define inputWidth [NSNumber numberWithFloat:kScreen_Width * 2 / 3 * 0.4]
#define inputHeight [NSNumber numberWithFloat:kScreen_Width * 2 / 3 / 5 * 3 / 4]
#define titleHeight [NSNumber numberWithFloat:kScreen_Width * 2 / 3 / 5]

@interface ValidationView () <UITextFieldDelegate, UIAlertViewDelegate>
{
    AuthCodeView *authCodeView;
    UITextField *_input;
    UILabel *results;
}


@end

@implementation ValidationView

- (void)dealloc {
    _input.delegate = nil;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleView = [[TitleView alloc] init];
        [self addSubview:self.titleView];
        [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self);
            make.height.equalTo(titleHeight);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        authCodeView = [[AuthCodeView alloc] init];
        [self addSubview:authCodeView];
        [authCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(avCodeHeight);
            make.centerX.equalTo(self);
            make.width.equalTo(avCodeWidth);
            make.top.equalTo(self.titleView.mas_bottom).offset(10);
        }];
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(authCodeView);
            make.top.equalTo(authCodeView.mas_bottom).offset(5);
            make.width.equalTo(avCodeWidth);
            make.height.equalTo(lbHeight);
        }];
        label.text = @"点击图片换验证码";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor grayColor];
        
      
        //添加输入框
        _input = [[UITextField alloc] init];
        [self addSubview:_input];
        [_input mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom).offset(5);
            make.left.equalTo(label);
            make.width.equalTo(inputWidth);
            make.height.equalTo(inputHeight);
        }];
        _input.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _input.layer.borderWidth = 1.0;
        _input.layer.cornerRadius = 5.0;
        _input.font = [UIFont systemFontOfSize:13];
        _input.placeholder = @"请输入验证码";
        _input.clearButtonMode = UITextFieldViewModeWhileEditing;
        _input.backgroundColor = [UIColor clearColor];
        _input.textAlignment = NSTextAlignmentCenter;
        _input.returnKeyType = UIReturnKeyDone;
        _input.delegate = self;
        [_input addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        results = [[UILabel alloc] init];
        [self addSubview:results];
        [results mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(_input);
            make.width.equalTo(inputWidth);
            make.left.equalTo(_input.mas_right).offset(5);
            make.height.equalTo(label);
        }];
       
        results.font = [UIFont systemFontOfSize:13];
        results.textColor = [UIColor redColor];
        UIButton *goButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:goButton];
        [goButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-10);
            make.centerX.equalTo(self);
            make.width.equalTo(inputWidth);
            make.height.equalTo(inputHeight);
        }];
        [goButton setTitle:@"马上验证" forState:(UIControlStateNormal)];
        
        goButton.layer.cornerRadius = 5;
        goButton.backgroundColor = THEMECOLOR;
        goButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [goButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [goButton addTarget:self action:@selector(goButton:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

- (void)textFieldDidChange:(UITextField *) TextField {
    if (TextField.text.length == 0) {
        results.text = @"";
    }
}

- (void)goButton:(UIButton *)button {
    if (_input.text.length == 0) {
        
        results.text = @"验证码不能为空";
    } else {
        [self passValidation];
    }
}

- (void)passValidation {
    
    if ([[_input.text lowercaseString] isEqualToString:[authCodeView.authCodeStr lowercaseString]] || [_input.text isEqualToString:authCodeView.authCodeStr])
    {
        [mFNotiCenter postNotificationName:@"validation" object:@"signup" userInfo:@{@"push":@"OK"}];
    } else {
        [mFNotiCenter postNotificationName:@"validation" object:@"signup" userInfo:@{@"push":@"NO"}];
        //验证不匹配，验证码和输入框抖动
        results.text = @"错误验证码";
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        anim.repeatCount = 2;
        anim.values = @[@-5,@5,@-5];
        //        [authCodeView.layer addAnimation:anim forKey:nil];
        [results.layer addAnimation:anim forKey:nil];
    }

}


#pragma mark 输入框代理，点击return 按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self passValidation];
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
