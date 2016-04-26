//
//  BirthDayVC.m
//  MFSC
//
//  Created by mfwl on 16/3/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BirthDayVC.h"

@interface BirthDayVC () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *yearTF;
@property (strong, nonatomic) IBOutlet UITextField *monthTF;
@property (strong, nonatomic) IBOutlet UITextField *dayTF;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation BirthDayVC

- (void)dealloc {
    _yearTF.delegate = nil;
    _monthTF.delegate =nil;
    _dayTF.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.yearTF.delegate = self;
        self.monthTF.delegate = self;
        self.dayTF.delegate = self;
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self. navigationController popViewControllerAnimated:YES];
}




- (IBAction)saveBackButton:(UIButton *)sender {
    [self. navigationController popViewControllerAnimated:YES];
#warning 发送数据到服务器
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view from its nib.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // Check for non-numeric characters
    NSUInteger lengthOfString = string.length;
    for (NSInteger loopIndex = 0; loopIndex < lengthOfString; loopIndex++) {//只允许数字输入
        unichar character = [string characterAtIndex:loopIndex];
        if (character < 48) return NO; // 48 unichar for 0
        if (character > 57) return NO; // 57 unichar for 9
    }
    // Check for total length
    switch (textField.tag) {
        case 51: {
        
            NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
            if (proposedNewLength > 4) return NO;//限制长度
        }
            break;
            
        case 52: {
            NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
            if (proposedNewLength > 2) return NO;//限制长度
        }
            
            break;
        default: {
            NSUInteger proposedNewLength = textField.text.length - range.length + string.length;
            if (proposedNewLength > 2) return NO;//限制长度
        }
            break;
    }
   
    return YES;
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
