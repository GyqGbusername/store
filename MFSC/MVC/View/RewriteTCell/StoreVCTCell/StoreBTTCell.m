//
//  StoreBTTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "StoreBTTCell.h"

@interface StoreBTTCell ()


@property (strong, nonatomic) IBOutlet UIButton *collection;

@property (strong, nonatomic) IBOutlet UIButton *toView;


@end


@implementation StoreBTTCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)save:(UIButton *)sender {
    
}


- (void)post {
    
    [mFNotiCenter postNotificationName:@"Seetheevaluation" object:@"Seetheevaluation" userInfo:@{@"as":@"asd"}];
}

- (IBAction)openComments:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"查看评价"]) {
        [self post];
    } else {
        if ([sender.titleLabel.text isEqualToString:@"已收藏"]) {
            sender.titleLabel.text = @"收藏店铺";
            [sender setTitle:@"收藏店铺" forState:(UIControlStateNormal)];
            
#warning 收藏请求
            
        } else {
            sender.titleLabel.text = @"已收藏";
            [sender setTitle:@"已收藏" forState:(UIControlStateNormal)];
            
#warning 取消收藏请求
            
        }
    }
    
}


- (void)addLayerWith:(UIButton *)button {
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = [UIColor whiteColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(4, 4, kScreen_Width * 0.35 - 8, button.frame.size.height - 8)].CGPath;
    
    border.lineWidth = 0.7f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@3, @2];
    [button.layer addSublayer:border];
}

- (void)handleData {
#warning 网络请求店铺收藏状态
    [self.collection setTitle:@"收藏店铺" forState:(UIControlStateNormal)];
    
}

- (void)awakeFromNib {

    
    [self handleData];
    [self addLayerWith:self.collection];
    [self addLayerWith:self.toView];

}

@end
