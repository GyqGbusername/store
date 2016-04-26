//
//  ButtonTableView.m
//  MFSC
//
//  Created by mfwl on 16/4/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ButtonTableView.h"

@interface ButtonTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *listTBV;

@end

@implementation ButtonTableView

- (void)dealloc {
    _listTBV.delegate = nil;
    _listTBV.dataSource = nil;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
        [self createListTBV];
    }
    return self;
}

- (void)createListTBV {
    self.listTBV = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    [self addSubview:_listTBV];
    _listTBV.backgroundColor = [UIColor clearColor];
    _listTBV.delegate = self;
    _listTBV.dataSource = self;
    _listTBV.showsHorizontalScrollIndicator = NO;
    _listTBV.showsVerticalScrollIndicator = NO;
    _listTBV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"ButtonListTVBCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName];
    }  else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
    {
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"嘻嘻嘻嘻";
    cell.textLabel.textAlignment = 1;
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.delegate pass:cell.textLabel.text];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [_listTBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
