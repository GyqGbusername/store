//
//  ButtonStateCCell.m
//  MFSC
//
//  Created by mfwl on 16/3/15.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ButtonStateCCell.h"

@interface ButtonStateCCell ()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLB;
@end

@implementation ButtonStateCCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleImage = [[UIImageView alloc] init];
        self.titleLB = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleImage];
        [self.contentView addSubview:self.titleLB];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.titleImage.backgroundColor = [UIColor redColor];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(35, 32));
        make.centerX.equalTo (self.contentView).with.offset(10);
    }];
    self.titleLB.backgroundColor = [UIColor yellowColor];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImage.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 15));
        make.centerX.equalTo (self.contentView).with.offset(-10);
    }];
}



- (void)awakeFromNib {
    // Initialization code
}

@end
