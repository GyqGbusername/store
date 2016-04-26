//
//  OrderVC.m
//  MFSC
//
//  Created by mfwl on 16/3/18.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "OrderVC.h"
#import "OrderCCell.h"


#define orginx self.buttonBKV.frame.origin.x


@interface OrderVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *back;



@property (strong, nonatomic) IBOutlet UIView *buttonBKV;
@property (strong, nonatomic)UICollectionView *orderCollectionV;

@property (strong, nonatomic) IBOutlet UIButton *all;
@property (strong, nonatomic) IBOutlet UIButton *waitPay;
@property (strong, nonatomic) IBOutlet UIButton *waitSend;

@property (strong, nonatomic) IBOutlet UIButton *waitReceive;

@end

@implementation OrderVC

- (void)dealloc {
    _orderCollectionV.delegate = nil;
    _orderCollectionV.dataSource = nil;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createCollectionView];
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    return self;
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(kScreen_Width, kScreen_Height - 102);
    flow.scrollDirection = 1;
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    self.orderCollectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    
    self.orderCollectionV.pagingEnabled = YES;
    self.orderCollectionV.delegate = self;
    self.orderCollectionV.dataSource = self;
    self.orderCollectionV.backgroundColor = [UIColor whiteColor];
    self.orderCollectionV.showsHorizontalScrollIndicator = NO;
    self.orderCollectionV.showsVerticalScrollIndicator = NO;
    self.orderCollectionV.bounces = NO;
    [self.orderCollectionV registerClass:[OrderCCell class] forCellWithReuseIdentifier:@"orderCCell"];
    [self.view addSubview:self.orderCollectionV];
    [self.orderCollectionV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonBKV.mas_bottom);
        make.right.left.bottom.equalTo(self.view);
    }];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    for (UIButton *button in self.buttonBKV.subviews) {
        [button setTitleColor:[UIColor colorWithRed:45 / 255.0 green:45 / 255.0 blue:45 / 255.0 alpha:1.0] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize: 13];
    }
    int i = scrollView.contentOffset.x / kScreen_Width;
    [self setColor:i];
    [self postNotiWith:i];
}

- (void)postNotiWith:(NSInteger)page {
    
    [mFNotiCenter postNotificationName:@"pageNum" object:@"page" userInfo:@{@"page":[NSString stringWithFormat:@"%ld", (long)page]}];
}




- (void)setColor:(NSInteger)i {
    switch (i) {
        case 0:
            break;
        case 1: {
            self.waitPay.titleLabel.font = [UIFont systemFontOfSize: 15];
            [self.waitPay setTitleColor:THEMECOLOR forState:(UIControlStateNormal)];
        }
            
            break;
        case 2: {
            self.waitSend.titleLabel.font = [UIFont systemFontOfSize: 15];
            [self.waitSend setTitleColor:THEMECOLOR forState:(UIControlStateNormal)];
        }
            
            break;
        case 3: {
            self.waitReceive.titleLabel.font = [UIFont systemFontOfSize: 15];
            [self.waitReceive setTitleColor:THEMECOLOR forState:(UIControlStateNormal)];
        }
            break;
        default:
            break;
    }
    [self.back reloadInputViews];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrderCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"orderCCell" forIndexPath:indexPath];
    cell.tempPage = self.tempStartPoint;
    return cell;
}


- (IBAction)location:(UIButton *)sender {
    for (UIButton *button in self.buttonBKV.subviews) {
        [button setTitleColor:[UIColor colorWithRed:45 / 255.0 green:45 / 255.0 blue:45 / 255.0 alpha:1.0] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize: 13];
    }
    [sender setTitleColor:THEMECOLOR forState:(UIControlStateNormal)];
    switch (sender.tag) {
        case 741:{
      
            self.tempStartPoint = 0;
            [self.orderCollectionV setContentOffset:CGPointMake(0, 0) animated:YES] ;
            
        }
            break;
        case 742: {
            self.tempStartPoint = 1;
            [self.orderCollectionV setContentOffset:CGPointMake(kScreen_Width, 0) animated:true];
            sender.titleLabel.font = [UIFont systemFontOfSize: 15];
        }
            break;
        case 743: {
            self.tempStartPoint = 2;
            sender.titleLabel.font = [UIFont systemFontOfSize: 15];
            [self.orderCollectionV setContentOffset:CGPointMake(2 *kScreen_Width, 0) animated:true];
            
        }
            break;
        case 744: {
            self.tempStartPoint = 3;
            sender.titleLabel.font = [UIFont systemFontOfSize: 15];
            [self.orderCollectionV setContentOffset:CGPointMake(3 * kScreen_Width, 0) animated:true];
        }
            break;
    }
    [self postNotiWith:self.tempStartPoint];
}

#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    if (!self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = YES;
    }
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setTempStartPoint:(NSInteger)tempStartPoint {
    if (_tempStartPoint != tempStartPoint) {
        _tempStartPoint = tempStartPoint;
    }
    [self.orderCollectionV setContentOffset:CGPointMake(tempStartPoint * kScreen_Width, 0) animated:YES];
    [self setColor:tempStartPoint];
    [self.orderCollectionV reloadData];
}


#pragma mark 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
   
   
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
