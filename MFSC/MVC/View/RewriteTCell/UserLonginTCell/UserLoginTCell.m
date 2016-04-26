//
//  UserLoginTCell.m
//  MFSC
//
//  Created by mfwl on 16/2/26.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "UserLoginTCell.h"
#import "UserButtonView.h"

@interface UserLoginTCell ()



@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UserButtonView *buttonView;
@property (nonatomic, strong) UIImageView *signImage;

@end

@implementation UserLoginTCell

- (id)readNSUserDefaultsLogin {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"token"]; /* 读取 */
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userImage = [[UIImageView alloc] init];
        self.userName = [[UILabel alloc] init];
        self.buttonView = [[UserButtonView alloc] init];
        self.signImage = [[UIImageView alloc] init];
        
        [self.contentView addSubview:self.buttonView];
        [self.contentView addSubview:self.signImage];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.userImage];
        [self addTap];

    }
    return self;
}

- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    
    [self.userImage addGestureRecognizer:tap];
}
- (void)tap:(UITapGestureRecognizer *)tap {
   
    [mFNotiCenter postNotificationName:@"imageOpen" object:@"image" userInfo:@{@"picker":@"1"}];

}


- (void)setToken:(NSInteger)token {
    if (_token != token) {
        _token = token;
    }
    switch (token) {
        case 0:
            self.userImage.userInteractionEnabled = NO;
            break;
            
        case 1:
            self.userImage.userInteractionEnabled = YES;
            break;
    }

}

- (void)layoutSubviews {
    
    [super layoutSubviews];

    
       [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@50);
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView.mas_left);
    }];

    [self.signImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(35);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(30);
        make.left.equalTo(_userImage.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    self.userImage.layer.cornerRadius = 30;
    self.userImage.layer.borderWidth = 3;
    
    self.userName.text = @"请点击登录";
    self.userName.textColor = [UIColor whiteColor];
    self.userName.font = [UIFont systemFontOfSize:14];
    [self.signImage setImage:[UIImage imageNamed:@"youtiao"]];
    self.userImage.layer.borderColor = [UIColor greenColor].CGColor;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
