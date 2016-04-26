//
//  ShoppingCartViewController.m
//  MFSC
//
//  Created by mfwl on 16/2/16.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "BlackView.h"
#import "MayAlsoWantTCell.h"




@interface ShoppingCartViewController () <UITableViewDataSource, UITableViewDelegate, ClearBVDelegate, TitleListViewDelegate,MayAlsoWantTCellDelegate> {
    NSInteger token;
}

/* titleV */
@property (nonatomic, strong) UIView *titleBV;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIButton *messageBT;
@property (nonatomic, strong) UIButton *back;

/* tabV */
@property (nonatomic, strong) UIView *downBV;
@property (nonatomic, strong) UIButton *settlement;

@property (nonatomic, strong) UIButton *selectAll;
@property (nonatomic, strong) UILabel *all;
@property (nonatomic, assign) BOOL isChoose;


@property (nonatomic, strong) UILabel *combined; /* 合计 */
@property (nonatomic, strong) UILabel *money;
@property (nonatomic, strong) UILabel * freight;


@property (nonatomic, strong) UIView *topbv;
@property (nonatomic, strong) UIButton *topBt;

#pragma mark tableView
@property (nonatomic, strong) UITableView *shopCarTableView;


@property (nonatomic, strong) TitleListView *titleView;
@property (nonatomic, strong) ClearBV *clearBV;
@property (nonatomic, strong) ResultSignView *resultBV;

@end

@implementation ShoppingCartViewController


- (void)dealloc {
    _shopCarTableView.dataSource = nil;
    _shopCarTableView.delegate = nil;
    [_selectAll removeTarget:self action:@selector(selectAll:) forControlEvents:(UIControlEventTouchUpInside)];
    [_settlement removeTarget:self action:@selector(settlement:) forControlEvents:(UIControlEventTouchUpInside)];
    [_shopCarTableView removeObserver:self forKeyPath:@"contentOffset"];
    
    [_messageBT removeTarget:self action:@selector(xuanxiang:) forControlEvents:(UIControlEventTouchUpInside)];
    [_messageBT removeTarget:self action:@selector(message:) forControlEvents:(UIControlEventTouchUpInside)];
}

+ (instancetype)shareShopCar {
    static ShoppingCartViewController *message = nil;
    if (message == nil) {
        message = [[ShoppingCartViewController alloc] init];
    }
    return message;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isChoose = NO;
        
        [self setTitle];
        [self addMasnory];
        [self setTabBV];
        [self addMasnoryTabBV];
        [self createTableView];
        [self setTop];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

#pragma mark goTop
- (void)setTop {
    self.topbv = [[UIView alloc] init];
    self.topbv.backgroundColor = THEMECOLOR;
    self.topbv.layer.cornerRadius = 30;
    self.topbv.layer.masksToBounds = YES;
    self.topbv.alpha = 0;
    [self.view addSubview:_topbv];
    [_topbv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.right.equalTo(self.view).offset(-8);
        make.bottom.equalTo(self.downBV.mas_top).offset(-8);
    }];
    self.topBt = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.topbv addSubview:_topBt];
    [self.topBt setTintColor:[UIColor whiteColor]];
    [self.topBt setImage:[UIImage imageNamed:@"gotop"] forState:(UIControlStateNormal)];
    [self.topBt addTarget:self action:@selector(topBt:) forControlEvents:(UIControlEventTouchUpInside)];
    [_topBt mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.center.equalTo(self.topbv);
    }];
}
- (void)topBt:(UIButton *)button {
    [_shopCarTableView setContentOffset:CGPointMake(0, 0)];
    
#pragma mark ceshi
  
}

#pragma mark tableView and date

- (void)createTableView {
    self.shopCarTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
    [self.view addSubview:_shopCarTableView];
    _shopCarTableView.delegate = self;
    _shopCarTableView.dataSource = self;
    [_shopCarTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBV.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.downBV.mas_top);
    }];
    [_shopCarTableView addObserver:self forKeyPath:@"contentOffset" options:1 | 2 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint point = [[change objectForKey:@"new"] CGPointValue];
    
    if (!self.topbv.hidden && point.y < 300) {
        self.topbv.hidden = YES;
    }

    if(point.y > 300) {
        self.topbv.alpha = (point.y - kScreen_Width / 2) / kScreen_Width / 2;
        if (self.topbv.hidden) {
            self.topbv.hidden = NO;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:;
            return 3;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    switch (indexPath.section) {
        case 2: {
            static NSString *strCell = @"MayAlsoWantTCell";
            MayAlsoWantTCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
            if (!cell) {
                cell = [[[NSBundle mainBundle]loadNibNamed:strCell owner:nil options:nil] firstObject];
            }
            cell. delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            break;
            
        default: {
            
            switch (indexPath.row) {
                case 0: {
                    BaseTableViewCell *cell = nil;
                    BaseModel *model = nil;
                    static NSString *strCell = @"ShopCarStoreTCell";
                    cell = [tableView dequeueReusableCellWithIdentifier:strCell];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:strCell cellModel:model indexPath:indexPath];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                    
                }
                    break;
                    
                default: {
                    BaseTableViewCell *cell = nil;
                    BaseModel *model = nil;
                    static NSString *strCell = @"ShopCarListTCell";
                    cell = [tableView dequeueReusableCellWithIdentifier:strCell];
                    if (!cell) {
                        cell = [CellFactory creatCellWithClassName:strCell cellModel:model indexPath:indexPath];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
            }

        }
            
            break;
    }
    
    
}

- (void)passContent:(NSString *)content {
    CommodityPageVC *commod = [[CommodityPageVC alloc] init];
    [self.navigationController pushViewController:commod animated:YES];
}

#pragma mark cell 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            StoreVC *store = [[StoreVC alloc] init];
            [self.navigationController pushViewController:store animated:YES];
        }
            break;
            
        default: {
            CommodityPageVC *commod = [[CommodityPageVC alloc] init];
            [self.navigationController pushViewController:commod animated:YES];
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 2:
            return ((kScreen_Width - 30) / 2 + 60) * 5 + 60;
            break;
            
        default: {
            switch (indexPath.row) {
                case 0:
                    return 44;
                    break;
                    
                default:
                    return 120;
                    break;
            }

        }
            break;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 40;
            break;
            
        default:
            return 10;
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 70;
            break;
            
        default:
            return CGFLOAT_MIN;
            break;
    }
   
}

#pragma  mark  tableView headerView and FooderView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *vi = nil;
    switch (section) {
        case 2: {
            vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
            
            UILabel *leftLb = [[UILabel alloc
                                ] init];
            leftLb.backgroundColor = [UIColor lightGrayColor];
            [vi addSubview:leftLb];
            [leftLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreen_Width / 3, 0.5));
                make.centerY.equalTo(vi);
                make.left.equalTo(vi);
            }];
            UILabel *rightLb = [[UILabel alloc] init];
            [vi addSubview:rightLb];
            rightLb.backgroundColor = [UIColor lightGrayColor];
            [rightLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreen_Width / 3, 0.5));
                make.centerY.equalTo(vi);
                make.right.equalTo(vi);
            }];
            UILabel *lb = [[UILabel alloc] init];
            lb.text = @"您可能还想要";
            lb.textAlignment = 1;
            lb.textColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0];
            lb.font = [UIFont systemFontOfSize:14];
            [vi addSubview:lb];
            [lb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(rightLb.mas_left).offset(-5);
                make.centerY.equalTo(vi);
                make.size.mas_equalTo(CGSizeMake(kScreen_Width / 4, 20));
            }];
            UIImageView *imgV = [[UIImageView alloc] init];
            [vi addSubview:imgV];
            imgV.image = [UIImage imageNamed:@"downjian"];
            [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(vi);
                make.right.equalTo(lb.mas_left);
                make.size.mas_equalTo(CGSizeMake(20, 20));
            }];

        }
            
            break;
            
        default:
            
            break;
    }
    return vi;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *vi = nil;
    switch (section) {
        case 2: {
            vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 70)];
            
            UILabel *leftLb = [[UILabel alloc
                                ] init];
            leftLb.backgroundColor = [UIColor lightGrayColor];
            [vi addSubview:leftLb];
            [leftLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreen_Width / 2 - 40, 0.5));
                make.top.equalTo(vi).offset(20);
                make.left.equalTo(vi);
            }];
            UILabel *rightLb = [[UILabel alloc] init];
            [vi addSubview:rightLb];
            rightLb.backgroundColor = [UIColor lightGrayColor];
            [rightLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kScreen_Width / 2 - 40, 0.5));
                make.top.equalTo(vi).offset(20);
                make.right.equalTo(vi);
            }];
            UILabel *lb = [[UILabel alloc] init];
            lb.text = @"以上商品根据您购物车已有商品推荐";
            lb.textAlignment = 1;
            lb.textColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0];
            lb.font = [UIFont systemFontOfSize:13];
            [vi addSubview:lb];
            [lb mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(vi).offset(-5);
                make.left.right.equalTo(vi);
                make.height.equalTo([NSNumber numberWithFloat:20]);
            }];
            UIImageView *imgV = [[UIImageView alloc] init];
            [vi addSubview:imgV];
            imgV.image = [UIImage imageNamed:@"pig"];
            [imgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(vi).offset(10);
                make.right.equalTo(rightLb.mas_left).offset(-20);
                make.left.equalTo(leftLb.mas_right).offset(20);
                make.height.equalTo([NSNumber numberWithInteger:30]);
            }];
        }
            break;
            
        default:
            
            break;
    }

    return vi;
}


#pragma mark noti

- (void)noti {

}




#pragma mark tabbar

- (void)setTabBV {
    self.downBV = [[UIView alloc] init];
    [self.view addSubview:self.downBV];
    self.downBV.backgroundColor = [UIColor whiteColor];
    self.selectAll = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.downBV addSubview:_selectAll];
    [self.selectAll setImage:[UIImage imageNamed:@"choosed"] forState:(UIControlStateNormal)];
    [self.selectAll setTintColor:[UIColor blackColor]];
    [self.selectAll addTarget:self action:@selector(selectAll:) forControlEvents:(UIControlEventTouchUpInside)];
    self.all = [[UILabel alloc] init];
    [self.downBV addSubview:self.all];
    self.all.text = @"全选";
    self.all.textAlignment = 1;
    self.all.font = [UIFont systemFontOfSize:14];
    self.settlement = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.downBV addSubview:_settlement];
    _settlement.backgroundColor = THEMECOLOR;
    [_settlement setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _settlement.titleLabel.font = [UIFont systemFontOfSize:19];
    [_settlement setTitle:[NSString stringWithFormat:@"结算(%@)",@"2"] forState:(UIControlStateNormal)];
    [self.settlement addTarget:self action:@selector(settlement:) forControlEvents:(UIControlEventTouchUpInside)];
    self.combined = [[UILabel alloc] init];
    [self.downBV addSubview:_combined];
    self.combined.text = @"合计:";
    self.combined.textAlignment = 2;
    self.combined.font = [UIFont systemFontOfSize:17];
    self.money = [[UILabel alloc] init];
    [self.downBV addSubview:_money];
    _money.text = @"￥ 55555";
    _money.font = [UIFont systemFontOfSize:16];
    _money.textAlignment = 2;
    _money.textColor = THEMECOLOR;
    
    self.freight = [[UILabel alloc] init];
    [self.downBV addSubview:self.freight];
    self.freight.text = [NSString stringWithFormat:@"运费:%@", @"免运费"];
    self.freight.textAlignment = 1;
    self.freight.font = [UIFont systemFontOfSize:13];
    self.freight.textColor = [UIColor colorWithRed:50 / 255.0 green:50 / 255.0 blue:50 / 255.0 alpha:1.0];
}
- (void)addMasnoryTabBV {
    [_selectAll mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downBV);
        make.left.equalTo(self.downBV).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [_all mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downBV);
        make.left.equalTo(self.selectAll.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    [_settlement mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.downBV);
        make.right.equalTo(self.downBV);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 4, 49));
    }];
    [_money mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.downBV);
        make.right.equalTo(self.settlement.mas_left).offset(-10);
        make.height.equalTo([NSNumber numberWithInteger:29]);
        make.width.equalTo([NSNumber numberWithInteger:15 * _money.text.length * 2 / 3]);
    }];
    [_combined mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.downBV);
        make.right.equalTo(self.money.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 29));
    }];
    [_freight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.downBV);
        make.top.equalTo(self.money.mas_bottom);
        make.right.equalTo(self.settlement.mas_left).offset(-10);
    }];
}


#pragma mark 全选
- (void)selectAll:(UIButton *)button {
    self.isChoose = !self.isChoose;
    if (self.isChoose) {
        [button setImage:[UIImage imageNamed:@"choose"] forState:(UIControlStateNormal)];
        [button setTintColor:[UIColor redColor]];
    } else  {
         [button setImage:[UIImage imageNamed:@"choosed"] forState:(UIControlStateNormal)];
         [button setTintColor:[UIColor blackColor]];
    }
}


#pragma mark 结算
- (void)settlement:(UIButton *)button {
    
}

#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    [_shopCarTableView setContentOffset:CGPointMake(0, 0)];
    token = [[self readNSUserDefaultsLogin] integerValue];
    if (!self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = YES;
    }
   
    if (self.tabBarController.tabBar.hidden) {
        [self yesTab];
       
    } else {
        
        [self noTab];
    }
}
#pragma mark 没tabBar

- (void)yesTab {
    _back.hidden = NO;
    [_messageBT setImage:[UIImage imageNamed:@"xuanxiang"] forState:(UIControlStateNormal)];
    [_messageBT addTarget:self action:@selector(xuanxiang:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBV).offset(30);
        make.left.equalTo(self.titleBV).offset(8);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [_nameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back.mas_right).offset(10);
        make.top.equalTo(self.titleBV).with.offset(32);
        make.height.equalTo(@21);
        make.width.equalTo(@68);
    }];
    [_downBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, 49));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}


#pragma mark 选项列表
- (void)xuanxiang:(UIButton *)button {
    
    if (!self.clearBV) {
        self.clearBV = [[ClearBV alloc] init];
        [[[UIApplication sharedApplication].delegate window] addSubview:_clearBV];
        [_clearBV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo([[UIApplication sharedApplication].delegate window]);
        }];
        _clearBV.delegate = self;
        self.titleView = [[TitleListView alloc] init];
        self.titleView.dicArr = @[@{@"img":@"lingdang",@"content":@"消息"}, @{@"img":@"home",@"content":@"首页"}, @{@"img":@"fenxiang",@"content":@"分享"}];
        self.titleView.delegate = self;
        [_clearBV addSubview:_titleView];
        [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleBV.mas_bottom);
            make.right.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(kScreen_Width / 2, 44 * self.titleView.dicArr.count));
        }];
    } else {
        [self.clearBV removeFromSuperview];
        _clearBV = nil;
    }
}

#pragma mark 代理方法
- (void)postNum:(NSInteger)row {
    [_clearBV removeFromSuperview];
    _clearBV = nil;
    switch (row) {
        case 0:
            [self.navigationController pushViewController:[MessageVC shareMessageVC] animated:YES];
            break;
        case 1:
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.tabBarController.tabBar.hidden = NO;
            break;
            
        case 2:
            [self share];/* 分享 */
            break;
            
       
    }
    
    
}
#pragma mark 分享
- (void)share {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"@51麦丰商城" images:nil url:[NSURL URLWithString:@"http://mob.com"] title:@"@51麦丰商城" type:SSDKContentTypeAuto];
    
    [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                [self resultView:@"分享成功"];
                break;
            }
            case SSDKResponseStateFail:
            {
                [self resultView:@"分享失败"];
                break;
            }
            default:
                break;
        }
    }];
    
}

- (void)resultView:(NSString *)str {
    self.resultBV = [[ResultSignView alloc] initWith:str] ;
    [[[UIApplication sharedApplication].delegate window] addSubview:_resultBV];
    [[[UIApplication sharedApplication].delegate window] bringSubviewToFront:_resultBV];
}

#pragma mark 代理方法
- (void)closeSelf {
    _clearBV = nil;
}



#pragma mark 有tabbar
- (void)noTab {
    _back.hidden = YES;
    [_messageBT setImage:[UIImage imageNamed:@"lingdang"] forState:(UIControlStateNormal)];
    [_messageBT addTarget:self action:@selector(message:) forControlEvents:(UIControlEventTouchUpInside)];
    [_nameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBV).offset(15);
        make.top.equalTo(self.titleBV).with.offset(32);
        make.height.equalTo(@21);
        make.width.equalTo(@68);
    }];
    [_downBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, 49));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
   
}

- (void)message:(UIButton *)button {
    [self.navigationController pushViewController:[MessageVC shareMessageVC] animated:YES];
}

- (void)setTitle {
    _titleBV = [[UIView alloc] init];
    [self.view addSubview:_titleBV];
    _back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_titleBV addSubview:_back];
    [_back setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [_back addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
    [_back setTintColor:[UIColor whiteColor]];
    _nameLB = [[UILabel alloc] init];
    _messageBT = [UIButton buttonWithType:UIButtonTypeSystem];
    [_messageBT setTintColor:[UIColor whiteColor]];
    [_messageBT setImage:[UIImage imageNamed:@"xuanxiang"] forState:(UIControlStateNormal)];
    [self.titleBV addSubview:_messageBT];
    [self.titleBV addSubview:_nameLB];
    _nameLB.text = @"购物车";
    _nameLB.textAlignment = 0;
    _nameLB.textColor = [UIColor whiteColor];
    _nameLB.font = [UIFont systemFontOfSize:17];
    
    _titleBV.backgroundColor = THEMECOLOR;
}



- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 添加约束
- (void)addMasnory {
    [_titleBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    [_messageBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleBV).offset(-15);
        make.width.height.equalTo(@25);
        make.top.equalTo(self.titleBV).offset(30);
    }];
}


- (id)readNSUserDefaultsLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"token"]; /* 读取 */
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self noti];
    // Do any additional setup after loading the view.
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
