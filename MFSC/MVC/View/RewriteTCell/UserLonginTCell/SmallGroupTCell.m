//
//  SmallGroupTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/3.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SmallGroupTCell.h"



@interface SmallGroupTCell ()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) MixedLabel *mixLabel;
@property (nonatomic, strong) SignView *backView;

@end

@implementation SmallGroupTCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backView = [[SignView alloc] init];
        self.titleImage = [[UIImageView alloc] init];
        self.titleName = [[UILabel alloc] init];
        self.mixLabel = [[MixedLabel alloc] init];
        [self.contentView addSubview:self.backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(5);
            make.left.equalTo (self.contentView.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        [self.backView addSubview:self.titleImage];
        [self.contentView addSubview:self.titleName];
        [self.contentView addSubview:self.mixLabel];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo (self.backView.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    self.titleName.font = [UIFont systemFontOfSize:14];
    self.titleName.textColor = [UIColor blackColor];
    
    self.mixLabel.textAlignment = 2;
    [self.mixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo (self.contentView.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];

}

- (void)setServiceDic:(NSDictionary *)serviceDic {
    if (_serviceDic != serviceDic) {
        _serviceDic = serviceDic;
    }
    [self.backView setImageWith:[UIImage imageNamed:serviceDic[@"image"]] with:serviceDic[@"color"]];
    self.mixLabel.font = [UIFont systemFontOfSize:13];
    [self.mixLabel setContentWith:serviceDic[@"mixTitle"] withColor:[UIColor lightGrayColor]];
    self.titleName.text = serviceDic[@"title"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
