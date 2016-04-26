//
//  ShopCarListTCell.m
//  MFSC
//
//  Created by mfwl on 16/4/12.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ShopCarListTCell.h"
#import "BTStep.h"

@interface ShopCarListTCell ()

@property (nonatomic, strong) BTStep *btStep;

@property (strong, nonatomic) IBOutlet UILabel *money;
@property (strong, nonatomic) IBOutlet UIButton *choose;
@property (nonatomic, assign) BOOL isChoose;
@property (strong, nonatomic) IBOutlet UIView *bv;

@end


@implementation ShopCarListTCell

- (IBAction)Choose:(UIButton *)sender {
    self.isChoose = !self.isChoose;
    if (self.isChoose) {
        [sender setImage:[UIImage imageNamed:@"choose"] forState:(UIControlStateNormal)];
        [sender setTintColor:[UIColor redColor]];
    } else  {
        [sender setImage:[UIImage imageNamed:@"choosed"] forState:(UIControlStateNormal)];
        [sender setTintColor:[UIColor blackColor]];
    }
}


- (void)setBtStepAu {
    self.btStep = [[BTStep alloc] init];
    [self.contentView addSubview:_btStep];
    [_btStep mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView ).offset(-10);
        make.centerY.equalTo(self.money);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 4, 20));
    }];
}

- (void)setBv {
    self.bv.layer.cornerRadius = 2;
    self.bv.layer.masksToBounds = YES;
    self.bv.layer.borderColor = THEMECOLOR.CGColor;
    self.bv.layer.borderWidth = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:(@selector(tap:))];
    self.bv.userInteractionEnabled = YES;
    [self.bv addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
}

- (void)awakeFromNib {
    _isChoose = NO;
    [self setBtStepAu];
    [self setBv];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
