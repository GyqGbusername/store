//
//  GoodsCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "GoodsCCell.h"
#import "StoreGoodsModel.h"


@interface GoodsCCell ()
@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end


@implementation GoodsCCell


- (void)setStoreGoodsModel:(StoreGoodsModel *)storeGoodsModel {
    if (_storeGoodsModel != storeGoodsModel) {
        _storeGoodsModel = storeGoodsModel;
    }
    [self.goodsImage setImage:[UIImage imageNamed:storeGoodsModel.img]];
    self.nameLabel.text = storeGoodsModel.title;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", storeGoodsModel.price];
}

- (void)awakeFromNib {
    
}

@end
