//
//  StoreGoodsListVC.m
//  MFSC
//
//  Created by mfwl on 16/4/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "StoreGoodsListVC.h"

@interface StoreGoodsListVC () <ClearBVDelegate,TitleListViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *navi;

@property (nonatomic, strong) ClearBV *clearBV;
@property (nonatomic, strong) TitleListView *titleView;

@end

@implementation StoreGoodsListVC

- (void)dealloc {
    _clearBV.delegate = nil;
    _titleView.delegate = nil;
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)listView:(id)sender {
    
    if (!self.clearBV) {
        self.clearBV = [[ClearBV alloc] init];
        [[[UIApplication sharedApplication].delegate window] addSubview:_clearBV];
        [_clearBV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo([[UIApplication sharedApplication].delegate window]);
        }];
        _clearBV.delegate = self;
        self.titleView = [[TitleListView alloc] init];
        self.titleView.dicArr = @[@{@"img":@"lingdang",@"content":@"消息"}, @{@"img":@"home",@"content":@"首页"}];
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
- (void)postNum:(NSInteger)row {
    [_clearBV removeFromSuperview];
    _clearBV = nil;
    switch (row) {
        case 0:
            [self.navigationController pushViewController:[MessageVC shareMessageVC] animated:YES];
            break;
        case 1:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
    }
}

- (void)closeSelf {
    _clearBV = nil;
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
