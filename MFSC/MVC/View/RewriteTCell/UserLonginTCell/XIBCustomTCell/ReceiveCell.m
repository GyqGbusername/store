
//
//  ReceiveCell.m
//  MFSC
//
//  Created by mfwl on 16/3/21.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ReceiveCell.h"


@interface ReceiveCell ()

@property (strong, nonatomic) IBOutlet UIButton *sure;
@property (strong, nonatomic) IBOutlet UIView *bace;
@property (strong, nonatomic) IBOutlet UIButton *select;


@end


@implementation ReceiveCell



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)click
{
    NSLog(@"%s", __func__);
}


- (IBAction)function:(UIButton *)sender {
    switch (sender.tag) {
        case 358:
            
            break;
            
        case 359:
            
            break;
    }
}


- (void)addTap {
    self.bace.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self.bace addGestureRecognizer:tap];
    
}

- (void)setBTLayer {
    self.sure.layer.cornerRadius = 3;
    self.sure.layer.masksToBounds = YES;
    self.select.layer.cornerRadius = 3;
    self.select.layer.masksToBounds = YES;
    self.select.layer.borderColor = LayerLineColor;
    self.select.layer.borderWidth = 0.7f;
}


- (void)awakeFromNib {
    [self setBTLayer];
    [self addTap];
}



@end
