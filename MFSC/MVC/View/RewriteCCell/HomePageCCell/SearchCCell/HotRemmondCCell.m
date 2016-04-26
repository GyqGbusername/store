//
//  HotRemmondCCell.m
//  MFSC
//
//  Created by mfwl on 16/4/7.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "HotRemmondCCell.h"

@interface HotRemmondCCell ()
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation HotRemmondCCell


- (void)addLayerWith:(UIView *)button {
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = [UIColor lightGrayColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(4, 4, button.frame.size.width - 8, button.frame.size.height - 8)].CGPath;
    
    border.lineWidth = 0.7f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@3, @2];
    [button.layer addSublayer:border];
}



- (void)awakeFromNib {
    [self addLayerWith:self];
//    self.layer.cornerRadius = 5;
//    self.layer.masksToBounds = YES;
//    self.layer.borderColor = [UIColor colorWithRed:200 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0].CGColor;
//    self.layer.borderWidth = 0.8;
    // Initialization code
}

@end
