//
//  SuitspecificationsView.m
//  MFSC
//
//  Created by mfwl on 16/3/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SuitspecificationsView.h"
#import "BTStep.h"


@interface SuitspecificationsView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *storeImage;
@property (nonatomic, strong) UIButton *delete;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *serialNumLB;

@property (nonatomic, strong) UILabel *downLineLB;
@property (nonatomic, strong) UILabel *lineLB;
@property (nonatomic, strong) UILabel *midLineLB;

@property (nonatomic, strong) UIButton *buyBT;



@property (nonatomic, strong) UILabel *buyNumLb;
@property (nonatomic, strong) BTStep *step;
@property (nonatomic, strong) UILabel *inventoryLb;



@end

@implementation SuitspecificationsView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height, kScreen_Width, 0)];
        self.storeImage = [[UIImageView alloc] init];
        self.delete = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.titleLB = [[UILabel alloc] init];
        self.serialNumLB = [[UILabel alloc] init];
        self.lineLB = [[UILabel alloc] init];
        self.buyBT = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.downLineLB = [[UILabel alloc] init];
        self.step = [[BTStep alloc] init];
        self.buyNumLb = [[UILabel alloc] init];
        self.midLineLB = [[UILabel alloc] init];
        self.inventoryLb = [[UILabel alloc] init];
        [self.contentView addSubview:self.inventoryLb];
        [self.contentView addSubview:self.midLineLB];
        [self.contentView addSubview:self.buyNumLb];
        [self.contentView addSubview:self.downLineLB];
        [self.contentView addSubview:self.buyBT];
        [self.contentView addSubview:self.delete];
        [self.contentView addSubview:self.titleLB];
        [self.contentView addSubview:self.serialNumLB];
        [self.contentView addSubview:self.lineLB];
        [self.contentView addSubview:self.storeImage];
        [self.contentView addSubview:self.step];
        [self addSubview:self.contentView];
        [self addContentView];
        [self addStoreImage];
        [self addDelete];
        [self addTitleLB];
        [self addSerialNumLB];
        [self addLineLB];
        [self addBuyBT];
        [self addStepNum];
    }
    return self;
}



- (void)addDelete {
    [self.delete setImage:[UIImage imageNamed:@"cha"] forState:(UIControlStateNormal)];
    [self.delete addTarget:self action:@selector(delete:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.delete setTintColor:[UIColor lightGrayColor]];
    [self.delete mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(20);
        make.right.equalTo(self.contentView).with.offset( -20);
        make.width.height.equalTo(@20);
    }];
}
- (void)delete:(UIButton *)button {
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView setFrame:CGRectMake(0, kScreen_Height, kScreen_Width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addStoreImage {
    self.storeImage.backgroundColor = [UIColor redColor];
    self.storeImage.layer.cornerRadius = 10;
    self.storeImage.layer.masksToBounds = YES;
    self.storeImage.layer.borderWidth = 0.7;
    self.storeImage.layer.borderColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0].CGColor;
    [self.storeImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(-20);
        make.left.equalTo(self.contentView).with.offset(20);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width / 4]);
        make.height.equalTo([NSNumber numberWithFloat:kScreen_Width / 4]);
    }];
}

- (void)addContentView {
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView setFrame:CGRectMake(0, kScreen_Height / 3, kScreen_Width, kScreen_Height * 2 / 3)];
    } completion:^(BOOL finished) {
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(self);
            make.height.equalTo([NSNumber numberWithFloat:kScreen_Height * 2 / 3]);
        }];
    }];
}

- (void)addTitleLB {
    self.titleLB.text = @"阿萨斯的";
    self.titleLB.textAlignment = 0;
    self.titleLB.font = [UIFont systemFontOfSize:15];
    [self.titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.storeImage.mas_right).with.offset(20);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width / 2]);
        make.height.equalTo (@20);
    }];
}
- (void)addSerialNumLB {
    self.serialNumLB.text = @"asdasd89757";
    self.serialNumLB.textAlignment = 0;
    self.serialNumLB.textColor = [UIColor lightGrayColor];
    self.serialNumLB.font = [UIFont systemFontOfSize:14];
    [self.serialNumLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLB.mas_bottom).with.offset(5);
        make.left.equalTo(self.storeImage.mas_right).with.offset(20);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width / 2]);
        make.height.equalTo (@20);
    }];
}



- (void)addLineLB {
    
    self.lineLB.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0f];
    [self.lineLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width]);
        make.height.equalTo(@1);
        make.top.equalTo(self.storeImage.mas_bottom).with.offset(20);
    }];
    self.midLineLB.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0f];
    [self.midLineLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width]);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.buyNumLb.mas_top).offset(- 10);
    }];
    self.downLineLB.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0f];
    [self.downLineLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width]);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.buyBT.mas_top).offset(- 10);
    }];
}

- (void)addBuyBT {
    [self.buyBT setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    [self.buyBT setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.buyBT.backgroundColor = THEMECOLOR;
    self.buyBT.layer.cornerRadius = 5;
    self.buyBT.layer.masksToBounds = YES;
    self.buyBT.titleLabel.font = [UIFont systemFontOfSize:19.0];
    [self.buyBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.offset(-10);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo([NSNumber numberWithFloat:kScreen_Width * 0.85]);
        make.height.equalTo(@40);
    }];
}

- (void)addStepNum {
    self.buyNumLb.text = @"购买数量:";
    self.buyNumLb.font = [UIFont systemFontOfSize:15];
    [self.buyNumLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.downLineLB.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 4, 25));
    }];
    [self.step mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.downLineLB.mas_top).offset(-12.5);
        make.left.equalTo(self.buyNumLb.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 4, 20));
    }];
    self.inventoryLb.text = [NSString stringWithFormat:@"(库存:%@)", @"123123"];
    self.inventoryLb.textAlignment = 1;
    self.inventoryLb.textColor = [UIColor lightGrayColor];
    self.inventoryLb.font = [UIFont systemFontOfSize:13];
    [self.inventoryLb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.downLineLB.mas_top).offset(-10);
        make.left.equalTo(self.step.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 3, 25));
    }];
}


@end
