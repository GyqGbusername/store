//
//  SignUpPageVC.m
//  MFSC
//
//  Created by mfwl on 16/3/1.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SignUpPageVC.h"
#import "BlackView.h"
#import "UserAgreementVC.h"


@interface SignUpPageVC () <UITextFieldDelegate> {
    NSInteger seconds;
    NSString *pwd;
    id __block buttonClicekYES;
    id __block validationobserver;
}



@property (nonatomic, copy) NSString *phoneNum;

@property (nonatomic, strong) BlackView *blackView;
@property (strong, nonatomic) IBOutlet UIButton *send;
@property (nonatomic, strong) UIView *backView;
@property (strong, nonatomic) IBOutlet UIButton *check;

@property (strong, nonatomic) IBOutlet UITextField *teleText;
@property (nonatomic, assign) BOOL isSelect;
@property (strong, nonatomic) IBOutlet UIButton *userAgreement;
@property (strong, nonatomic) IBOutlet UILabel *soyLabel;

@property (strong, nonatomic) IBOutlet UIView *backupView;
@property (strong, nonatomic) IBOutlet UILabel *telephone;
@property (strong, nonatomic) IBOutlet UILabel *validation;
@property (strong, nonatomic) IBOutlet UILabel *setPwd;
@property (nonatomic, strong) NSTimer *timer;

@property (strong, nonatomic) IBOutlet UILabel *resultLabel;

@property (nonatomic, strong) UIButton *newbutton;
@property (strong, nonatomic) IBOutlet UIButton *show;

@end

@implementation SignUpPageVC

- (void)dealloc {
    [mFNotiCenter removeObserver:validationobserver];
    [mFNotiCenter removeObserver:buttonClicekYES];
    [self.newbutton removeTarget:self action:@selector(newButton:) forControlEvents:(UIControlEventTouchUpInside)];
    _timer = nil;
}

- (void)createNewButton {
    self.newbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backupView addSubview:self.newbutton];
    [self.newbutton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backupView).with.offset(7);
        make.left.equalTo(self.teleText.mas_right).with.offset(10);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width / 3 - 10]);
        make.height.equalTo(@36);
    }];
    self.newbutton.layer.cornerRadius = 5;
    [self.newbutton setTitle:@"重新发送" forState:(UIControlStateNormal)];
    seconds = 60;
    [self.newbutton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.newbutton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.newbutton.backgroundColor= THEMECOLOR;
    
    [self.newbutton addTarget:self action:@selector(newButton:) forControlEvents:(UIControlEventTouchUpInside)];
}


#pragma mark 协议按钮

- (IBAction)userAgreement:(UIButton *)sender {
    UserAgreementVC *userA = [[UserAgreementVC alloc] init];
    userA.tempIs = self.isSelect;
    [self.navigationController pushViewController:userA animated:YES];
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
//如果登陆成功，停止验证码的倒数，
- (void)releaseTImer {
    if (self.timer) {
        if ([self.timer respondsToSelector:@selector(isValid)]) {
            if ([self.timer isValid]) {
                [self.timer invalidate];
                seconds = 60;
            }
        }
    }
}

#pragma mark 通知中心

- (void)notificationHandle {
    validationobserver = [mFNotiCenter addObserverForName:@"validation" object:@"signup" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    
        if ([[note .userInfo objectForKey:@"push"] isEqualToString:@"OK"]) {
            
            [self.blackView removeFromSuperview];
            self.telephone.textColor = [UIColor blackColor];
            [self getVCodeWithTeleNum];
            self.validation.textColor = THEMECOLOR;
            self.teleText.text = @"";
            self.teleText.placeholder = @"请输入验证码";
            [self createNewButton];
            self.send.titleLabel.text = @"提交验证码";
            self.send.enabled = NO;
            [self.send setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
            [self.send setTitle:@"提交验证码" forState:(UIControlStateNormal)];
            self.check.hidden = YES;
            self.soyLabel.hidden = YES;
            self.userAgreement.hidden = YES;
           
        } else {
            
            
        }
        
    }];
    
    
    buttonClicekYES = [mFNotiCenter addObserverForName:@"buttonClicekYES" object:@"buttonYES" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.isSelect = [[note .userInfo objectForKey:@"bool"]boolValue];
        if (self.isSelect) {
            [self.check setImage:[UIImage imageNamed:@"gouxuan"] forState:(UIControlStateNormal)];
            if (self.phoneNum.length == 11) {
                self.send.enabled = YES;
                [self.send setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            }
        } else {
            [self.check setImage:[UIImage imageNamed:@"kuang"] forState:(UIControlStateNormal)];
            self.send.enabled = NO;
            [self.send setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        }
        
    }];
    
    
}
#pragma mark 获取验证码
- (void)getVCodeWithTeleNum {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNum zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
}


#pragma mark 提交验证码
- (void)submitVCode {
    [SMSSDK commitVerificationCode:self.teleText.text phoneNumber:self.phoneNum zone:@"86" result:^(NSError *error) {
        if (!error) {
            self.teleText.secureTextEntry = YES;
            self.send.titleLabel.text = @"提交";
            [self.send setTitle:@"提交" forState:(UIControlStateNormal)];
            [self.newbutton removeFromSuperview];
            self.show.hidden = NO;
            self.teleText.text = @"";
            self.teleText.placeholder = @"请输入密码";
            self.setPwd.textColor = THEMECOLOR;
            self.validation.textColor = [UIColor blackColor];
            self.teleText.secureTextEntry = YES;
            self.resultLabel.text = @"验证通过输入新密码";
            self.resultLabel.textColor = THEMECOLOR;
            
        } else {
            self.resultLabel.text = @"验证码错误";
            self.resultLabel.textColor = [UIColor redColor];
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-10,@10,@-10];
            [self.resultLabel.layer addAnimation:anim forKey:nil];
        }
    }];
}

- (IBAction)show:(UIButton *)sender {
    _teleText.secureTextEntry = !_teleText.secureTextEntry;
    if (!_teleText.secureTextEntry) {
        [self.show setImage:[UIImage imageNamed:@"yanjing"] forState:(UIControlStateNormal)];
    } else {
        [self.show setImage:[UIImage imageNamed:@"biyanjing"] forState:(UIControlStateNormal)];
    }
    
}

- (IBAction)selectedButton:(UIButton *)sender {
    self.isSelect = !self.isSelect;
    if (self.isSelect == YES && self.teleText.text.length == 11) {
        [sender setImage:[UIImage imageNamed:@"gouxuan"] forState:(UIControlStateNormal)];
        self.send.enabled = YES;
        [self.send setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.phoneNum = self.teleText.text;
    } else if (self.isSelect == YES) {
        [sender setImage:[UIImage imageNamed:@"gouxuan"] forState:(UIControlStateNormal)];
    } else  {
        [sender setImage:[UIImage imageNamed:@"kuang"] forState:(UIControlStateNormal)];
        self.send.enabled = NO;
        [self.send setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    }
}

- (void)setStates {
    [self.check setImage:[UIImage imageNamed:@"kuang"] forState:(UIControlStateNormal)];
    self.isSelect = NO;
    self.check.tintColor = [UIColor blackColor];
    
    [self.check setImage:[UIImage imageNamed:@"gouxuan"] forState:(UIControlStateSelected)];
    self.send.layer.cornerRadius = 5;
    self.send.enabled = NO;
    
    [self.send setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.teleText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.teleText.keyboardType = UIKeyboardTypeNumberPad;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark 获取  提交  设置  button 点击事件
- (IBAction)send:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"发送验证码"]) {
        self.blackView = [[BlackView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [[[UIApplication sharedApplication].delegate window] addSubview:self.blackView];
        [self.teleText resignFirstResponder];
    } else if ([sender.titleLabel.text isEqualToString:@"提交验证码"]) {
        [self submitVCode];
    } else {
        if (self.teleText.text.length < 6) {
            self.resultLabel.text = @"密码至少6位字符";
            self.resultLabel.textColor = [UIColor redColor];
        } else {
#warning 提交新密码sendDoor
            
            
        }
        

        
    }
}



#pragma mark 根据textField 和 send title 判断是否可以点击 提交
- (void)textFieldDidChange:(UITextField *)textField {
    
    if ([self.send.titleLabel.text isEqualToString:@"发送验证码"]) {
        if (textField.text.length == 11 && self.isSelect == YES) {
            self.send.enabled = YES;
            [self.send setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            self.phoneNum = self.teleText.text;
        } else  {
            self.send.enabled = NO;
            [self.send setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        }
    } else if ([self.send.titleLabel.text isEqualToString:@"提交验证码"]) {
        if (textField.text.length == 4) {
            self.send.enabled = YES;
            [self.send setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        } else {
            self.send.enabled = NO;
            [self.send setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        }
    } else {
        if (textField.text.length > 0) {
            self.resultLabel.text = @"";
#pragma mark 存贮密码
            pwd = textField.text;
            
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStates];
    [self notificationHandle];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
