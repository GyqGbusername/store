//
//  MayAlsoWantTCell.m
//  MFSC
//
//  Created by mfwl on 16/4/13.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "MayAlsoWantTCell.h"
#import "ClassGoodsCCell.h"

@interface MayAlsoWantTCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionListView;

@end

@implementation MayAlsoWantTCell


- (void)creatCollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 0;
    flow.itemSize = CGSizeMake((kScreen_Width - 30) / 2, (kScreen_Width - 30) / 2 + 60);
    flow.minimumLineSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionListView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    [self.contentView addSubview:_collectionListView];
    [_collectionListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.contentView);
    }];
    _collectionListView.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:248 / 255.0 blue:249 / 255.0 alpha:1.0];
    _collectionListView.delegate = self;
    _collectionListView.dataSource = self;
    self.collectionListView.showsHorizontalScrollIndicator = NO;
    self.collectionListView.showsVerticalScrollIndicator = NO;
    self.collectionListView.scrollEnabled = NO;
    [self.collectionListView registerNib:[UINib nibWithNibName:@"ClassGoodsCCell" bundle:nil] forCellWithReuseIdentifier:@"ClassGoodsCCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ClassGoodsCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ClassGoodsCCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate passContent:[NSString stringWithFormat:@"%ld", indexPath.item]];
}



- (void)awakeFromNib {
    [self creatCollectionView];
}



@end
