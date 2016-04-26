//
//  ShopCarStoreTCell.m
//  MFSC
//
//  Created by mfwl on 16/4/12.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ShopCarStoreTCell.h"

@interface ShopCarStoreTCell ()

@property (nonatomic, assign) BOOL isChoose;
@property (strong, nonatomic) IBOutlet UIButton *choose;

@end

@implementation ShopCarStoreTCell


- (IBAction)choose:(UIButton *)sender {
    self.isChoose = !self.isChoose;
    if (self.isChoose) {
        [sender setImage:[UIImage imageNamed:@"choose"] forState:(UIControlStateNormal)];
        [sender setTintColor:[UIColor redColor]];
    } else  {
        [sender setImage:[UIImage imageNamed:@"choosed"] forState:(UIControlStateNormal)];
        [sender setTintColor:[UIColor blackColor]];
    }
}

- (void)awakeFromNib {
    _isChoose = NO;
}

@end
