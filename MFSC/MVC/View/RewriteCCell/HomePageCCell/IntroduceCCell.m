//
//  IntroduceCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/23.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "IntroduceCCell.h"


@interface IntroduceCCell ()


@end

@implementation IntroduceCCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.introImage = [[UIImageView alloc] init];
        self.introLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.introImage];
        [self.contentView addSubview:self.introLabel];
    }
    return self;
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    [self.introImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.equalTo(self.contentView);
    }];

    [self.introLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introImage.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(layoutAttributes.frame.size.width, 20));
    }];
    
    self.introLabel.textAlignment = 1;
    self.introLabel.textColor = TEXTCOLOR;
    self.introLabel.font = [UIFont systemFontOfSize:13];
  
} 



@end
