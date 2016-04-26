//
//  HeadportraitView.m
//  MFSC
//
//  Created by mfwl on 16/3/22.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "HeadportraitView.h"

@interface HeadportraitView ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *lineLB;
@property (nonatomic, strong) UIButton *camera;
@property (nonatomic, strong) UIButton *picfromphone;
@property (nonatomic, strong) UIButton *delete;

@end

@implementation HeadportraitView

- (void)dealloc {
    [self.delete removeTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f];
        self.backView = [[UIView alloc] init];
        self.titleLB = [[UILabel alloc] init];
        self.lineLB = [[UILabel alloc] init];
        self.camera = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.picfromphone = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.delete = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.delete.tag = 1111;
        self.camera.tag = 1112;
        self.picfromphone.tag = 1113;
        
        [self.backView addSubview:self.titleLB];
        [self.backView addSubview:self.lineLB];
        [self.backView addSubview:self.camera];
        [self.backView addSubview:self.picfromphone];
        [self.backView addSubview:self.delete];
        [self addSubview:self.backView];
    }
    return self;
}


- (void)setBackV {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@240);
        make.height.equalTo(@120);
    }];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    self.backView.userInteractionEnabled = YES;
    [self.backView addGestureRecognizer:tap];
}
- (void)tap {
    
}
- (void)setDelete {
    [self.delete setImage:[UIImage imageNamed:@"cha"] forState:(UIControlStateNormal)];
    [self.delete setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
    [self.delete addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.delete mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).with.offset(10);
        make.right.equalTo (self.backView.mas_right).with.offset(-10);
        make.width.equalTo(@15);
        make.height.equalTo(@15);
    }];
}

- (void)delete:(UIButton *)delete {
    switch (delete.tag) {
        case 1111:
            [self removeFromSuperview];
            break;
            
        default:
            [self.delegate passTag:delete.tag];
            break;
    }
}

- (void)setLineLB {
    self.lineLB.backgroundColor = THEMECOLOR;
    [self.lineLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).with.offset(42);
        make.width.equalTo(self.backView);
        make.height.equalTo(@3);
        make.centerX.equalTo(self.backView);
    }];
}

- (void)setTitleLB {
    self.titleLB.text = @"修改头像";
    self.titleLB.textAlignment = 1;
    
    [self.titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView.mas_top).with.offset(6);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
}

- (void)setCamera {
    [self.camera setTitle:@"拍照" forState:(UIControlStateNormal)];
    [self.camera addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];

    [self.camera mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).with.offset(15);
        make.top.equalTo(self.lineLB.mas_bottom).with.offset(8);
    }];
}
- (void)setPic{
    [self.picfromphone setTitle:@"从相册获取照片" forState:(UIControlStateNormal)];
    [self.picfromphone addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.picfromphone mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).with.offset(15);
        make.top.equalTo(self.camera.mas_bottom);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setBackV];
    [self setLineLB];
    [self setTitleLB];
    [self setCamera];
    [self setPic];
    [self setDelete];
}




- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}


@end
