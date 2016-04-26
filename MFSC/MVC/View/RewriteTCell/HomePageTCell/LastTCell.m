//
//  LastTCell.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "LastTCell.h"
#import "LastCCell.h"
#import "LastGoodsModel.h"

@interface LastTCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *showCollectionView;

@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, assign) NSInteger numberofLine;

@end

@implementation LastTCell

- (void)dealloc {
    _showCollectionView.delegate = nil;
    _showCollectionView.dataSource = nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self createCollectionView];
    }
    return self;
}


- (void)setContentArr:(NSArray *)contentArr {
    if (_contentArr != contentArr) {
        _contentArr = contentArr;
    }
    [self handleData];
}




- (void)handleData {
    self.modelArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *dic in self.contentArr) {
        LastGoodsModel *model = [LastGoodsModel modelWithDictionary:dic];
        [self.modelArr addObject:model];
    }
    
    if (self.modelArr.count % 2 == 0) {
        self.numberofLine = self.modelArr.count / 2;
    } else {
        self.numberofLine = self.modelArr.count / 2 + 1;
    }
    [self.showCollectionView reloadData];
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 0;
    flow.itemSize = CGSizeMake((kScreen_Width - 30) / 2, (kScreen_Width - 30) / 2 + 60);
    flow.minimumLineSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.showCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, ((kScreen_Width - 30) / 2 + 60) * self.numberofLine) collectionViewLayout:flow];
    [self.contentView addSubview:self.showCollectionView];
    [_showCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.contentView);
    }];
    self.showCollectionView.delegate = self;
    self.showCollectionView.dataSource = self;
    self.showCollectionView.backgroundColor = [UIColor clearColor];
    self.showCollectionView.scrollEnabled = NO;
    self.showCollectionView.showsHorizontalScrollIndicator = NO;
    self.showCollectionView.showsVerticalScrollIndicator = NO;
    [self.showCollectionView registerNib:[UINib nibWithNibName:@"LastCCell" bundle:nil] forCellWithReuseIdentifier:@"LastCCell"];
   
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#warning mark goods滚动个数


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArr.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LastCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LastCCell" forIndexPath:indexPath];
    cell.lastModel = self.modelArr[indexPath.item];
    return cell;
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    LastGoodsModel *model = self.modelArr[indexPath.item];
    [self clickWith:model.title];
}

- (void)clickWith:(NSString *)str {
   
    /* 发送通知 */
    /**
     * @param name 通知名
     * @param object 通知发送对象
     * @param userInfo 通知所带的信息(字典)
     */
    if ([_surperTableViewName isEqualToString:@"Main"]) {
        [mFNotiCenter postNotificationName:@"MainlastGoods" object:@"Mainlast" userInfo:@{@"push":str}];
    } else {
        [mFNotiCenter postNotificationName:@"lastGoods" object:@"last" userInfo:@{@"push":str}];
    }
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
