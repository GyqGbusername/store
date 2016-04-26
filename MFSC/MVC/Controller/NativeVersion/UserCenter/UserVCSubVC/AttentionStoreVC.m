//
//  AttentionStoreVC.m
//  MFSC
//
//  Created by mfwl on 16/3/22.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "AttentionStoreVC.h"


@interface AttentionStoreVC () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UITableView *showTBV;
@property (nonatomic, strong) NSArray *cellArr;

@end

@implementation AttentionStoreVC

- (IBAction)change:(UISegmentedControl *)sender {
    NSLog(@"%ld", (long)self.segment.selectedSegmentIndex);
    [self.showTBV setContentOffset:CGPointMake(0, 0) animated:NO];
    [self.showTBV reloadData];
}

- (void)dealloc {
    _showTBV.delegate = nil;
    _showTBV.dataSource = nil;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellArr = @[@"AttentionGoodsTCell", @"AttentionStoresTCell"];
    }
    return self;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setTBV {
    self.showTBV.delegate = self;
    self.showTBV.dataSource = self;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = nil;
    BaseModel *model = nil;
    NSString *cellName = self.cellArr[self.segment.selectedSegmentIndex];
    cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [CellFactory creatCellWithClassName:cellName cellModel:model indexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.segment.selectedSegmentIndex) {
        case 0: {
            CommodityPageVC *commod = [[CommodityPageVC alloc] init];
            [self.navigationController pushViewController:commod animated:YES];
        }
            
            
            break;
            
        case 1: {
            StoreVC *store = [[StoreVC alloc] init];
            [self.navigationController pushViewController:store animated:YES];
        }
            
            break;
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTBV];
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
