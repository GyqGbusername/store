//
//  BaseController.m
//  ceshi1
//
//  Created by mfwl on 16/1/26.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:248 /255.0 blue:249 / 255.0 alpha:1.0f];
        
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setNaviColor {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];  
    [[UINavigationBar appearance] setBarTintColor:THEMECOLOR];
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
