//
//  FindPasswordVC.m
//  MFSC
//
//  Created by mfwl on 16/2/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "FindPasswordVC.h"
#import "AuthCodeView.h"
#import "ChangePwdVC.h"

@interface FindPasswordVC () <UITextFieldDelegate, UIAlertViewDelegate, UITextFieldDelegate>
{
    AuthCodeView *authCodeView;
}

@property (strong, nonatomic) IBOutlet UITextField *teleNum;
@property (strong, nonatomic) IBOutlet UITextField *vaCodeNum;
@property (strong, nonatomic) IBOutlet UIView *backDown;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UILabel *resulutsLabel;

@property (nonatomic, assign) NSInteger *tempNum;

@end

@implementation FindPasswordVC

- (void)dealloc {
    _teleNum.delegate = nil;
    _vaCodeNum.delegate = nil;
    [_teleNum removeTarget:self action:@selector(teleNum:) forControlEvents:(UIControlEventEditingChanged)];
    [_vaCodeNum removeTarget:self action:@selector(vaCodeNum:) forControlEvents:(UIControlEventEditingChanged)];
}

#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    [authCodeView reloadContent];
}



#pragma mark 限制输入字符个数
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if ([textField isEqual:self.teleNum]) {
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 11) return NO;//限制长度
    } else {
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 6) return NO;//限制长度
    }
    
    return YES;
}


- (void)setSelfAu {
    self.nextButton.layer.cornerRadius = 5;
  }

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 获取验证码
- (void)getVCodeWithTeleNum {
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.teleNum.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
}

#warning lalalalala

- (IBAction)next:(UIButton *)sender {
   
    if (self.vaCodeNum.text.length == 0) {
        self.resulutsLabel.text = @"验证码不能为空";
        
    } else {
        if ([[self.vaCodeNum.text lowercaseString] isEqualToString:[authCodeView.authCodeStr lowercaseString]] || [self.vaCodeNum.text isEqualToString:authCodeView.authCodeStr])
        {
            [self getVCodeWithTeleNum];
            ChangePwdVC *pwdVC = [[ChangePwdVC alloc] init];
            pwdVC.tempNum = self.teleNum.text;
            [self.navigationController pushViewController:pwdVC animated:YES];
            
        } else {
            self.resulutsLabel.text = @"错误验证码";
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-10,@10,@-10];
            [self.resulutsLabel.layer addAnimation:anim forKey:nil];
        }
    }
}


- (void)setText {
    self.nextButton.enabled = NO;
    self.vaCodeNum.delegate = self;
    self.teleNum.delegate = self;
    [self.nextButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.teleNum addTarget:self action:@selector(teleNum:) forControlEvents:(UIControlEventEditingChanged)];
    [self.vaCodeNum addTarget:self action:@selector(vaCodeNum:) forControlEvents:(UIControlEventEditingChanged)];
}

- (void)vaCodeNum:(UITextField *)textField {
    if (textField.text.length > 0) {
        self.resulutsLabel.text = @"";
    }
}

- (void)teleNum:(UITextField *)textField {
    if (textField.text.length == 11) {
        self.nextButton.enabled = YES;
        [self.nextButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    } else {
        self.nextButton.enabled = NO;
        [self.nextButton setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSelfAu];
    [self setText];
    authCodeView = [[AuthCodeView alloc] init];
    [self.backDown addSubview:authCodeView];
    [authCodeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.vaCodeNum.mas_right).offset(10);
        make.height.equalTo(self.vaCodeNum);
        make.centerY.equalTo(self.vaCodeNum);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width * 0.3]);
    }];
    
    
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
