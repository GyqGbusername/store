//
//  HomePageViewController.m
//  ceshi1
//
//  Created by mfwl on 16/1/26.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "HomePageViewController.h"
#import <AFNetworking.h>



@interface HomePageViewController () <UIWebViewDelegate, MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) UIWebView *webView; /** 主界面webView属性 */
@property (nonatomic, strong) UIWebView *phoneWebView; /** 拨打电           */
@property (nonatomic, strong) UIImageView *firstImage;


@end

@implementation HomePageViewController



/* 创建一个全屏的webView */
- (void)createWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 10)];/* 留出iPhone上方的时间状态栏 */
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:WEBURL]]];
    self.webView.delegate = self;/* 签订代理 */
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self MBP];
    
}
- (void)setFirstImage {
    self.firstImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, kScreen_Width, kScreen_Height- 10)];
    self.firstImage.image = [UIImage imageNamed:@"soy"];
    [self.view addSubview:self.firstImage];
}

- (void)MBP {
    HUD = [[MBProgressHUD alloc] init];
    [self.view addSubview:HUD];
    HUD.dimBackground = YES;
    HUD.delegate = self;
    HUD.labelText = @"Loading...";
//    HUD.detailsLabelText = @"新年动画";
    [HUD show:YES];
}



/* web访问url抓取 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *tempStr = [request URL].absoluteString; /* 取出截取的请求URL 转换成NSString用于下面判断 */
    if ([tempStr isEqualToString:QQURL]) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL *url = [NSURL URLWithString:PHONEIOSURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
        return NO;
    } else if ([tempStr isEqualToString:PHONEWEBURL]) {
        [self callPhone];
        return NO;
    }
    return YES;
}

/* 拨打电话 */
- (void)callPhone {
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", PHONENUM]];
    if (!self.phoneWebView) {
        self.phoneWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    }
    [self.phoneWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
  
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.firstImage removeFromSuperview];
    [UIView animateWithDuration:2 animations:^{
        HUD.backgroundColor = [UIColor clearColor];
        HUD.alpha = 0.1;
    } completion:^(BOOL finished) {
        [HUD removeFromSuperview];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createWebView];
    
}


- (BOOL)shouldAutorotate {
    if (![DEVICEMODEL isEqualToString:@"iPad"]) {
        return NO;
    } else {
        return YES;
    }
    
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
