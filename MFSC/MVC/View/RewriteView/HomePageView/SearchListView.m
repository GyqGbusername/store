//
//  SearchListView.m
//  MFSC
//
//  Created by mfwl on 16/3/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SearchListView.h"

@interface SearchListView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *searchRTBV;

@end

@implementation SearchListView


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self createTBV];
    }
    return self;
}

- (UITableView *)createTBV {
    if (!_searchRTBV) {
        _searchRTBV = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        [self addSubview:_searchRTBV];
        _searchRTBV.delegate = self;
        _searchRTBV.dataSource = self;
        _searchRTBV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_searchRTBV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@300);
        }];
    }
    return _searchRTBV;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"searchListView_showTBV";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName];
    }
    cell.textLabel.text = @"12313";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate search:@"12313"];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
