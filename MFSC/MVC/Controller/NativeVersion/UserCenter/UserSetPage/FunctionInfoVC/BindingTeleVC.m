//
//  BindingTeleVC.m
//  MFSC
//
//  Created by mfwl on 16/3/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BindingTeleVC.h"
#import "OnlyvalcodeView.h"

@interface BindingTeleVC () {
    NSString *telePhone;
}
@property (strong, nonatomic) IBOutlet UITextField *bingdingTF;


@property (strong, nonatomic) IBOutlet UIButton *changeTele;
@property (strong, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic, strong) OnlyvalcodeView *onlyva;
@property (nonatomic, strong) UIView *backView;

@end

@implementation BindingTeleVC

- (void)setBackViewColor {
    self.backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [[[UIApplication sharedApplication].delegate window] addSubview:self.backView];
}

- (IBAction)submit:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"更换绑定手机"]) {
         [self getVCodeWithTeleNum];
    } else {
#warning mark 待补充更换新手机获取第二次验证码
        
    }
}


#pragma mark 获取验证码
- (void)getVCodeWithTeleNum {
   
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:telePhone zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            self.resultLabel.text = @"获取验证码成功";
            self.resultLabel.textColor = THEMECOLOR;
            [self voCodeView];

        } else {
           
            self.resultLabel.text = @"获取验证码失败";
            self.resultLabel.textColor = [UIColor redColor];
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-10,@10,@-10];
            [self.resultLabel.layer addAnimation:anim forKey:nil];
        }
    }];
}

- (void)voCodeView {
    [self setBackViewColor];
    self.onlyva = [[OnlyvalcodeView alloc] init];
    [self.backView addSubview:_onlyva];
    [self.onlyva mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([[UIApplication sharedApplication].delegate window]);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 2, kScreen_Width /2));
    }];
    [_onlyva.sumbitBT addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_onlyva.chaBT addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
}


#pragma mark 提交验证码
- (void)submitVCode {
   
    [SMSSDK commitVerificationCode:_onlyva.valcodeTF.text phoneNumber:telePhone zone:@"86" result:^(NSError *error) {
        if (!error) {
            self.resultLabel.text = @"验证通过";
            self.resultLabel.textColor = THEMECOLOR;
            [self.backView removeFromSuperview];
            
            self.bingdingTF.userInteractionEnabled = YES;
            
            self.bingdingTF.text = @"";
            self.bingdingTF.placeholder = @"请输入新手机号";
            self.changeTele.titleLabel.text = @"获取验证码";
            [self.changeTele setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        } else {
            self.onlyva.resultLB.text = @"验证码错误";
            self.onlyva.resultLB.textColor = [UIColor redColor];
            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
            anim.repeatCount = 1;
            anim.values = @[@-10,@10,@-10];
            [self.onlyva.resultLB.layer addAnimation:anim forKey:nil];
        }
    }];
}
- (void)buttonClick:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString:@"提交"]) {
        [self submitVCode];
    } else {
        self.resultLabel.text = @"";
        [self.backView removeFromSuperview];
    }
    
}

- (IBAction)back:(id)sender {
      [self.navigationController popViewControllerAnimated:YES];
}




- (void)setphoneLabel {
    
#warning 获取绑定手机 JumpDoor
    
    NSString *originTel = @"13946163274";
    telePhone = originTel;
    NSString *tel = [originTel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    self.bingdingTF.text = tel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setphoneLabel];
    
   
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
