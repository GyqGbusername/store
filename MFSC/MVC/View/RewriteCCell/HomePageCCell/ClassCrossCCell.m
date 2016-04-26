//
//  ClassCrossCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/23.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ClassCrossCCell.h"



#define XINCOLOR [UIColor colorWithRed:240 / 255.0 green:98 / 255.0 blue:151 / 255.0 alpha:1.0f]
#define ZUANCOLOR [UIColor colorWithRed:238 / 255.0 green:208 / 255.0 blue:38 / 255.0 alpha:1.0f]


@interface ClassCrossCCell ()


@property (nonatomic, strong) MixedLabel *mixLabel;
@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation ClassCrossCCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.mixLabel = [[MixedLabel alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        self.titleImage = [[UIImageView alloc] init];
        self.contentImage = [[UIImageView alloc] init];
        self.lineLabel = [[UILabel alloc] init];
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
    self.mixLabel.font = [UIFont systemFontOfSize:20];
    [self.mixLabel setFrame:CGRectMake( 5, 10, kScreen_Width * 9 / 20, 30)];
    [self.contentLabel setFrame:CGRectMake(5, 40, kScreen_Width * 9 / 20 - 25, 20)];
    [self.lineLabel setFrame:CGRectMake(0, layoutAttributes.frame.size.height - 1, layoutAttributes.frame.size.width, 0.4)];
    self.lineLabel.backgroundColor = [UIColor lightGrayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:14];
    self.contentLabel.textAlignment = 0;
    self.contentLabel.textColor = QIANCOLOR;
    [self.titleImage setFrame:CGRectMake(5,  65, kScreen_Width / 8, 25)];
    [self.contentImage setFrame:CGRectMake(layoutWidth * 2 / 3, 25, layoutWidth / 3 - 15, 60)];
    
}



- (void)setStr:(NSString *)str {
    if (_str != str) {
        _str = str;
    }
    
    if ([str isEqualToString:@"您需要的这里都有"]) {
        [self.mixLabel setContentWith:@"[xin] 猜你喜欢" withColor:XINCOLOR];
        [self.titleImage setImage:[UIImage imageNamed:@"LIKE"]];
        [self.contentImage setImage:[UIImage imageNamed:@"yaoping"]];
        
    } else {
        [self.mixLabel setContentWith:@"[zuan] 特惠爆款" withColor:ZUANCOLOR];
        [self.titleImage setImage:[UIImage imageNamed:@"HOT"]];
        [self.contentImage setImage:[UIImage imageNamed:@"shebei"]];
        self.lineLabel.hidden = YES;
    }
    self.contentLabel.text = str;

}




@end
