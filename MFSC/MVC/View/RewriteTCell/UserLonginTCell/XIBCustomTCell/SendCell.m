//
//  SendCell.m
//  MFSC
//
//  Created by mfwl on 16/3/21.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SendCell.h"

@interface SendCell ()

@property (strong, nonatomic) IBOutlet UIButton *tell;

@property (strong, nonatomic) IBOutlet UIView *bace;


@end


@implementation SendCell

- (IBAction)function:(UIButton *)sender {

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
 
    self.tell.layer.cornerRadius = 3;
    self.tell.layer.masksToBounds = YES;
    self.tell.layer.borderColor = LayerLineColor;
    self.tell.layer.borderWidth = 0.7f;
   
}

- (void)awakeFromNib {
    [self addTap];
    [self setBTLayer];
}




@end
