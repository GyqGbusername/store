//
//  HotRecommendedTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/16.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "HotRecommendedTCell.h"

@interface HotRecommendedTCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *hotCommendListCV;


@end

@implementation HotRecommendedTCell


- (void)setSelfAu {
    _hotCommendListCV.delegate = self;
    _hotCommendListCV.dataSource = self;
    [_hotCommendListCV registerNib:[UINib nibWithNibName:@"HotRemmondCCell" bundle:nil]  forCellWithReuseIdentifier:@"HotRemmondCCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotRemmondCCell" forIndexPath:indexPath];
    return cell;
}


- (void)awakeFromNib {
    // Initialization code
    [self setSelfAu];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
