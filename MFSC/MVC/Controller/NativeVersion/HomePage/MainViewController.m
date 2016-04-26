//
//  MainViewController.m
//  MFSC
//
//  Created by mfwl on 16/2/16.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "MainViewController.h"
#import "TitleCCell.h"
#import "HomePageCCell.h"
#import "HomePageSecCCell.h"
#import "IntroduceVC.h"
#import "ClassVC.h"
#import "ADViewController.h"
#import "SearchVC.h"
#import "CommodityPageVC.h"
#import "StoreVC.h"
#import "RecommendListVC.h"
#import "GuessYourLikeVC.h"




@interface MainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate, UISearchBarDelegate> {
    NSString *allPlist;
    NSString *name;
    id __block change;
    id __block recommend;
    id __block jump;
    id __block storeDoor;
    id __block MainlastGoods;
    id __block feedModel;
    id __block ShufflingFigureView;
    id __block adImage;
}


/* titleV */
@property (nonatomic, strong) UIView *titleBV;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UIImageView *searchBar;
@property (nonatomic, strong) UIButton *messageBT;
@property (nonatomic, strong) UISearchBar *search;

@property (nonatomic, strong) NSMutableDictionary *dic;
/* 标题栏 */
@property (nonatomic, strong) UICollectionView *titleCollection;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, assign) NSInteger tempNum;
@property (nonatomic, strong) UILabel *lineLabel;


/* contentCollection */
@property (nonatomic, strong) UICollectionView *contentCollection;


@end

@implementation MainViewController


- (void)dealloc {
    _titleCollection.dataSource = nil;
    _titleCollection.delegate = nil;
    _contentCollection.delegate = nil;
    _contentCollection.dataSource = nil;
    [_titleCollection removeObserver:self forKeyPath:@"contentOffset"];
    
    [mFNotiCenter removeObserver:change];
    [mFNotiCenter removeObserver:recommend];
    [mFNotiCenter removeObserver:jump];
    [mFNotiCenter removeObserver:storeDoor];
    [mFNotiCenter removeObserver:MainlastGoods];
    [mFNotiCenter removeObserver:feedModel];
    [mFNotiCenter removeObserver:ShufflingFigureView];
    [mFNotiCenter removeObserver:adImage];
}



/** 初始化前事件 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleArr = @[@"推荐", @"饲料", @"兽药", @"添加剂", @"原料", @"机械设备", @"畜禽"];
        [self setTitle];
        [self addMasnory];
        [self setNaviColor];
        [self firstRunning];
        [self createLineLabel];
        
    }
    return self;
}

#pragma mark 视图将出现

- (void)viewWillAppear:(BOOL)animated {
    
    if (!self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = YES;
    }
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
    
#pragma mark 不显示首页时停止轮播图
    [self postNotiCenterWith:YES];
}


#pragma mark 设置titleV
- (void)setTitle {
    _titleBV = [[UIView alloc] init];
    [self.view addSubview:_titleBV];
    _titleImage = [[UIImageView alloc] init];
    _search = [[UISearchBar alloc] init];
#pragma mark searchbar去灰色北京
    for (UIView *view in self.search.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    self.search.backgroundColor = THEMECOLOR;
    self.search.delegate = self;
    self.search.placeholder = @"搜索麦丰商品/店铺";
    [self.titleBV addSubview:_search];
    _messageBT = [UIButton buttonWithType:UIButtonTypeSystem];
    [_messageBT setTintColor:[UIColor whiteColor]];
    [self.titleBV addSubview:_titleImage];
    [_messageBT setImage:[UIImage imageNamed:@"lingdang"] forState:(UIControlStateNormal)];
    [_messageBT addTarget:self action:@selector(messageBTClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_titleImage setImage:[UIImage imageNamed:@"biaozhi"]];
    [self.titleBV addSubview:_messageBT];
    _titleBV.backgroundColor = THEMECOLOR;
    [_titleBV addSubview:_searchBar];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    SearchVC *search = [[SearchVC alloc] init];
    [self.navigationController pushViewController:search animated:YES];
    search.navigationController.navigationBarHidden = YES;
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
    [_titleImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBV).offset(8);
        make.top.equalTo(self.titleBV).with.offset(30);
        make.height.width.equalTo(@25);
    }];
    [_messageBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleBV).offset(-15);
        make.width.height.equalTo(@25);
        make.top.equalTo(self.titleBV).offset(30);
    }];
    [_search mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.messageBT.mas_left).offset(-10);
        make.height.equalTo(@30);
        make.top.equalTo(self.titleBV).offset(27);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width * 0.7]);
    }];
    
}

#pragma mark 视图将消失
- (void)viewWillDisappear:(BOOL)animated {
    [self postNotiCenterWith:NO];
}

- (void)postNotiCenterWith:(BOOL)is     {
   
    [mFNotiCenter postNotificationName:@"mainVC" object:@"sufferView" userInfo:@{@"code":[NSNumber numberWithBool:is]}];
}


#pragma marl title 效果
- (void)createLineLabel {
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 102, kScreen_Width / 5, 2)];
    self.lineLabel.backgroundColor = THEMECOLOR;
    [self.view addSubview:self.lineLabel];
}


- (void)firstRunning {
    allPlist = [[NSBundle mainBundle] pathForResource:@"TitleList" ofType:@"plist"];
    self.dic = [NSMutableDictionary dictionaryWithContentsOfFile:allPlist];
    name = [self.dic objectForKey:@"FirstRunning"];
}




#pragma  mark 试图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTitleCollectionView];
    [self createContenCollection];
    [self notificationHandle];
    
}



#pragma mark 标题导航
/* 标题导航 */
- (void)createTitleCollectionView  {
    UICollectionViewFlowLayout  *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 1;
    flow.itemSize = CGSizeMake(kScreen_Width / 5, 38);
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    self.titleCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, 38) collectionViewLayout:flow];
    self.titleCollection.delegate = self;
    self.titleCollection.dataSource = self;
    self.titleCollection.showsHorizontalScrollIndicator = NO;
    self.titleCollection.showsVerticalScrollIndicator= NO;
    self.titleCollection.backgroundColor = [UIColor redColor];
    [self.titleCollection registerClass:[TitleCCell class] forCellWithReuseIdentifier:@"MainViewController_TitleCCell"];
    self.titleCollection.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.titleCollection addObserver:self forKeyPath:@"contentOffset" options:1 | 2 context:nil];
    
}


#pragma mark 内容展示collection
- (void)createContenCollection {
    UICollectionViewFlowLayout  *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 1;
    flow.itemSize = CGSizeMake(kScreen_Width , kScreen_Height - 153);
    flow.minimumInteritemSpacing = 0;
    flow.minimumLineSpacing = 0;
    self.contentCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, kScreen_Width, kScreen_Height - 153) collectionViewLayout:flow];
    self.contentCollection.delegate = self;
    self.contentCollection.dataSource = self;
    self.contentCollection.pagingEnabled = YES;
    self.contentCollection.showsHorizontalScrollIndicator = NO;
    self.contentCollection.showsVerticalScrollIndicator= NO;
    self.contentCollection.backgroundColor = [UIColor redColor];
    [self.contentCollection registerClass:[HomePageCCell class] forCellWithReuseIdentifier:@"MainViewController_HomePageCCell"];
    [self.contentCollection registerClass:[HomePageSecCCell class] forCellWithReuseIdentifier:@"MainViewController_HomePageSecCCell"];
    [self.view addSubview:self.titleCollection];
    self.contentCollection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentCollection];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint point = [change[@"new"] CGPointValue];
    [self.lineLabel setFrame:CGRectMake(self.tempNum * kScreen_Width / 5 - point.x, 102, kScreen_Width / 5, 2)];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.titleCollection]) {
        TitleCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainViewController_TitleCCell" forIndexPath:indexPath];
        cell.label1.text = self.titleArr[indexPath.item];
        cell.tempStr = self.titleArr[indexPath.item];
        return cell;
    } else {
        if (indexPath.item == 0) {
            HomePageCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainViewController_HomePageCCell" forIndexPath:indexPath];
            cell.homePageTableView.contentOffset = CGPointMake(0, 0);
            return cell;
        } else {
            HomePageSecCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainViewController_HomePageSecCCell" forIndexPath:indexPath];
            cell.homePageTableView.contentOffset = CGPointMake(0, 0);
            return cell;
        }
    }
}


#pragma mark item点击事件

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.titleCollection]) {
        self.tempNum = indexPath.item;
        for (NSInteger i = 0; i < collectionView.subviews.count; i++) {
            TitleCCell *cell1 = (TitleCCell *)[collectionView.subviews objectAtIndex:i];
            cell1.label1.textColor = TEXTCOLOR;
        }
        TitleCCell *cell = (TitleCCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if ([cell.label1.text isEqualToString:@"推荐"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(0, 0);
                
            }];
        }
        if ([cell.label1.text isEqualToString:@"饲料"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width / 5, 0);
            }];
        }
        if ([cell.label1.text isEqualToString:@"兽药"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
            }];
        }
        if ([cell.label1.text isEqualToString:@"添加剂"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
        if ([cell.label1.text isEqualToString:@"原料"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 2 / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
        if ([cell.label1.text isEqualToString:@"机械设备"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 3 / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
        if ([cell.label1.text isEqualToString:@"畜禽"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 4 / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
        cell.label1.textColor = STEXTCOLOR;
        [self.dic setObject:cell.label1.text forKey:@"FirstRunning"];
        [self.dic writeToFile:allPlist atomically:YES];
        [self.contentCollection setContentOffset:CGPointMake(kScreen_Width * indexPath.item, 0) animated:YES];
    } else {
        
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.contentCollection]) {
        self.tempNum = self.contentCollection.contentOffset.x / kScreen_Width;
        [self.dic setObject:self.titleArr[self.tempNum] forKey:@"FirstRunning"];
        [self.dic writeToFile:allPlist atomically:YES];
        if ([self.titleArr[self.tempNum] isEqualToString:@"推荐"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(0, 0);
                
            }];
        }
        if ([self.titleArr[self.tempNum] isEqualToString:@"饲料"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width / 5, 0);
            }];
        }
        if ([self.titleArr[self.tempNum] isEqualToString:@"兽药"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
            }];
        }
        if ([self.titleArr[self.tempNum] isEqualToString:@"添加剂"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
        if ([self.titleArr[self.tempNum] isEqualToString:@"原料"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 2 / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
        if ([self.titleArr[self.tempNum] isEqualToString:@"机械设备"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 3 / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
        if ([self.titleArr[self.tempNum] isEqualToString:@"畜禽"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 4 / 5, 102, kScreen_Width / 5, 2)];
            }];
        }
    }
    [self.titleCollection reloadData];
}


- (void)notificationHandle {
    
    WS(weakSelf);
    change = [mFNotiCenter addObserverForName:@"change" object:@"intro" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        IntroduceVC *introVC = [[IntroduceVC alloc] init];
        [weakSelf.navigationController pushViewController:introVC animated:YES];
        introVC.title = [note .userInfo objectForKey:@"push"];
    }];
    recommend = [mFNotiCenter addObserverForName:@"recommend" object:@"activity" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        switch ([[note.userInfo objectForKey:@"push"] integerValue]) {
            case 0: {
                RecommendListVC *store = [[RecommendListVC alloc] init];
                [weakSelf.navigationController pushViewController:store animated:YES];
                store.title = [note .userInfo objectForKey:@"push"];
            }
                break;
                
            case 1: {
                GuessYourLikeVC *like = [[GuessYourLikeVC alloc] init];
                [weakSelf.navigationController pushViewController:like animated:YES];
            }
                
                break;
            case 2: {
                
            }
                
                break;
        }
        
        
       
        
    }];
#pragma mark good
    
    MainlastGoods = [mFNotiCenter addObserverForName:@"MainlastGoods" object:@"Mainlast" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        CommodityPageVC *commodityVC = [[CommodityPageVC alloc] init];
        [weakSelf.navigationController pushViewController:commodityVC animated:YES];
        
    }];

    feedModel = [mFNotiCenter addObserverForName:@"feedModel" object:@"feed" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        ClassVC *classVC = [[ClassVC alloc] init];
        [weakSelf.navigationController pushViewController:classVC animated:YES];
        classVC.title = [note .userInfo objectForKey:@"push"];
    }];
    
    jump = [mFNotiCenter addObserverForName:@"jump" object:@"type" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        static NSInteger num = 0;
        NSString *str = [note .userInfo objectForKey:@"push"];
        [self.dic setObject:str forKey:@"FirstRunning"];
        [self.dic writeToFile:allPlist atomically:YES];
        if ([str isEqualToString:@"饲料"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width / 5, 0);
                [self.lineLabel setFrame:CGRectMake(0, 102, kScreen_Width / 5, 2)];
                num = 1;
            }];
        }
        if ([str isEqualToString:@"兽药"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(0, 102, kScreen_Width / 5, 2)];
                num = 2;
            }];
        }
        if ([str isEqualToString:@"添加剂"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width / 5, 102, kScreen_Width / 5, 2)];
                num = 3;
            }];
        }
        if ([str isEqualToString:@"原料"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 2 / 5, 102, kScreen_Width / 5, 2)];
                num = 4;
            }];
        }
        if ([str isEqualToString:@"机械设备"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 3 / 5, 102, kScreen_Width / 5, 2)];
                num = 5;
            }];
        }
        if ([str isEqualToString:@"畜禽"]) {
            [UIView animateWithDuration:0.5 animations:^{
                self.titleCollection.contentOffset = CGPointMake(kScreen_Width * 2 / 5, 0);
                [self.lineLabel setFrame:CGRectMake(kScreen_Width * 4 / 5, 102, kScreen_Width / 5, 2)];
                num = 6;
            }];
        }
        [self.contentCollection setContentOffset:CGPointMake(kScreen_Width * num, 0) animated:YES];
        self.tempNum = num;
        
        [self.titleCollection reloadData];
        
    }];
#pragma mark good 横
    storeDoor = [mFNotiCenter addObserverForName:@"storeDoor" object:@"door" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
         CommodityPageVC *commodityVC = [[CommodityPageVC alloc] init];
        [weakSelf.navigationController pushViewController:commodityVC animated:YES];
        
    }];
    
    adImage = [mFNotiCenter addObserverForName:@"adImage" object:@"ad" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        ADViewController *adVC = [[ADViewController alloc] init];
        [weakSelf.navigationController pushViewController:adVC animated:YES];
        adVC.title = [note .userInfo objectForKey:@"push"];
        
    }];
    
#pragma mark 轮播图跳转
   ShufflingFigureView = [mFNotiCenter addObserverForName:@"ShufflingFigureView" object:@"ShufflingFigure" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
      
        
    }];
    
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
