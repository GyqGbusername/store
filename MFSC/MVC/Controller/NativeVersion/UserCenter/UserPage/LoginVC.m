//
//  LoginVC.m
//  MFSC
//
//  Created by mfwl on 16/2/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "LoginVC.h"
#import "FindPasswordVC.h"
#import "SignUpPageVC.h"


@interface LoginVC () <UITextFieldDelegate> {
    NSString *pwd;
}

@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UIButton *findPassword;
@property (strong, nonatomic) IBOutlet UIButton *Quicklogin;
@property (strong, nonatomic) IBOutlet UITextField *inputUsername;
@property (strong, nonatomic) IBOutlet UITextField *inputPwd;
@property (strong, nonatomic) IBOutlet UIButton *show;

@end

@implementation LoginVC

- (void)dealloc {
    [_inputPwd removeTarget:self action:@selector(inputPwd:) forControlEvents:(UIControlEventEditingChanged)];
    _inputPwd.delegate = nil;
    _inputUsername.delegate = nil;
}

/* 保存数据到NSUserDefaults */
- (void)saveNSUserDefaultsWith:(NSString *)str {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:@"token"];
    /* 这里建议同步存储到磁盘中，不写也可以建议写 */
    [userDefaults synchronize];
}

- (IBAction)show:(UIButton *)sender {
    _inputPwd.secureTextEntry = !_inputPwd.secureTextEntry;
    if (!_inputPwd.secureTextEntry) {
        [self.show setImage:[UIImage imageNamed:@"yanjing"] forState:(UIControlStateNormal)];
    } else {
        [self.show setImage:[UIImage imageNamed:@"biyanjing"] forState:(UIControlStateNormal)];
    }
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.inputUsername.delegate = self;
        self.inputPwd.delegate = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField isEqual:self.inputUsername]) {
        return YES;
    } else {
        
        NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
        if (proposedNewLength > 16) return NO;//限制长度
        
    }
    return YES;
}

- (IBAction)login:(UIButton *)sender {
#warning send pwd
    /* pwd */
    [self saveNSUserDefaultsWith:@"1"];

}

- (IBAction)findPassword:(UIButton *)sender {
    FindPasswordVC *find = [[FindPasswordVC alloc] init];
    [self.navigationController pushViewController:find animated:YES];
}

- (IBAction)QuckLogin:(UIButton *)sender {
    
}



- (IBAction)signUp:(UIButton *)sender {
    SignUpPageVC *signUp = [[SignUpPageVC alloc] init];
    [self.navigationController pushViewController:signUp animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





- (void)setPwd {
    [self.inputPwd addTarget:self action:@selector(inputPwd:) forControlEvents:(UIControlEventEditingChanged)];
}
- (void)inputPwd:(UITextField *)textField {
    pwd = [MyMD5 md5:[NSString stringWithFormat:@"gyq%@", textField.text]];
   
}

- (void)setLogin {
    self.login.layer.cornerRadius = 5;
    self.login.layer.masksToBounds = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLogin];
    [self setPwd];
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
