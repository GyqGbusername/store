//
//  UserAgreementVC.m
//  MFSC
//
//  Created by mfwl on 16/3/31.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "UserAgreementVC.h"

@interface UserAgreementVC () <UITextViewDelegate>

@property (nonatomic, assign) BOOL isSel;
@property (strong, nonatomic) IBOutlet UITextView *tv;
@property (strong, nonatomic) IBOutlet UIButton *sure;
@property (strong, nonatomic) IBOutlet UILabel *text;

@end

@implementation UserAgreementVC

- (void)dealloc {
    _tv.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isSel = NO;
        self.tv.delegate = self;
    }
    return self;
}



- (IBAction)back:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}


- (void)setTempIs:(BOOL)tempIs {
    if (_tempIs != tempIs) {
        _tempIs = tempIs;
    }
    
    self.isSel = _tempIs;
    if (self.isSel) {
        [self.sure setImage:[UIImage imageNamed:@"gouxuan"] forState:(UIControlStateNormal)];
    
    } else  {
        [self.sure setImage:[UIImage imageNamed:@"kuang"] forState:(UIControlStateNormal)];
    }
}




- (IBAction)check:(UIButton *)sender {
    self.isSel = !self.isSel;
    if (self.isSel) {
        [sender setImage:[UIImage imageNamed:@"gouxuan"] forState:(UIControlStateNormal)];
    } else  {
        [sender setImage:[UIImage imageNamed:@"kuang"] forState:(UIControlStateNormal)];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 1500) {
        _sure.enabled = YES;
        [_sure setTintColor:THEMECOLOR];
        _text.textColor = THEMECOLOR;
    } else {
        _sure.enabled = NO;
        [_sure setTintColor:[UIColor lightGrayColor]];
        _text.textColor = [UIColor lightGrayColor];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self post];
}

- (void)post {
    
    [mFNotiCenter postNotificationName:@"buttonClicekYES" object:@"buttonYES" userInfo:@{@"bool":[NSNumber numberWithBool:self.isSel]}];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
