//
//  GoodsTCell.h
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreModel;

@interface GoodsTCell : UITableViewCell


@property (nonatomic, strong) StoreModel *storeModel;
@property (nonatomic, strong) UICollectionView *goodsCollectionView;


@end
