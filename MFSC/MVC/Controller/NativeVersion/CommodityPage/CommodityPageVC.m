//
//  CommodityPageVC.m
//  MFSC
//
//  Created by mfwl on 16/3/15.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "CommodityPageVC.h"
#import "ScrollerVTCell.h"
#import "ImageVC.h"
#import "SuitspecificationsView.h"
#import "CommentsPageVC.h"
#import "StoreVC.h"

@interface CommodityPageVC ()<UITableViewDataSource,UITableViewDelegate, ScrollerVTCellDelegate, ClearBVDelegate, TitleListViewDelegate> {
    id __block selectAllComments;
    id __block goodfunction;
}
@property (strong, nonatomic) IBOutlet UITableView *commodityTV;
@property (strong, nonatomic) IBOutlet UIView *navi;

@property (nonatomic, strong) NSArray *cellArr;

@property (nonatomic, strong) SuitspecificationsView *suit;

@property (strong, nonatomic) IBOutlet UIButton *buyNow;


@property (strong, nonatomic) IBOutlet UIButton *shoppingCar;

@property (strong, nonatomic) IBOutlet UIImageView *collectionImage;
@property (strong, nonatomic) IBOutlet UILabel *collectionTitle;


@property (strong, nonatomic) IBOutlet UIButton *storeBT;

@property (nonatomic, assign) BOOL isCollection;


@property (nonatomic, strong) MKNumberBadgeView *mkView;
@property (strong, nonatomic) IBOutlet UIImageView *shopImage;


#pragma mark titleList
@property (nonatomic, strong) ClearBV *clearBV;

@property (nonatomic, strong) TitleListView *titleView;


@end

@implementation CommodityPageVC

- (void)dealloc {
    _clearBV.delegate = nil;
    _titleView.delegate = nil;
    _commodityTV.delegate =nil;
    _commodityTV.dataSource = nil;
   
}

- (instancetype)init
{
    self = [super init];
    if (self) {
#pragma mark collection
        self.isCollection = NO;
        self.cellArr = @[@"ScrollerVTCell", @"IntroduceTCell", @"SalespromotionTCell", @"PackageinformationTCell", @"GoodscommentsTCell", @"IntroducestoreTCell", @"AllGoodsAndCommentsTCell"];
        self.commodityTV.delegate = self;
        self.commodityTV.dataSource = self;
        self.mkView = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(self.shopImage.frame.size.width - 10, -10, 25, 25)];
        [self.shopImage addSubview:self.mkView];
        self.mkView.textFormat = @"25";
        self.mkView.font = [UIFont systemFontOfSize:7];
        
    }
    return self;
}



- (void)viewWillAppear:(BOOL)animated {
    if (self.tabBarController.tabBar.hidden == NO) {
        self.tabBarController.tabBar.hidden = YES;
    }
    if (self.navigationController.navigationBarHidden == NO) {
        self.navigationController.navigationBarHidden = YES;
    }
    [self noti];
}

- (void)viewWillDisappear:(BOOL)animated {
    [mFNotiCenter removeObserver:selectAllComments];
    [mFNotiCenter removeObserver:goodfunction];

}




#pragma mark tabBar点击事件
- (IBAction)tabBTClick:(UIButton *)sender {
    switch (sender.tag) {
        case 677:
            
            break;
        case 678: {
#pragma mark 进入购物车
            BOOL tempHave = NO;
            BaseController *cv = nil;
            NSInteger tempNum = 0;
            for (BaseController *shop in self.navigationController.viewControllers) {
                tempNum++;
                if ([shop isKindOfClass:[ShoppingCartViewController class]]) {
                    cv = shop;
                    tempHave = YES;
                    break;
                }
            }
            if (tempHave) {
                if (tempNum == 1) {
                    self.tabBarController.tabBar.hidden = NO;
                } else {
                    self.tabBarController.tabBar.hidden = YES;
                }
                [self.navigationController popToViewController:cv animated:YES];
            } else {
                 [self.navigationController pushViewController:[ShoppingCartViewController shareShopCar] animated:YES];
            }
           
        }
            break;
        case 679:
#pragma mark 收藏按钮
            [self collection];
            break;
        case 680: {
#pragma mark 进入店铺
            [self store];
        }
            break;
    }
}

- (void)store {
    BOOL tempHave = NO;
    BaseController *cv = nil;
    for (BaseController *store in self.navigationController.viewControllers) {
        if ([store isKindOfClass:[StoreVC class]]) {
            cv = store;
            tempHave = YES;
            break;
        }
    }
    if (tempHave) {
        [self.navigationController popToViewController:cv animated:YES];
    } else  {
        StoreVC *store= [[StoreVC alloc] init];
        [self.navigationController pushViewController:store animated:YES];
    }
}


- (void)collection {
    if (!self.isCollection) {
        [self.collectionImage setImage:[UIImage imageNamed:@"sshoucang"]];
        self.collectionTitle.text = @"已收藏";
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
       
        
    } else  {
        [self.collectionImage setImage:[UIImage imageNamed:@"shoucang"]];
         self.collectionTitle.text = @"收藏";
       
        [SVProgressHUD showInfoWithStatus:@"取消收藏"];
        
    }
    self.isCollection = !self.isCollection;
    
}

#pragma mark 加入购物车
- (IBAction)addShopCar:(id)sender {
    [SVProgressHUD showSuccessWithStatus:@"已添加到购物车"];
}

#pragma mark titleList show

- (IBAction)showList:(id)sender {
    if (!self.clearBV) {
        self.clearBV = [[ClearBV alloc] init];
        [[[UIApplication sharedApplication].delegate window] addSubview:_clearBV];
        [_clearBV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo([[UIApplication sharedApplication].delegate window]);
        }];
        _clearBV.delegate = self;
        self.titleView = [[TitleListView alloc] init];
        self.titleView.dicArr = @[@{@"img":@"lingdang",@"content":@"消息"}, @{@"img":@"home",@"content":@"首页"},@{@"img":@"fenxiang",@"content":@"分享"}];
        self.titleView.delegate = self;
        [_clearBV addSubview:_titleView];
        [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navi.mas_bottom);
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
            self.tabBarController.tabBar.hidden = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
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
                [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                break;
            }
            case SSDKResponseStateFail:
            {
                [SVProgressHUD showErrorWithStatus:@"分享成功"];
                break;
            }
            default:
                break;
        }
    }];
}


- (void)closeSelf {
    _clearBV = nil;
}



- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    NSInteger tempNum = 0;
    for (BaseController *bc in self.navigationController.viewControllers) {
        tempNum ++;
        if ([bc isKindOfClass:[ShoppingCartViewController class]]) {
            break;
        }
    }
    if (tempNum ==1) {
        self.tabBarController.tabBar.hidden = NO;
    } else {
        self.tabBarController.tabBar.hidden = YES;
    }

}


#pragma mark 通知中心

- (void)noti {
    WS(weakSelf);
    selectAllComments = [mFNotiCenter addObserverForName:@"selectAllComments" object:@"selectAll" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        CommentsPageVC *adVC = [[CommentsPageVC alloc] init];
        [weakSelf.navigationController pushViewController:adVC animated:YES];
    }];
    
    goodfunction = [[NSNotificationCenter defaultCenter] addObserverForName:@"goodfunction" object:@"good" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        switch ( [[note.userInfo objectForKey:@"num"] integerValue]) {
            case 416: {
#pragma mark 联系客服
            }
                
                break;
                
            case 417: {
                
                [self store];
                
            }
                break;
        }
       
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self noti];
   
    // Do any additional setup after loading the view from its nib.
}




#pragma  mark tV date
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = nil;
    BaseModel *model = nil;
    NSString *cellName = self.cellArr[indexPath.section];
    cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [CellFactory creatCellWithClassName:cellName cellModel:model indexPath:indexPath];
    }
    if (indexPath.section == 0) {
        ScrollerVTCell *cell1 = (ScrollerVTCell *)cell;
        cell1.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)jumpWith:(NSInteger)tag {
    ImageVC *imageVC = [[ImageVC alloc] init];
    imageVC.tempOffSet = tag;
    [self.navigationController pushViewController:imageVC animated:YES];
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 253;
            break;
            case 1:
            return 120;
            break;
        case 4:
            return 180;
            break;
        case 5:
            return 70;
            break;
        case 6:
            return 130;
            break;
        default:
            return 44;
            break;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 5;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 5;
            break;
        case 4:
            return 5;
            break;
        case 6:
            return 5;
            break;
        default:
            return CGFLOAT_MIN;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 3: {
            [self setSuitView];
            [self setSuitMas];
        }
            break;
            
        case 4:  {
            CommentsPageVC *comments = [[CommentsPageVC alloc] init];
            comments.selectIndex = 1;
            [self.navigationController pushViewController:comments animated:YES];
        }
            break;
            
            
        default:
            
            break;
    }
}

#pragma mark SuitspecificationsView懒加载 
- (void)setSuitView {
    _suit = [[SuitspecificationsView alloc] init];
    [[[UIApplication sharedApplication].delegate window] addSubview:_suit];
}

- (void)setSuitMas {
    [_suit mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo([[UIApplication sharedApplication].delegate window]);
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
