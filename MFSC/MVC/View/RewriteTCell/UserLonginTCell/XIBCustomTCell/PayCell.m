//
//  PayCell.m
//  MFSC
//
//  Created by mfwl on 16/3/21.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "PayCell.h"

@interface PayCell ()


@property (strong, nonatomic) IBOutlet UIView *bace;
@property (strong, nonatomic) IBOutlet UIButton *pay;
@property (strong, nonatomic) IBOutlet UIButton *cancel;

@end


@implementation PayCell

- (IBAction)function:(UIButton *)sender {
    switch (sender.tag) {
        case 355:
            
            break;
            
        case 356:
            
            break;
      
            
    }
}


- (void)click
{
    NSLog(@"%s", __func__);
}

- (void)addTap {
    self.bace.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self.bace addGestureRecognizer:tap];

}

- (void)setBTLayer {
    self.pay.layer.cornerRadius = 3;
    self.pay.layer.masksToBounds = YES;
    self.pay.layer.borderColor = [UIColor redColor].CGColor;
    self.pay.layer.borderWidth = 0.7f;
    self.cancel.layer.cornerRadius = 3;
    self.cancel.layer.masksToBounds = YES;
    self.cancel.layer.borderColor = LayerLineColor;
    self.cancel.layer.borderWidth = 0.7f;
}

- (void)awakeFromNib {
    [self addTap];
    [self setBTLayer];
}


@end
