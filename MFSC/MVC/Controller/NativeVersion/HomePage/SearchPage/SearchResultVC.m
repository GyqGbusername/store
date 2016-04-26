//
//  SearchResultVC.m
//  MFSC
//
//  Created by mfwl on 16/3/11.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SearchResultVC.h"
#import "SearchCCell.h"

@interface SearchResultVC ()<UISearchBarDelegate, UITableViewDataSource,UITableViewDelegate, UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *naviView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchB;
@property (strong, nonatomic) IBOutlet UIButton *backBT;
@property (strong, nonatomic) IBOutlet UIView *titleBar;

@property (strong, nonatomic) IBOutlet UIButton *fenleiStyle;
@property (strong, nonatomic) IBOutlet UITableView *resultTV;
@property (strong, nonatomic) UICollectionView *resultCV;

#pragma mark YES t NO c
@property (nonatomic, assign) BOOL isSelect;

@end


@implementation SearchResultVC


- (void)dealloc {
    _searchB.delegate = nil;
    _resultTV.delegate = nil;
    _resultTV.dataSource = nil;
    _resultCV.delegate = nil;
    _resultCV.dataSource = nil;
}


- (IBAction)fenlei:(UIButton *)sender {
    self.isSelect = !self.isSelect;
    if (self.isSelect) {
#pragma mark TList
        self.resultCV.hidden = YES;
        [sender setImage:[UIImage imageNamed:@"tfenlei"] forState:(UIControlStateNormal)];
        self.resultTV.hidden = NO;
    } else {
#pragma mark CList
        self.resultTV.hidden = YES;
        [sender setImage:[UIImage imageNamed:@"cfenlei"] forState:(UIControlStateNormal)];
        self.resultCV.hidden = NO;
    }
}



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isSelect = YES;
        self.searchB.delegate = self;
        self.resultTV.delegate = self;
        self.resultTV.dataSource = self;
        self.resultTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
     
        self.resultTV.hidden = NO;
        [self setResultCVAu];
    }
    return self;
}


- (void)setResultCVAu {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake((kScreen_Width - 30) / 2, (kScreen_Width - 30) / 2 + 30);
    flow.scrollDirection = 0;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.resultCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, kScreen_Width, kScreen_Height - 104) collectionViewLayout:flow];
    [self.view addSubview:self.resultCV];
    self.resultCV.backgroundColor = [UIColor whiteColor];
    [self.resultCV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleBar.mas_bottom);
        make.right.left.bottom.equalTo(self.view);
    }];
    self.resultCV.dataSource = self;
    self.resultCV.delegate = self;
    
    [self.resultCV registerNib:[UINib nibWithNibName:@"SearchCCell" bundle:nil] forCellWithReuseIdentifier:@"SearchCCell"];
    self.resultCV.hidden = YES;
}


- (void)setTempStr:(NSString *)tempStr {
    if (_tempStr != tempStr) {
        _tempStr = tempStr;
    }
    self.searchB.text = self.tempStr;
    [self.searchB becomeFirstResponder];
}


- (void)setSearchController {
    for (UIView *view in self.searchB.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    self.searchB.backgroundColor = THEMECOLOR;
}


- (IBAction)option:(UIButton *)sender {
    for (UIButton *button in self.titleBar.subviews) {
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    switch (sender.tag) {
        case 85: {
            [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        }
            break;
            
        case 86:{
            [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        }
            break;
            
        case 87:{
            [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        }
            break;
        
    }
}



- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSearchController];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark tableview datesource;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *tempTCell = @"TempTCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tempTCell];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SearchTCell" owner:self options:nil];
    if ([nib count] > 0)
    {
        self.searchTCell = [nib objectAtIndex:0];
        cell = self.searchTCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommodityPageVC *comVC = [[CommodityPageVC alloc] init];
    [self.navigationController pushViewController:comVC animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark collectionview datesource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCCell" forIndexPath:indexPath];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CommodityPageVC *comVC = [[CommodityPageVC alloc] init];
    [self.navigationController pushViewController:comVC animated:YES];
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
