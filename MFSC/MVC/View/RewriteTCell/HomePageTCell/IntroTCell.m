//
//  IntroTCell.m
//  MFSC
//
//  Created by mfwl on 16/2/23.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "IntroTCell.h"
#import "ClassVerticalCCell.h"
#import "ClassCrossCCell.h"

@interface IntroTCell () <RFQuiltLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *classCollectionView;
@property (nonatomic, strong) NSArray *contentArr;

@end

@implementation IntroTCell

- (void)dealloc {
    _classCollectionView.delegate = nil;
    _classCollectionView.dataSource = nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentArr = @[@"您需要的这里都有", @"优惠活动早知道"];
        [self createClassCollectionView];
    }
    return self;
}

- (void)createClassCollectionView {
    RFQuiltLayout *layout = [[RFQuiltLayout alloc] init];
    //滑动方向
    layout.direction = 0;
    //属性
    layout.blockPixels = CGSizeMake(kScreen_Width / 20,  100);
    layout.delegate = self;
    self.classCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,  200) collectionViewLayout:layout];
    self.classCollectionView.delegate = self;
    self.classCollectionView.dataSource = self;
    self.classCollectionView.backgroundColor = BACKCOLOR;
    [self.classCollectionView registerClass:[ClassVerticalCCell class] forCellWithReuseIdentifier:@"IntroTCell_ClassVerticalCCell"];
    [self.classCollectionView registerClass:[ClassCrossCCell class] forCellWithReuseIdentifier:@"IntroTCell_ClassCrossCCell"];
    [self.contentView addSubview:self.classCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        ClassVerticalCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IntroTCell_ClassVerticalCCell" forIndexPath:indexPath];
        
        return cell;
    } else {
        ClassCrossCCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"IntroTCell_ClassCrossCCell" forIndexPath:indexPath];
        cell.str = self.contentArr[indexPath.item - 1];
        return cell;
    }
}
- (CGSize)blockSizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //判断下标 由下标改变item的尺寸大侠
    if (indexPath.item % 10 == 0)
        return CGSizeMake(9, 2);
    return CGSizeMake(11, 1);
}



#warning activity events

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self clickWith:[NSString stringWithFormat:@"%d",indexPath.item]];
}

- (void)clickWith:(NSString *)str {
    
    /* 发送通知 */
    /**
     * @param name 通知名
     * @param object 通知发送对象
     * @param userInfo 通知所带的信息(字典)
     */
    [mFNotiCenter postNotificationName:@"recommend" object:@"activity" userInfo:@{@"push":str}];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
