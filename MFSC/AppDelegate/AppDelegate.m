//
//  AppDelegate.m
//  MFSC
//
//  Created by mfwl on 16/1/28.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "GuideViewController.h"


@interface AppDelegate () <GuideViewControllerDelegate>

@property (nonatomic, strong) GuideViewController *guidePage;


@end

@implementation AppDelegate

- (void)dealloc {
    _guidePage.delegate = nil;
}





- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self judgeFirstPage];
    [self setAppKeyandSecret];
    
    return YES;
}

- (void)setAppKeyandSecret {
    [SMSSDK registerApp:sMSKey
             withSecret:sMSSecret];
    [ShareSDK registerApp:shareSDKKey activePlatforms:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
                
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
                
           
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:sinaKey
                                          appSecret:sinaSecret
                                        redirectUri:redirectURL
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQKey
                                     appKey:QQSecret
                                   authType:SSDKAuthTypeBoth];
                break;
                
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:wxKey
                                      appSecret:wxSecret];
                break;
           
                
            default:
                break;
        }
    }];
}

/* 判断是否第一次运行 */
- (void)judgeFirstPage {
    /* NSUserDefaults轻型存储工具, 用于存储一个字符串并判断引导页是否出现 */
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults stringForKey:@"guideStr"] isEqualToString:@"NO"]) {  
        [self gotoMainPage];
    } else {
        /* 添加根试图7.0之后没有根试图程序无法运行 */
        self.guidePage = [[GuideViewController alloc] init];
        self.guidePage.delegate = self;
        self.window.rootViewController = self.guidePage;
    }
}


- (void)jump {
    [self gotoMainPage];
}


#warning jumpdoor

/* 跳转主页 */
- (void)gotoMainPage {
    [self jumpNative];
}

- (void)jumpNative {
    
    MainViewController *mainPage = [[MainViewController alloc] init];
    mainPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页" image:[UIImage imageNamed:@"index01"] selectedImage:[UIImage imageNamed:@"index"]];
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:mainPage];
    
    ClassificationViewController *classFicationPage = [[ClassificationViewController alloc] init];
    /* 给首页VC添加视图管理器 */
    classFicationPage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分类" image:[UIImage imageNamed:@"sosuo01"] selectedImage:[UIImage imageNamed:@"sosuo"]];
    UINavigationController *classFicationPageNC = [[UINavigationController alloc] initWithRootViewController:classFicationPage];
    
    /* 创建搭配页面 */
    ShoppingCartViewController *shopCar = [[ShoppingCartViewController  alloc] init];;
    shopCar.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"购物车" image:[UIImage imageNamed:@"shop01"] selectedImage:[UIImage imageNamed:@"shop"]];
    UINavigationController *shopCarNC = [[UINavigationController alloc] initWithRootViewController:shopCar];
    
    /* 创建本地页面 */
    UserViewController *userVC = [[UserViewController alloc] init];
    UINavigationController *userNC =[[UINavigationController alloc] initWithRootViewController:userVC];
    userVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"用户" image:[UIImage imageNamed:@"wode01"] selectedImage:[UIImage imageNamed:@"wode"]];
    UITabBarController *mainTab = [[UITabBarController alloc] init];
    mainTab.viewControllers = @[mainNC, classFicationPageNC, shopCarNC, userNC];
    mainTab.tabBar.tintColor = THEMECOLOR;
    self.window.rootViewController = mainTab;
}
- (void)jumpWeb {
    
    HomePageViewController *homePage = [[HomePageViewController alloc] init];
    self.window.rootViewController = homePage;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
