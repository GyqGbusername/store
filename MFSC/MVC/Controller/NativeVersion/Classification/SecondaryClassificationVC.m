//
//  SecondaryClassificationVC.m
//  MFSC
//
//  Created by mfwl on 16/4/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SecondaryClassificationVC.h"
#import "ButtonTableView.h"
#import "ClassGoodsCCell.h"

@interface SecondaryClassificationVC () <ButtonTableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *bv;

@property (strong, nonatomic) IBOutlet UIButton *titleBT;
@property (strong, nonatomic) IBOutlet UIButton *otherBT;
@property (strong, nonatomic) IBOutlet UIView *titleBV;



@property (strong, nonatomic) UICollectionView *collectionListView;







#pragma mark buttonView
@property (strong, nonatomic) ButtonTableView *buttonTableView;

@property (nonatomic, assign) NSInteger tempTag;


@end

@implementation SecondaryClassificationVC

- (void)dealloc {
    _buttonTableView.delegate = nil;
    _collectionListView.delegate
    = nil;
    _collectionListView.dataSource = nil;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tempTag = 0;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}




- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





- (IBAction)titleBT:(UIButton *)sender {
    for (NSInteger i = 1; i < 3; i++) {
        UIButton *button = _bv.subviews[i];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:THEMECOLOR forState:(UIControlStateNormal)];
    }
    [sender setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    sender.backgroundColor = THEMECOLOR;
    
    if (!_buttonTableView) {
        [self setButtonTableViewAuWith:sender.tag];
        _tempTag = sender.tag;
    } else {
        if (_tempTag == sender.tag) {
            [_buttonTableView removeFromSuperview];
            _buttonTableView = nil;
            [sender setTitleColor:THEMECOLOR forState:(UIControlStateNormal)];
            sender.backgroundColor = [UIColor whiteColor];
        } else {
            _tempTag = sender.tag;
            [self setPlaceWith:sender.tag];
        }
    }
 }

#pragma mark 添加列表View
- (void)setButtonTableViewAuWith:(NSInteger)tag {
    self.buttonTableView = [[ButtonTableView alloc] init];
    [self.view addSubview:self.buttonTableView];
    _buttonTableView.delegate = self;
    [self setPlaceWith:tag];
   
}

#pragma mark 判断列表位置

- (void)setPlaceWith:(NSInteger)tag {
    switch (tag) {
        case 722: {
            
            [_buttonTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.bv.mas_bottom);
                make.left.equalTo(self.view);
                make.height.equalTo([NSNumber numberWithInteger:kScreen_Height - 104]);
                make.width.equalTo([NSNumber numberWithInteger:kScreen_Width / 2]);
            }];
        }
            break;
        case 723: {
           
            [_buttonTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.bv.mas_bottom);
                make.right.equalTo(self.view);
                make.height.equalTo([NSNumber numberWithInteger:kScreen_Height - 104]);
                make.width.equalTo([NSNumber numberWithInteger:kScreen_Width / 2]);
            }];
        }
            break;
    }

}

- (void)pass:(NSString *)name {
    for (NSInteger i = 1; i < 3; i++) {
        UIButton *button = _bv.subviews[i];
        button.backgroundColor = [UIColor clearColor];
        [button setTitleColor:THEMECOLOR forState:(UIControlStateNormal)];
    }
    
    [_buttonTableView removeFromSuperview];
    _buttonTableView = nil;
    switch (_tempTag) {
        case 722: {
            UIButton *button = self.bv.subviews[1];
            button.titleLabel.text = name;
            [button setTitle:name forState:(UIControlStateNormal)];
        }
            break;
            
        case 723:
            
            break;
    }
#pragma mark 刷新数据
    
    
}


#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCollectionListView];
    // Do any additional setup after loading the view from its nib.
}



- (void)setCollectionListView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 0;
    flow.itemSize = CGSizeMake((kScreen_Width - 30) / 2, (kScreen_Width - 30) / 2 + 60);
    flow.minimumLineSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    [self.view addSubview:_collectionListView];
    [_collectionListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.bv.mas_bottom);
    }];
    _collectionListView.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:248 / 255.0 blue:249 / 255.0 alpha:1.0];
    _collectionListView.delegate = self;
    _collectionListView.dataSource = self;
    self.collectionListView.showsHorizontalScrollIndicator = NO;
    self.collectionListView.showsVerticalScrollIndicator = NO;
    [self.collectionListView registerNib:[UINib nibWithNibName:@"ClassGoodsCCell" bundle:nil] forCellWithReuseIdentifier:@"ClassGoodsCCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassGoodsCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassGoodsCCell" forIndexPath:indexPath];
 
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CommodityPageVC *commodity = [[CommodityPageVC alloc] init];
    [self.navigationController pushViewController:commodity animated:YES];
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
