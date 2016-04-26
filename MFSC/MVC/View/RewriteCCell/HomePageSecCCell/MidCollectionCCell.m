//
//  MidCollectionCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "MidCollectionCCell.h"
#import "FeedModel.h"



@interface MidCollectionCCell ()

@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *goImage;

@end

@implementation MidCollectionCCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor whiteColor];
        self.contentImage = [[UIImageView alloc] init];
        self.nameLabel = [[UILabel alloc] init];
        self.goImage = [[UIImageView alloc] init];
        [self.contentView addSubview:self.contentImage];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.goImage];
    }
    return self;
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    [self.contentImage setFrame:CGRectMake(20, 10, layoutWidth / 3, layoutHeight - 20)];
    [self.nameLabel setFrame:CGRectMake(layoutWidth / 2 + 20, 10, layoutWidth / 3, 25)];
    self.nameLabel.textColor = TEXTCOLOR;
    self.nameLabel.font = [UIFont systemFontOfSize:14];
    [self.goImage setFrame:CGRectMake(layoutWidth / 2 + 20, 45, layoutWidth / 4, 20)];
    [self.goImage setImage:[UIImage imageNamed:@"go"]];
}

- (void)setFeedModel:(FeedModel *)feedModel {
    if (_feedModel != feedModel) {
        _feedModel = feedModel;
    }
    self.nameLabel.text = feedModel.title;
    [self.contentImage setImage:[UIImage imageNamed:feedModel.img]];
}


@end
