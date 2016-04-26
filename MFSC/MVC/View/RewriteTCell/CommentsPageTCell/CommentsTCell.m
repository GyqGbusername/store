//
//  CommentsTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/30.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "CommentsTCell.h"
#import "StartView.h"


@interface CommentsTCell ()

@property (strong, nonatomic) IBOutlet UILabel *commentsTime;

@property (strong, nonatomic) IBOutlet UILabel *buyTime;

@property (strong, nonatomic) IBOutlet UIButton *toViewBT;
@property (strong, nonatomic) IBOutlet UITextView *showComments;

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (nonatomic, strong) StartView *stars;

@end


@implementation CommentsTCell


- (void)setStars {
    self.stars = [[StartView alloc] initWithFrame:CGRectMake(13, 43, 153, 35)];
    [self.stars startWithIntegerCount:7];
    
    [self.contentView addSubview:self.stars];
}



- (void)setToViewBT {
    self.toViewBT.layer.cornerRadius = 4;
    self.toViewBT.layer.borderColor = THEMECOLOR.CGColor;
    self.toViewBT.layer.borderWidth = 1;
}



- (IBAction)reply:(UIButton *)sender {
    
    [mFNotiCenter postNotificationName:@"CommentsTCelljump" object:@"CommentsTCelljump" userInfo:@{@"asd":self.userName.text}];
}

- (void)awakeFromNib {
    [self setToViewBT];
    [self setStars];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
