//
//  SignView.m
//  MFSC
//
//  Created by mfwl on 16/2/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SignView.h"

@interface SignView ()


@property (nonatomic, strong) UIImageView *signImage;

@end

@implementation SignView


- (instancetype)initWithFrame:(CGRect)frame with:(UIImage *)image with:(UIColor *)color {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.width / 2;
        self.backgroundColor = color;
        self.signImage = [[UIImageView alloc] initWithImage:image];
        [self addSubview:self.signImage];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.signImage = [[UIImageView alloc] init];
        [self addSubview:self.signImage];
    }
    return self;                      
}

- (void)setImageWith:(UIImage *)image with:(UIColor *)color {
    [self.signImage setImage:image];
    self.backgroundColor = color;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.width / 2;
    [self.signImage setFrame:CGRectMake(self.frame.size.width / 5, self.frame.size.width / 5, self.frame.size.width * 3 / 5, self.frame.size.width * 3 / 5)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
