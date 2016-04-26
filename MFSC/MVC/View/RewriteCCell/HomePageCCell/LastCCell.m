//
//  LastCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "LastCCell.h"
#import "LastGoodsModel.h"

@interface LastCCell ()

@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLb;
@property (strong, nonatomic) IBOutlet UILabel *nowPay;
@property (strong, nonatomic) IBOutlet UILabel *infoLb;


@end


@implementation LastCCell


- (void)setLastModel:(LastGoodsModel *)lastModel {
    if (_lastModel != lastModel) {
        _lastModel = lastModel;
    }
    [self.goodsImage setImage:[UIImage imageNamed:lastModel.img]];
    
    self.nowPay.text = lastModel.price;
    self.nameLb.text = lastModel.name;
    self.infoLb.text = [NSString stringWithFormat:@"%@ %@", lastModel.com, lastModel.title];
}



@end
