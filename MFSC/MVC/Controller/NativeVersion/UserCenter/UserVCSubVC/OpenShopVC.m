//
//  OpenShopVC.m
//  MFSC
//
//  Created by mfwl on 16/3/22.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "OpenShopVC.h"

@interface OpenShopVC () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *onLine;
@property (strong, nonatomic) IBOutlet UIView *phone;
@property (nonatomic, strong) UIWebView *phoneWebView;
@property (strong, nonatomic) IBOutlet UITextView *tv;

@end

@implementation OpenShopVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (IBAction)back:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}


- (void)setConsulting {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1:)];
    self.onLine.userInteractionEnabled = YES;
    self.phone.userInteractionEnabled = YES;
    [self.onLine addGestureRecognizer:tap];
    [self.phone addGestureRecognizer:tap1];
}
- (void)tap:(UITapGestureRecognizer *)tap {
    [self QQ];
}

- (void)tap1:(UITapGestureRecognizer *)tap {
    [self callPhone];
}

- (void)QQ {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSURL *url = [NSURL URLWithString:PHONEIOSURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.delegate = self;
    [webView loadRequest:request];
    [self.view addSubview:webView];
}
/* 拨打电话 */
- (void)callPhone {
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", PHONENUM]];
    
    if (!self.phoneWebView) {
        self.phoneWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [self.phoneWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tv.scrollsToTop = YES;
    [self setConsulting];
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
