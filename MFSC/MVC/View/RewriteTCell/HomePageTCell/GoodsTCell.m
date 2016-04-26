//
//  GoodsTCell.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "GoodsTCell.h"
#import "GoodsCCell.h"
#import "StoreModel.h"
#import "StoreGoodsModel.h"


@interface GoodsTCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;



@property (nonatomic, strong) NSMutableArray *modelArr;


@end

@implementation GoodsTCell

- (void)dealloc {
    _goodsCollectionView.dataSource = nil;
    _goodsCollectionView.delegate = nil;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.titleImageView = [[UIImageView alloc] init];
        [self creatTap];
        [self.contentView addSubview:self.titleImageView];
        [self createCollectionView];
    }
    return self;
}

- (void)creatTap {
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _tap.numberOfTapsRequired = 1;
    _tap.numberOfTouchesRequired = 1;
   
    [self.titleImageView addGestureRecognizer:_tap];
    self.titleImageView.userInteractionEnabled = YES;
}
- (void)tap:(UITapGestureRecognizer *)tap {
   
    [self clickWith:self.storeModel.type];
}

- (void)clickWith:(NSString *)str {
   
    /* 发送通知 */
    /**
     * @param name 通知名
     * @param object 通知发送对象
     * @param userInfo 通知所带的信息(字典)
     */
    if ([str isEqualToString:self.storeModel.type]) {
        [mFNotiCenter postNotificationName:@"jump" object:@"type" userInfo:@{@"push":str}];
        
    } else {
        [mFNotiCenter postNotificationName:@"storeDoor" object:@"door" userInfo:@{@"push":str}];
    }
}

- (void)createCollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 1;
    flow.itemSize = CGSizeMake(100, 130);
    flow.minimumLineSpacing = 10;
    flow.minimumInteritemSpacing = 0;
    flow.sectionInset = UIEdgeInsetsMake(9.5, 10, 10, 10);
   
    self.goodsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    
    [self.contentView addSubview:self.goodsCollectionView];
    
    self.goodsCollectionView.delegate = self;
    self.goodsCollectionView.dataSource = self;
    self.goodsCollectionView.backgroundColor = [UIColor clearColor];
    self.goodsCollectionView.showsHorizontalScrollIndicator = NO;
    self.goodsCollectionView.showsVerticalScrollIndicator = NO;
    [self.goodsCollectionView registerNib:[UINib nibWithNibName:@"GoodsCCell" bundle:nil] forCellWithReuseIdentifier:@"GoodsTCell_GoodsCCell"];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#warning mark goods滚动个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.modelArr.count == 0) {
        return 4;
    } else
        return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsTCell_GoodsCCell" forIndexPath:indexPath];
    cell.storeGoodsModel = self.modelArr[indexPath.item];
    return cell;
}


#warning store jump door 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    StoreGoodsModel *model = self.modelArr[indexPath.item];
    [self clickWith:model.title];
    
}




- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.contentView);
        make.height.equalTo(@125);
    }];
    [_goodsCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImageView.mas_bottom);
        make.left.right.bottom.equalTo(self.contentView);
    }];
    
   
}

- (void)setStoreModel:(StoreModel *)storeModel {
    if (_storeModel != storeModel) {
        _storeModel = storeModel;
    }
    self.modelArr = [NSMutableArray arrayWithCapacity:0];
    [self.titleImageView setImage:[UIImage imageNamed:storeModel.img]];

    for (NSDictionary *dic in (NSArray *)storeModel.content) {
        StoreGoodsModel *model = [StoreGoodsModel modelWithDictionary:dic];
        [self.modelArr addObject:model];
    }
    [self.goodsCollectionView reloadData];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
