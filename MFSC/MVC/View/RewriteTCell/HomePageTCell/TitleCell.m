//
//  TitleCell.m
//  MFSC
//
//  Created by mfwl on 16/2/19.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "TitleCell.h"
#import "ShufflingFigureView.h"


@interface TitleCell ()



@end

@implementation TitleCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.shuView = [[ShufflingFigureView alloc] initWithPageNum:7];
        [self.contentView addSubview:self.shuView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.shuView.backgroundColor =[UIColor cyanColor];
    [self.shuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
