//
//  OrderStateCell.m
//  MFSC
//
//  Created by mfwl on 16/3/21.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "OrderStateCell.h"

@interface OrderStateCell ()
@property (strong, nonatomic) IBOutlet UIButton *pay;
@property (strong, nonatomic) IBOutlet UIButton *delete;
@property (strong, nonatomic) IBOutlet UIButton *select;
@property (strong, nonatomic) IBOutlet UIView *jumpStore;

@end

@implementation OrderStateCell



- (IBAction)pay:(UIButton *)sender {
    NSLog(@"%ld", (long)self.tempPage);
}

- (void)setTBLayer {
    self.pay.layer.cornerRadius = 3;
    self.pay.layer.masksToBounds = YES;
    self.pay.layer.borderColor = [UIColor redColor].CGColor;
    self.pay.layer.borderWidth = 0.7f;
    self.delete.layer.cornerRadius = 3;
    self.delete.layer.masksToBounds = YES;
    self.delete.layer.borderColor = LayerLineColor;
    self.delete.layer.borderWidth = 0.7f;
    self.select.layer.cornerRadius = 3;
    self.select.layer.masksToBounds = YES;
    self.select.layer.borderColor = LayerLineColor;
    self.select.layer.borderWidth = 0.7f;

}


- (void)awakeFromNib {
    [self setTBLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
