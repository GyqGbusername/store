//
//  ChangePwdVC.m
//  MFSC
//
//  Created by mfwl on 16/3/2.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ChangePwdVC.h"

@interface ChangePwdVC () <UITextFieldDelegate>
{
    NSInteger seconds;
}
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

@property (strong, nonatomic) IBOutlet UILabel *titleName;
@property (strong, nonatomic) IBOutlet UITextField *vacodeText;
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property (nonatomic, strong) UIButton *newbutton;
@property (nonatomic, strong) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIButton *show;

@end


@implementation ChangePwdVC

- (void)dealloc {
    [self.vacodeText removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.newbutton removeTarget:self action:@selector(newButton:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createNewButton {
    self.newbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backView addSubview:self.newbutton];
    [self.newbutton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vacodeText);
        make.left.equalTo(self.vacodeText.mas_right).with.offset(10);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width / 3 - 10]);
        make.height.equalTo(@36);
    }];
    self.newbutton.layer.cornerRadius = 5;
    [self.newbutton setTitle:@"重新发送" forState:(UIControlStateNormal)];
    seconds = 60;
    [self.newbutton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.newbutton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.newbutton.backgroundColor= THEMECOLOR;
    [self.backView addSubview:self.newbutton];
    [self.newbutton addTarget:self action:@selector(newButton:) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark 重新获取验证码
- (void)newButton:(UIButton *)button {
    self.newbutton.titleLabel.text = @"获取验证码(60)";
    [self.newbutton setTitle:@"获取验证码(60)" forState: UIControlStateNormal];
    [self.newbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.newbutton setEnabled:NO];
    [self getVCodeWithTeleNum];
    [self setTimer];
}

- (void)setTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    //倒计时方法验证码实现倒计时60秒，60秒后按钮变换开始的样子
    
}
- (void)timerFireMethod:(NSTimer *)theTimer {
    if (seconds == 1) {
        [theTimer invalidate];
        seconds = 60;
        self.newbutton.titleLabel.text = @"重新发送";
        [self.newbutton setTitle:@"重新发送" forState: UIControlStateNormal];
        [self.newbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.newbutton.backgroundColor= THEMECOLOR;
        [self.newbutton setEnabled:YES];
    } else {
        seconds--;
        NSString *title = [NSString stringWithFormat:@"获取验证码(%ld)",(long)seconds];
        self.newbutton.titleLabel.text = title;
        [self.newbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.newbutton setEnabled:NO];
        self.newbutton.backgroundColor= THEMECOLOR;
        [self.newbutton setTitle:title forState:UIControlStateNormal];
    }
}


#pragma mark 获取验证码
- (void)getVCodeWithTeleNum {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.tempNum zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
}

#pragma mark 提交验证码
- (void)submitVCode {
    [SMSSDK commitVerificationCode:self.vacodeText.text phoneNumber:self.tempNum zone:@"86" result:^(NSError *error) {
        if (!error) {
#pragma mark 验证成功
            
            self.titleName.text = @"提交新密码";
            self.sendButton.titleLabel.text = @"提交新密码";
            [self.sendButton setTitle:@"提交新密码" forState:(UIControlStateNormal)];
            [self.newbutton removeFromSuperview];
            self.show.hidden = NO;
            self.vacodeText.text = @"";
            self.vacodeText.placeholder = @"请输入新密码";
            self.vacodeText.secureTextEntry = YES;
            self.resultLabel.text = @"请输入新密码";
            self.resultLabel.textColor = THEMECOLOR;
           
        } else {
#pragma mark 抖动效果
            self.resultLabel.text = @"错误验证码";
            
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-10,@10,@-10];
            [self.resultLabel.layer addAnimation:anim forKey:nil];
        }
    }];
}

- (IBAction)show:(UIButton *)sender {
    _vacodeText.secureTextEntry = !_vacodeText.secureTextEntry;
    if (!_vacodeText.secureTextEntry) {
        [self.show setImage:[UIImage imageNamed:@"yanjing"] forState:(UIControlStateNormal)];
    } else {
        [self.show setImage:[UIImage imageNamed:@"biyanjing"] forState:(UIControlStateNormal)];
    }
    
}

- (IBAction)sendInfo:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"提交验证码"]) {
        [self submitVCode];
    } else {

        if (self.vacodeText.text.length < 6) {
            self.resultLabel.text = @"密码至少6位字符";
        } else {
            
            #warning 提交新密码sendDoor
        }
        
        
    }
}
#warning 匹配验证码
- (void)setText {
    [self.vacodeText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length > 4) {
        return NO;
    } return YES;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if ([self.sendButton.titleLabel.text isEqualToString: @"提交新密码"]) {
        if (textField.text.length > 0) {
            self.resultLabel.text = @"";
        }
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setText];
    [self createNewButton];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
