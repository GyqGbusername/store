//
//  MessageVC.m
//  MFSC
//
//  Created by mfwl on 16/2/19.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()

/* titleV */
@property (nonatomic, strong) UIView *titleBV;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIButton *remove;
@property (nonatomic, strong) UIButton *back;

@end

@implementation MessageVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setTitle];
        [self addMasnory];
    }
    return self;
}


- (void)setTitle {
    _titleBV = [[UIView alloc] init];
    [self.view addSubview:_titleBV];
    
    _nameLB = [[UILabel alloc] init];
    _remove = [UIButton buttonWithType:UIButtonTypeSystem];
    [_remove setTintColor:[UIColor whiteColor]];
    [self.titleBV addSubview:_nameLB];
    [_remove setImage:[UIImage imageNamed:@"laji"] forState:(UIControlStateNormal)];
    [_remove addTarget:self action:@selector(removeBTClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _nameLB.text = @"消息列表";
    _nameLB.textAlignment = 0;
    _nameLB.textColor = [UIColor whiteColor];
    _nameLB.font = [UIFont systemFontOfSize:17];
    [self.titleBV addSubview:_remove];
    _titleBV.backgroundColor = THEMECOLOR;
    _back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_titleBV addSubview:_back];
    [_back setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [_back addTarget:self action:@selector(backBTClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_back setTintColor:[UIColor whiteColor]];
}
- (void)removeBTClick:(UIButton *)button {
#pragma mark 删除全部
    
}

- (void)backBTClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
    NSInteger tempNum = 0;
    for (BaseController *bv in self.navigationController.viewControllers) {
        tempNum++;
        if ([bv isKindOfClass:[ShoppingCartViewController class]]) {
            break;
        }
    }
    
    if (tempNum == 1) {
        self.tabBarController.tabBar.hidden = NO;
    } else {
        self.tabBarController.tabBar.hidden = YES;
    }
}
#pragma mark 添加约束
- (void)addMasnory {
    [_titleBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
   
    [_remove mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleBV).offset(-15);
        make.width.height.equalTo(@25);
        make.top.equalTo(self.titleBV).offset(30);
    }];
    [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBV).offset(8);
        make.width.height.equalTo(@25);
        make.top.equalTo(self.titleBV).offset(30);
    }];
    [_nameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_back.mas_right).offset(10);
        make.top.equalTo(self.titleBV).with.offset(32);
        make.height.equalTo(@21);
        make.width.equalTo(@68);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}




+ (instancetype)shareMessageVC {
    static MessageVC *message = nil;
    if (message == nil) {
        message = [[MessageVC alloc] init];
    }
    return message;
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
