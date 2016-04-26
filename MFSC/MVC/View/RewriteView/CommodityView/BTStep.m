//
//  BTStep.m
//  MFSC
//
//  Created by mfwl on 16/4/11.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BTStep.h"

@interface BTStep () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputNum;
@property (nonatomic, strong) UIButton *addBT;
@property (nonatomic, strong) UIButton *reduceBT;


@end

@implementation BTStep


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
        self.inputNum = [[UITextField alloc] init];
        self.addBT = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.reduceBT = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self addSubview:self.inputNum];
        [self addSubview:self.addBT];
        [self addSubview:self.reduceBT];
    }
    return self;
}


- (void)setAu {
    _inputNum.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0f];
    _inputNum.font = [UIFont systemFontOfSize:13];
    _inputNum.delegate = self;
    _inputNum.text = @"1";
    _inputNum.textAlignment = 1;
    [_addBT setTitle:@"＋" forState:(UIControlStateNormal)];
    [_reduceBT setTitle:@"－" forState:(UIControlStateNormal)];
    _addBT.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    _reduceBT.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_reduceBT setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [_addBT setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [_addBT addTarget:self action:@selector(add:) forControlEvents:(UIControlEventTouchUpInside)];
    [_reduceBT addTarget:self action:@selector(reduce:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)add:(UIButton *)add {
    NSInteger tempNum = [self.inputNum.text integerValue];
    tempNum++;
    self.inputNum.text = [NSString stringWithFormat:@"%d", tempNum];
}

- (void)reduce:(UIButton *)reduce {
    NSInteger tempNum = [self.inputNum.text integerValue];
    tempNum--;
    if (tempNum) {
        self.inputNum.text = [NSString stringWithFormat:@"%d", tempNum];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // Check for non-numeric characters
    NSUInteger lengthOfString = string.length;
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
        unichar character = [string characterAtIndex:loopIndex];
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57) return NO; // 57 unichar for 9
    }
   
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > 6) return NO;//限制长度
    
    

    
    return YES;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self setAu];
    [_addBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.equalTo([NSNumber numberWithFloat:self.frame.size.width / 4]);
    }];
    
    [_reduceBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.equalTo([NSNumber numberWithFloat:self.frame.size.width / 4]);
    }];
    
    [_inputNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.reduceBT.mas_right);
        make.right.equalTo(self.addBT.mas_left);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
