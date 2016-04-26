
//
//  GoodscommentsTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "GoodscommentsTCell.h"

@interface GoodscommentsTCell ()
@property (strong, nonatomic) IBOutlet UIButton *comments;

@end

@implementation GoodscommentsTCell


- (void)awakeFromNib {
    self.comments.layer.cornerRadius = 5;
    self.comments.layer.masksToBounds = YES;
    self.comments.layer.borderColor  = [UIColor colorWithRed:0 green:128 / 255.0 blue:68 / 255.0 alpha:1.0].CGColor;
    self.comments.layer.borderWidth = 0.7;
}

- (IBAction)selectAllcomments:(UIButton *)sender {
    
       [mFNotiCenter postNotificationName:@"selectAllComments" object:@"selectAll" userInfo:@{@"qwe":@"qwe"}];
}

@end
