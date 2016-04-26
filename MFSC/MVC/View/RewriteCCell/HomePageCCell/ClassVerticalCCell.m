//
//  ClassCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/23.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ClassVerticalCCell.h"

@interface ClassVerticalCCell ()

@property (nonatomic, strong) MixedLabel *mixLabel;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation ClassVerticalCCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.lineLabel = [[UILabel alloc] init];
        self.mixLabel = [[MixedLabel alloc] initWithFrame:CGRectMake( 15,  10, kScreen_Width * 9 / 20, 30) withStr:@"[zan] 麦丰热荐" withColor:THEMECOLOR];
        self.contentLabel = [[UILabel alloc] init];
        self.titleImage = [[UIImageView alloc] init];
        self.contentImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.lineLabel];
        [self.contentView addSubview:self.contentImage];
        [self.contentView addSubview:self.titleImage];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.mixLabel];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    [self.lineLabel setFrame:CGRectMake(layoutWidth -  5, 15, 0.4, layoutHeight - 30)];
    self.lineLabel.backgroundColor = [UIColor lightGrayColor];
    self.mixLabel.font = [UIFont systemFontOfSize:20];
    [self.contentLabel setFrame:CGRectMake(15, 40, kScreen_Width * 9 / 20 - 25, 20)];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textAlignment = 0;
    self.contentLabel.textColor = QIANCOLOR;
    self.contentLabel.text = @"顶级畜牧大牌 任性购";
    [self.titleImage setFrame:CGRectMake(15, 70, kScreen_Width / 5, 30)];
    [self.titleImage setImage:[UIImage imageNamed:@"RECOMMEND"]];
    [self.contentImage setFrame:CGRectMake(15, 110, kScreen_Width * 9 / 20 - 30, 80)];
    [self.contentImage setImage:[UIImage imageNamed:@"siliao"]];
}




@end
