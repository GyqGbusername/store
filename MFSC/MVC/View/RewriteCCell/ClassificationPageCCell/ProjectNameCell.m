//
//  ProjectNameCell.m
//  MFSC
//
//  Created by mfwl on 16/3/9.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ProjectNameCell.h"

@interface ProjectNameCell ()

@property (nonatomic, strong) UILabel *nameLabel;


@end

@implementation ProjectNameCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLabel = [[UILabel alloc] init];
        
        [self.contentView addSubview:self.nameLabel];
   
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
  
    [self.nameLabel setFrame:applyFrame];
    self.nameLabel.text = @"产品名称";
    [self.nameLabel setFont:[UIFont systemFontOfSize:14]];
    self.nameLabel.textAlignment = 1;
    self.nameLabel.textColor = [UIColor lightGrayColor];
    self.nameLabel.layer.cornerRadius = 5;
    self.nameLabel.layer.borderWidth = 1;
    self.nameLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}



- (void)awakeFromNib {
    // Initialization code
}

@end
