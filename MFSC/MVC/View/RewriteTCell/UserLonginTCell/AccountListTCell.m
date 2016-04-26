//
//  AccountListTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/3.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "AccountListTCell.h"


@interface AccountListTCell ()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MixedLabel *mixLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, assign) NSInteger tempNum;

@end

@implementation AccountListTCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleImage = [[UIImageView alloc] init];
        self.titleLabel = [[UILabel alloc] init];
        self.mixLabel = [[MixedLabel alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.titleImage];
        [self.contentView addSubview:self.mixLabel];
        [self.contentView addSubview:self.contentLabel];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo (self.contentView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];

    self.titleLabel.textAlignment = 0;
    self.titleLabel.font = [UIFont systemFontOfSize: 15];

    
    [self.mixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.right.equalTo (self.contentView.mas_right).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    self.contentLabel.textAlignment = 1;
    self.contentLabel.textColor = [UIColor lightGrayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:13];
}


- (void)setDic:(NSDictionary *)dic {
    if (_dic != dic) {
        _dic = dic;
    }
    NSString *str1 = dic[@"title"];
    self.tempNum = str1.length;
    NSString *str = dic[@"img"];
    if (str.length == 0) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).with.offset(-20);
            make.top.equalTo(self.contentView.mas_top).with.offset(15);
            make.width.equalTo(@150);
            make.height.equalTo(@15);
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView.mas_left).with.offset(20);
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(15 * self.tempNum, 20));
        }];
        self.contentLabel.textAlignment = 2;
        self.contentLabel.text = @"请设置以下项目保护账号";
        
        self.titleLabel.text = str1;
    } else {
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).with.offset(30);
            make.top.equalTo(self.contentView.mas_top).with.offset(15);
            make.width.equalTo(@120);
            make.height.equalTo(@15);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleImage.mas_right).with.offset(20);
            make.top.equalTo(self.contentView.mas_top).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(15 * self.tempNum, 20));
        }];

        self.mixLabel.font = [UIFont systemFontOfSize:13];
        self.mixLabel.textAlignment = 2;
        [self.mixLabel setContentWith:@"修改  [youtiaoh]" withColor:THEMECOLOR];
        self.titleLabel.text = dic[@"title"];
        [self.titleImage setImage:[UIImage imageNamed:str]];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
