//
//  RecommendListVC.m
//  MFSC
//
//  Created by mfwl on 16/4/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "RecommendListVC.h"

@interface RecommendListVC () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *storeListTBV;

@end

@implementation RecommendListVC

- (void)dealloc {
    _storeListTBV.delegate = nil;
    _storeListTBV.dataSource = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _storeListTBV .delegate = self;
        _storeListTBV.dataSource = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = nil;
    BaseModel *model = [BaseModel modelWithDictionary:@{@"name":@"123"}];
    static NSString *cellName = @"StoreListTVBCell";
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StoreVC *store = [[StoreVC alloc] init];
    [self.navigationController pushViewController:store animated:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    if (!self.tabBarController.tabBar.hidden) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

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
