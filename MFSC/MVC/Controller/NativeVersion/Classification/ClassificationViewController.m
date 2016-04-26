//
//  ClassificationViewController.m
//  MFSC
//
//  Created by mfwl on 16/3/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ClassificationViewController.h"
#import "SecondDirTCell.h"
#import "ClassListView.h"
#import "SecondaryClassificationVC.h"

@interface ClassificationViewController ()<UITableViewDataSource, UITableViewDelegate, ClassListViewDelegate> {
    id __block observerGoodsCell;
}



@property (strong, nonatomic) IBOutlet UITableView *secondaryDirectoryTV;
@property (nonatomic, strong) ClassListView *classListView;


@end

@implementation ClassificationViewController

- (void)dealloc {
    _classListView.delegate = nil;
    _secondaryDirectoryTV.delegate = nil;
    _secondaryDirectoryTV.dataSource = nil;
    [mFNotiCenter removeObserver:observerGoodsCell];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
      
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.secondaryDirectoryTV.delegate = self;
        self.secondaryDirectoryTV.dataSource = self;
        [self.secondaryDirectoryTV registerClass:[SecondDirTCell class] forCellReuseIdentifier:@"SecondaryDireTCell"];
    }
    return self;
}

#pragma  mark titleList
- (void)addClassListView {
    self.classListView = [[ClassListView alloc] initWith:@[@"热门推荐", @"兽药", @"饲料", @"机械设备", @"添加剂", @"原料", @"畜禽"] with:0];
   
    self.classListView.delegate = self;
    [self.view addSubview:self.classListView];
    [self.classListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.width.equalTo(@100);
        make.height.equalTo([NSNumber numberWithInteger:kScreen_Height - 113]);
    }];
}

- (void)ClassListViewDidSelectTitleName:(NSString *)titleName {
    
    [self.secondaryDirectoryTV reloadData];
    NSLog(@"%@", titleName);
}


#pragma mark tbv data

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.section) {
        case 0: {
            static NSString *adcell = @"adcell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:adcell];
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AdCell" owner:self options:nil];
            if ([nib count] > 0) {
                self.adCell = [nib objectAtIndex:0];
                cell = self.adCell;
            }
            return cell;
        }
            break;
            
        default: {
            
            SecondDirTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondaryDireTCell"];
            
            return cell;
        }
            break;
    }
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 110;
            break;
            
        default:
            return 185;
            break;
            
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return CGFLOAT_MIN;
            break;
            
        default:
            return 40;
            break;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}




#pragma mark tbv titleV
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bv = nil;
    if (section == 0) {
        return bv;
    }
    bv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 265, 40)];
    bv.backgroundColor = [UIColor clearColor];
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 265, 10)];
    [img setImage:[UIImage imageNamed:@"soyline"]];
    [bv addSubview:img];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(65, 10,135, 20)];
    lb.textAlignment = 1;
    lb.textColor = [UIColor lightGrayColor];
    lb.text = @"家畜药";
    [bv addSubview:lb];
    return bv;
}


#pragma mark 视图将要出现
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    if (self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

#pragma mark 视图加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addClassListView];
    [self addNoti];
}

#pragma mark 通知中心
- (void)addNoti {
    observerGoodsCell = [mFNotiCenter addObserverForName:@"goodsCellName" object:@"goodsCellName" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        SecondaryClassificationVC *secondaryClassVC = [[SecondaryClassificationVC alloc] init];
        [self.navigationController pushViewController:secondaryClassVC animated:YES];
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
