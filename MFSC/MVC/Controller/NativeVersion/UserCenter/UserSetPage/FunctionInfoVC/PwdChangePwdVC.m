//
//  PwdChangePwdVC.m
//  MFSC
//
//  Created by mfwl on 16/3/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "PwdChangePwdVC.h"

@interface PwdChangePwdVC () <UITextFieldDelegate> {
    NSString *newPwd;
}

@property (strong, nonatomic) IBOutlet UITextField *yuanTF;

@property (strong, nonatomic) IBOutlet UITextField *newsTF;

@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation PwdChangePwdVC


- (void)dealloc {
    _newsTF.delegate = nil;
    _yuanTF.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yuanTF.delegate = self;
        self.newsTF.delegate = self;
    }
    return self;
}

- (void)setPwd {
    [self.newsTF addTarget:self action:@selector(inputPwd:) forControlEvents:(UIControlEventEditingChanged)];
}
- (void)inputPwd:(UITextField *)textField {
    newPwd = [MyMD5 md5:[NSString stringWithFormat:@"gyq%@", textField.text]];
   
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender {
    
#warning 发送新密码到服务器
    
}




- (void)righttBarButtonClick:(UIBarButtonItem *)button {
    [self.navigationController popViewControllerAnimated:YES];
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
   
    NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
    if (proposedNewLength > 16) return NO;//限制长度
    
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
