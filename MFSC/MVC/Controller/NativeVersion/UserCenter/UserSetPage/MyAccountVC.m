//
//  MyAccountVC.m
//  MFSC
//
//  Created by mfwl on 16/3/3.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "MyAccountVC.h"
#import "AccountListTCell.h"
#import "AddressVC.h"
#import "ChangeUserNameVC.h"
#import "LocalCityVC.h"
#import "BirthDayVC.h"
#import "PwdChangePwdVC.h"
#import "BindingTeleVC.h"
#import "LoginVC.h"

@interface MyAccountVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *accountListTV;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIButton *backButton;


/* titleV */
@property (nonatomic, strong) UIView *titleBV;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIButton *back;



@end

@implementation MyAccountVC
- (void)dealloc {
    _accountListTV.delegate = nil;
    _accountListTV.dataSource = nil;
    [_backButton removeTarget:self action:@selector(backButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [_back removeTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataArr = @[@{@"title":@"用户名", @"img":@"wodezhanghu"}, @{@"title":@"常驻城市", @"img":@"chengshi"}, @{@"title":@"收货地址", @"img":@"shouhuodizhi"}, @{@"title":@"生日", @"img":@"shengri"}, @{@"title":@"账户安全等级", @"img":@""}, @{@"title":@"已绑手机号", @"img":@"shoujihao"}, @{@"title":@"登录密码", @"img":@"mima"}];
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}

/* 保存数据到NSUserDefaults */
- (void)saveNSUserDefaultsWith:(NSString *)str {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:@"token"];
    /* 这里建议同步存储到磁盘中，不写也可以建议写 */
    [userDefaults synchronize];
}

- (void)setTitle {
    _titleBV = [[UIView alloc] init];
    [self.view addSubview:_titleBV];
    _back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_back setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [_back setTintColor:[UIColor whiteColor]];
    [_back addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.titleBV addSubview:_back];
    
    _nameLB = [[UILabel alloc] init];
    [_titleBV addSubview:_nameLB];
    _nameLB.text = @"我的账户";
    _nameLB.textAlignment = 0;
    _nameLB.textColor = [UIColor whiteColor];
    _nameLB.font = [UIFont systemFontOfSize:17];
    _titleBV.backgroundColor = THEMECOLOR;
    
}

- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)messageBTClick:(UIButton *)button {
    [self.navigationController pushViewController:[MessageVC shareMessageVC] animated:YES];
}
#pragma mark 添加约束
- (void)addMasnory {
    [_titleBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBV).offset(8);
        make.top.equalTo(self.titleBV).with.offset(30);
        make.height.width.equalTo(@25);
       
    }];
    [_nameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back.mas_right).offset(10);
        make.top.equalTo(self.titleBV).with.offset(32);
        make.height.equalTo(@21);
        make.width.equalTo(@68);
    }];
}



- (void)createAccountListTV {
    self.accountListTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width,  400) style:(UITableViewStylePlain)];
    [self.view addSubview:self.accountListTV];
    [self.accountListTV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleBV.mas_bottom);
        make.height.equalTo(@400);
        make.left.right.equalTo(self.view);
        
    }];
    
    self.accountListTV.delegate = self;
    self.accountListTV.dataSource = self;
    self.accountListTV.scrollEnabled = NO;
    self.accountListTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.accountListTV registerClass:[AccountListTCell class] forCellReuseIdentifier:@"MyAccountVC_AccountListTCell"];
    
}


/* 判断当前屏幕状态 */
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:{
            /* home在下 */
            self.accountListTV.scrollEnabled = NO;
            [self.accountListTV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@400);
            }];
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            /* home在上 */
        
            break;
        case UIInterfaceOrientationLandscapeLeft:
            /* home在左 */
            self.accountListTV.scrollEnabled = YES;
            [self.accountListTV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@300);
            }];
            break;
        case UIInterfaceOrientationLandscapeRight:
            /* home在右 */
            self.accountListTV.scrollEnabled = YES;
            [self.accountListTV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@300);
            }];
            break;
        default:
            break;
    }
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 == section) {
        return 4;
    }
    else return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountListTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAccountVC_AccountListTCell"];
    if (0 == indexPath.section) {
        cell.dic = self.dataArr[indexPath.row];
    } else {
        cell.dic = self.dataArr[indexPath.row + 4];
        if (indexPath.row == 0) {
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0:{
                    ChangeUserNameVC *changeName = [[ChangeUserNameVC alloc] init];
#warning 用户名 传入 junpDoor
                    changeName.userName = @"用户名";
                    [self.navigationController pushViewController:changeName animated:YES];
                }
                    break;
                case 1: {
                    LocalCityVC *city = [[LocalCityVC alloc]init];
                    [self.navigationController pushViewController:city animated:YES];
                }

                    break;
                case 2: {
                    AddressVC *address = [[AddressVC alloc] init];
                    [self.navigationController pushViewController:address animated:YES];
                }
                    
                    break;
                case 3: {
                    BirthDayVC *birthDay = [[BirthDayVC alloc] init];
                    [self.navigationController pushViewController:birthDay animated:YES];
                }
                    
                    break;
            }
        }
            break;
        case 1: {
            switch (indexPath.row) {
                case 0:
                    
                    break;
                case 1: {
                    BindingTeleVC * bingTele = [[BindingTeleVC alloc] init];
                    [self.navigationController pushViewController:bingTele animated:YES];
                }
                    
                    break;
                case 2: {
                    PwdChangePwdVC *pwdVC = [[PwdChangePwdVC alloc] init];
                    [self.navigationController pushViewController:pwdVC animated:YES];
                }
                    break;
            }
        }
            break;
    }
}

- (void)createBackButton {
    self.backButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width * 0.85, 40));
        make.top.equalTo(self.accountListTV.mas_bottom).with.offset(20);
    }];
    
    [self.backButton setTitle:@"注销" forState:(UIControlStateNormal)];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:19];
    self.backButton.backgroundColor = [UIColor redColor];
    self.backButton.layer.cornerRadius = 8;
    self.backButton.layer.masksToBounds = YES;
    [self.backButton addTarget:self action:@selector(backButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
- (void)backButton:(UIButton *)button {
#warning 退出登录
    [self saveNSUserDefaultsWith:@"0"];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle];
    [self addMasnory];
    [self createAccountListTV];
    [self createBackButton];
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
