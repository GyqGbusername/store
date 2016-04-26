//
//  StoreVC.m
//  MFSC
//
//  Created by mfwl on 16/3/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "StoreVC.h"
#import "CommentsPageVC.h"
#import "StoreIntroduceVC.h"
#import "LastTCell.h"
#import "StoreGoodsListVC.h"



@interface StoreVC () <UITableViewDataSource, UITableViewDelegate, TitleListViewDelegate, ClearBVDelegate> {
    id __block Seetheevaluation;
    
    id __block lastGoods;
    id __block introduceBT;
}


@property (strong, nonatomic) IBOutlet UIView *navi;
@property (strong, nonatomic) IBOutlet UITableView *listTBV;

@property (nonatomic, strong) UIView *overlay;
@property (nonatomic, strong) NSArray *cellArr;
@property (nonatomic, strong) ResultSignView *resultBV;

@property (nonatomic, strong) TitleListView *titleView;

#pragma mark 二维码

@property (nonatomic, strong) UIView *bv;
@property (nonatomic, strong) NSArray *features;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UIButton *closeBT;

@property (nonatomic, strong) ClearBV *clearBV;

@end

@implementation StoreVC

- (void)dealloc {
    _listTBV.delegate = nil;
    _listTBV.dataSource = nil;
    _titleView.delegate = nil;
    _clearBV.delegate = nil;
    [mFNotiCenter removeObserver:Seetheevaluation];
    [mFNotiCenter removeObserver:lastGoods];
    [mFNotiCenter removeObserver:introduceBT];
    [_closeBT removeTarget:self action:@selector(closeBT:) forControlEvents:(UIControlEventTouchUpInside)];
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cellArr = @[@"StoreTitleTCell", @"StoreBTTCell", @"StoreIntroAndImageTCell"];
        _listTBV.dataSource = self;
        _listTBV.delegate = self;
        [_listTBV registerClass:[LastTCell class] forCellReuseIdentifier:@"storeClassesTCell"];
        _listTBV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}
#pragma mark  返回
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
#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    if (self.navigationController.navigationBarHidden == NO) {
        self.navigationController.navigationBarHidden = YES;
    }
    if (self.tabBarController.tabBar.hidden == NO) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
    if (indexPath.row == 3) {
        LastTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"storeClassesTCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentArr = @[@{@"com": @"万嘉",@"name": @"血浆蛋白", @"title":@"喷雾干燥猪血浆蛋白粉 NP - 2009", @"img" : @"danchang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}];
        return cell;
    } else {
        BaseTableViewCell *cell = nil;
        BaseModel *model = [BaseModel modelWithDictionary:@{@"name":@"123"}];
        NSString *cellName = self.cellArr[indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [CellFactory creatCellWithClassName:cellName cellModel:model indexPath:indexPath];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 216;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 271;
            break;
        case 3:
            return ((kScreen_Width - 30) / 2 + 70) * 5;
            break;
        default:
            return 10;
            break;
    }
}

#pragma mark  通知中心
- (void)noti {
    WS(weakSelf);
    lastGoods = [mFNotiCenter addObserverForName:@"lastGoods" object:@"last" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        CommodityPageVC *commodityVC = [[CommodityPageVC alloc] init];
        [weakSelf.navigationController pushViewController:commodityVC animated:YES];
        
    }];
    Seetheevaluation = [mFNotiCenter addObserverForName:@"Seetheevaluation" object:@"Seetheevaluation" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        CommentsPageVC *comments = [[CommentsPageVC     alloc] init];
        [weakSelf.navigationController pushViewController:comments animated:YES];
        comments.title = [note .userInfo objectForKey:@"push"];
    }];

    introduceBT = [mFNotiCenter addObserverForName:@"introduceBT" object:@"introduceBT" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        StoreIntroduceVC *storeIntro = [[StoreIntroduceVC alloc] init];
        [self.navigationController pushViewController:storeIntro animated:YES];
    }];
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
            [self Qr];
            break;
            
        case 3:
            [self share];/* 分享 */
            break;
    }
    

}


#pragma mark 识别二维码
- (void)Qr {
    if (!self.bv) {
        self.bv = [[UIView alloc] init];
        [[[UIApplication sharedApplication].delegate window] addSubview:_bv];
        _bv.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [_bv mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.bottom.equalTo([[UIApplication sharedApplication].delegate window]);
        }];
        [self setImage];
        [self setLb];
        [self setCloseBT];
    }
}

#pragma mark 二维码图片 入口
- (void)setImage {
    self.imageV = [[UIImageView alloc] init];
    [_bv addSubview:_imageV];
    [_imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo([[UIApplication sharedApplication].delegate window]);
        make.width.equalTo([NSNumber numberWithInteger:kScreen_Width / 2]);
        make.height.equalTo([NSNumber numberWithInteger:kScreen_Width / 2]);
    }];
    _imageV.image = [UIImage imageNamed:@"weixingongzhonghao"];
    _imageV.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
    longTap.minimumPressDuration = 2;
    [_imageV addGestureRecognizer:longTap];
}

- (void)setLb {
    UILabel *lb = [[UILabel alloc] init];
    [_bv addSubview:lb];
    [lb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imageV.mas_top).with.offset(-10);
        make.height.equalTo(@50);
        make.centerX.equalTo(_bv);
        make.width.equalTo(@200);
    }];
    lb.numberOfLines = 2;
    lb.text = @"长按二维码识别,关注店家微信公众号";
    lb.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    lb.textColor = [UIColor whiteColor];
    lb.textAlignment = 1;
}

#pragma mark 长按事件

- (void)longTap:(UILongPressGestureRecognizer *)longTap {
    
    self.features = [self detectQRCode:_imageV.image];
    
    if(_features.count > 0)
    {
        CIQRCodeFeature *code = [_features firstObject];
        
        NSURL * url = [NSURL URLWithString: code.messageString];
        if ([[UIApplication sharedApplication] canOpenURL: url]) {
            [[UIApplication sharedApplication] openURL: url];
            [_bv removeFromSuperview];
        } else {
            [self resultView:@"无法解析二维码"];
        
        }
        NSLog(@"识别结果:%@",code.messageString);
    }
}

#pragma mark 获取二维码
-(NSArray *)detectQRCode:(UIImage *)qrcodeImage
{
    NSDictionary *opts=@{CIDetectorAccuracy:CIDetectorAccuracyHigh};
    CIDetector *detector=[CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:opts];
    CIImage *cimage=[CIImage imageWithCGImage:qrcodeImage.CGImage];
    NSArray *features=[detector featuresInImage:cimage];
    return features;
}


- (void)setCloseBT {
    
    self.closeBT = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_bv addSubview:self.closeBT];
    [_closeBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@50);
        make.right.equalTo(_bv).with.offset(-15);
        make.top.equalTo(_bv).with.offset(30);
    }];
    
    [_closeBT setImage:[UIImage imageNamed:@"cha"] forState:(UIControlStateNormal)];
    [_closeBT setTintColor:[UIColor lightGrayColor]];
    [_closeBT addTarget:self action:@selector(closeBT:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)closeBT:(UIButton *)button {
    [_bv removeFromSuperview];
    _bv = nil;
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
#pragma mark 代理方法
- (void)closeSelf {
    _clearBV = nil;
}

- (IBAction)showList:(id)sender {
    
    if (!self.clearBV) {
        self.clearBV = [[ClearBV alloc] init];
        [[[UIApplication sharedApplication].delegate window] addSubview:_clearBV];
        [_clearBV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo([[UIApplication sharedApplication].delegate window]);
        }];
        _clearBV.delegate = self;
        self.titleView = [[TitleListView alloc] init];
        self.titleView.dicArr = @[@{@"img":@"lingdang",@"content":@"消息"}, @{@"img":@"home",@"content":@"首页"},@{@"img":@"erweimabai",@"content":@"公众号"},@{@"img":@"fenxiang",@"content":@"分享"}];
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


- (void)resultView:(NSString *)str {
    self.resultBV = [[ResultSignView alloc] initWith:str] ;
    [[[UIApplication sharedApplication].delegate window] addSubview:_resultBV];
    [[[UIApplication sharedApplication].delegate window] bringSubviewToFront:_resultBV];
}



- (IBAction)storeGoodsList:(id)sender {
    StoreGoodsListVC *storeGoodsVC = [[StoreGoodsListVC alloc] init];
    [self.navigationController pushViewController:storeGoodsVC animated:YES];
    
}

- (IBAction)home:(id)sender {
    [_listTBV setContentOffset:CGPointMake(0, 0) animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self noti];
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
