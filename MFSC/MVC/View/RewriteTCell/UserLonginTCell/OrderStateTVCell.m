//
//  OrderStateTVCell.m
//  MFSC
//
//  Created by mfwl on 16/3/17.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "OrderStateTVCell.h"

@implementation OrderStateTVCell


- (IBAction)jump:(UIButton *)sender {
    [self.delegate jumpWith:sender.tag];
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
