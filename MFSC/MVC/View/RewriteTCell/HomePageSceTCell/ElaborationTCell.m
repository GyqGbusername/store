//
//  ElaborationTCell.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ElaborationTCell.h"
#import "MidCollectionCCell.h"
#import "FeedModel.h"

@interface ElaborationTCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) ElaborationView *titleView;
@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIImageView *middleView;
@property (nonatomic, strong) UIView *backView;


@property (nonatomic, strong) UICollectionView *midCollectionView;


@property (nonatomic, strong) NSArray *nameArr;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end


@implementation ElaborationTCell

- (void)dealloc {
    _midCollectionView.dataSource = nil;
    _midCollectionView.delegate = nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#warning ex date
        self.modelArr = [NSMutableArray arrayWithCapacity:0];
        self.nameArr = @[@{@"title":@"预混料", @"img":@"img1"},@{@"title":@"浓缩料", @"img":@"img2"},@{@"title":@"全价料", @"img":@"img3"},@{@"title":@"其它", @"img":@"img4"}];
       
        [self createCollectionView];
        self.titleView = [[ElaborationView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,  35) with:@"细化分类"];
        self.adImageView = [[UIImageView alloc] init];
        [self createTap];
        
        self.middleView = [[UIImageView alloc] init];
        self.backView = [[UIView alloc] init];
        [self.contentView addSubview:self.backView];
        [self.contentView addSubview:self.adImageView];
        [self.backView addSubview:self.middleView];
        [self.contentView addSubview:self.titleView];
        [self handleData];
    }
    return self;
}
- (void)createTap {
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _tap.numberOfTapsRequired = 1;
    _tap.numberOfTouchesRequired = 1;
    [self.adImageView addGestureRecognizer:_tap];
    self.adImageView.userInteractionEnabled = YES;
}
- (void)tap:(UITapGestureRecognizer *)tap {
    
    [self clickWith:@"ad"];

}

- (void)handleData {
    for (NSDictionary *dic in self.nameArr) {
        FeedModel *model = [FeedModel modelWithDictionary:dic];
        [self.modelArr addObject:model];
    }
}


- (void)createCollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 1;
    flow.itemSize = CGSizeMake(kScreen_Width / 2, 77.5);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    self.midCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 35, kScreen_Width, 155) collectionViewLayout:flow];
    self.midCollectionView.delegate = self;
    self.midCollectionView.dataSource = self;
    self.midCollectionView.scrollEnabled = NO;
    self.midCollectionView.backgroundColor = [UIColor whiteColor];
    self.midCollectionView.showsHorizontalScrollIndicator = NO;
    self.midCollectionView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:self.midCollectionView];
    [self.midCollectionView registerClass:[MidCollectionCCell class] forCellWithReuseIdentifier:@"ElaborationTCell_MidCollectionCCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MidCollectionCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ElaborationTCell_MidCollectionCCell" forIndexPath:indexPath];
    cell.feedModel = self.modelArr[indexPath.item];
    return cell;
}


#warning 分类点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
     FeedModel *model = self.modelArr[indexPath.item];
    [self clickWith:model.title];
}

- (void)clickWith:(NSString *)str {
    
    /* 发送通知 */
    /**
     * @param name 通知名
     * @param object 通知发送对象
     * @param userInfo 通知所带的信息(字典)
     */
    if ([str isEqualToString:@"ad"]) {
        [mFNotiCenter postNotificationName:@"adImage" object:@"ad" userInfo:@{@"push":str}];
    } else {
        [mFNotiCenter postNotificationName:@"feedModel" object:@"feed" userInfo:@{@"push":str}];
    }
}



- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView setFrame:CGRectMake(0, viewHeight - 35, kScreen_Width, 35)];
    self.backView.backgroundColor = BACKCOLOR;
    [self.adImageView setFrame:CGRectMake(0, viewHeight - 70, kScreen_Width, 35)];
    [self.adImageView setImage:[UIImage imageNamed:@"ad"]];
    [self.middleView setFrame:CGRectMake(0,7.5, kScreen_Width, 20)];
    self.middleView.backgroundColor = BACKCOLOR;
    [self.middleView setImage:[UIImage imageNamed:@"mid"]];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
