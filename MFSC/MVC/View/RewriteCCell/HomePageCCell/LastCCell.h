//
//  LastCCell.h
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LastGoodsModel;

@interface LastCCell : UICollectionViewCell


@property (nonatomic, strong) LastGoodsModel *lastModel;
@property (nonatomic, copy) NSString *strNum;

@end
