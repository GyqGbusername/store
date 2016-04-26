//
//  TitleListView.m
//  MFSC
//
//  Created by mfwl on 16/4/6.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "TitleListView.h"

@interface TitleListView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *titleListTBV;

@property (nonatomic, strong) NSMutableArray *modelArr;

@end

@implementation TitleListView

- (void)dealloc {
    _titleListTBV.delegate = nil;
    _titleListTBV.dataSource = nil;
}



- (void)setDicArr:(NSArray *)dicArr {
    if (_dicArr != dicArr) {
        _dicArr = dicArr;
    }
    self.modelArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in self.dicArr) {
        BaseModel *model = [BaseModel modelWithDictionary:dic];
        [self.modelArr addObject:model];
    }
    [self.titleListTBV reloadData];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [self createTBV];
    }
    return self;
}
- (void)createTBV {
    if (!self.titleListTBV) {
        self.titleListTBV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:(UITableViewStylePlain)];
        _titleListTBV.delegate = self;
        _titleListTBV.dataSource = self;
        _titleListTBV.showsHorizontalScrollIndicator = NO;
        _titleListTBV.showsVerticalScrollIndicator = NO;
        _titleListTBV.bounces = NO;
        _titleListTBV.scrollEnabled = NO;
        _titleListTBV.backgroundColor = [UIColor clearColor];
        _titleListTBV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_titleListTBV];
        [_titleListTBV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dicArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellStr = @"TitleListTCell";
    BaseModel *model  = self.modelArr[indexPath.row];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [CellFactory creatCellWithClassName:cellStr cellModel:model indexPath:indexPath];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate postNum:indexPath.row];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.frame.size.height / self.dicArr.count;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
