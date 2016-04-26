//
//  ClassGoodsCCell.m
//  MFSC
//
//  Created by mfwl on 16/4/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ClassGoodsCCell.h"

@interface ClassGoodsCCell ()
@property (strong, nonatomic) IBOutlet UIView *bv;

@end

@implementation ClassGoodsCCell

- (IBAction)addShopCar:(id)sender {
    
    
}



- (void)awakeFromNib {
    self.bv.layer.cornerRadius = 4;
    self.bv.layer.masksToBounds = YES;
    self.bv.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bv.layer.borderWidth = 0.7f;
    
}

@end
