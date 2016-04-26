//
//  OrderCCell.m
//  MFSC
//
//  Created by mfwl on 16/3/18.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "OrderCCell.h"
#import "OrderStateCell.h"
#import "BaseModel.h"
#import "BaseTableViewCell.h"




@interface OrderCCell () <UITableViewDataSource, UITableViewDelegate> {
    id __block pageNum;
}

@property (strong, nonatomic) UITableView *orderListTBV;
@property (nonatomic, strong) NSArray *cellArr;

@end

@implementation OrderCCell

- (void)dealloc {
    _orderListTBV.dataSource = nil;
    _orderListTBV.delegate = nil;
    [mFNotiCenter removeObserver:pageNum];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cellArr = @[@"OrderStateCell", @"PayCell", @"SendCell", @"ReceiveCell"];
        [self tableViewWith:frame];
        [self noti];
    }
    return self;
}

- (UITableView *)tableViewWith:(CGRect)frame {
    if (!_orderListTBV) {
        self.orderListTBV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:(UITableViewStyleGrouped)];
        self.orderListTBV.delegate = self;
        self.orderListTBV.dataSource = self;
        [self.contentView addSubview:self.orderListTBV];
        [self.orderListTBV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return _orderListTBV;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 195;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (void)noti {
    [mFNotiCenter addObserverForName:@"pageNum" object:@"page" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.tempPage = [[note .userInfo objectForKey:@"page"] integerValue];
        [self.orderListTBV reloadData];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseTableViewCell *cell = nil;
    BaseModel *model = nil;
    NSString *cellName = self.cellArr[self.tempPage];
    cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [CellFactory creatCellWithClassName:cellName cellModel:model
indexPath:indexPath];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
