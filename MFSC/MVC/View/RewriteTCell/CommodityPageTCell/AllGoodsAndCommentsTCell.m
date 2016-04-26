//
//  AllGoodsAndCommentsTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "AllGoodsAndCommentsTCell.h"

@interface AllGoodsAndCommentsTCell ()

@property (strong, nonatomic) IBOutlet UIButton *enter;
@property (strong, nonatomic) IBOutlet UIButton *select;

@property (strong, nonatomic) IBOutlet UILabel *des;
@property (strong, nonatomic) IBOutlet UIImageView *desImage;

@property (strong, nonatomic) IBOutlet UILabel *server;
@property (strong, nonatomic) IBOutlet UIImageView *serverImage;

@property (strong, nonatomic) IBOutlet UILabel *logistics;
@property (strong, nonatomic) IBOutlet UIImageView *logImage;


@end

@implementation AllGoodsAndCommentsTCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)judgeImageWith:(UILabel *)lb setImageView:(UIImageView *) imageView {
    if ([lb.text floatValue] >= 4.7) {
        imageView.image = [UIImage imageNamed:@"haopingdu"];
        lb.textColor = [UIColor redColor];
    }
    if ([lb.text floatValue] < 4.7 && [lb.text floatValue ] >= 4.3) {
        imageView.image = [UIImage imageNamed:@"zhongpingdu"];
        lb.textColor = [UIColor colorWithRed:57 / 255.0 green:188 / 255.0 blue:155 / 255.0 alpha:1.0f];
    }
    if ([lb.text floatValue] < 4.3) {
        imageView.image = [UIImage imageNamed:@"chapingdu"];
        lb.textColor = [UIColor lightGrayColor];
    }
}

- (void)setBT {
    self.enter.layer.cornerRadius = 5;
    self.enter.layer.masksToBounds = YES;
    self.enter.layer.borderColor  = [UIColor colorWithRed:0 green:128 / 255.0 blue:68 / 255.0 alpha:1.0].CGColor;
    self.enter.layer.borderWidth = 0.7;
    self.select.layer.cornerRadius = 5;
    self.select.layer.masksToBounds = YES;
    self.select.layer.borderColor  = [UIColor colorWithRed:0 green:128 / 255.0 blue:68 / 255.0 alpha:1.0].CGColor;
    self.select.layer.borderWidth = 0.7;
}


- (IBAction)function:(UIButton *)sender {
    
    [mFNotiCenter postNotificationName:@"goodfunction" object:@"good" userInfo:@{@"num":[NSNumber numberWithInteger:sender.tag]}];
}



- (void)setImageAndTextColor {
    [self judgeImageWith:self.des setImageView:self.desImage];
    [self judgeImageWith:self.server setImageView:self.serverImage];
    [self judgeImageWith:self.logistics setImageView:self.logImage];
}



- (void)awakeFromNib {
    [self setBT];
    [self setImageAndTextColor];
}


@end
