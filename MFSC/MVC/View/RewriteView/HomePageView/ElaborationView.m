//
//  ElaborationView.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ElaborationView.h"

@interface ElaborationView ()
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ElaborationView


- (instancetype)initWithFrame:(CGRect)frame with:(NSString *)str {
    self = [super initWithFrame:frame];
    if (self) {
        self.firstLabel = [[UILabel alloc] init];
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.text = str;
        self.backgroundColor = BACKCOLOR;
        [self addSubview:self.firstLabel];
        [self addSubview:self.contentLabel];
     
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self.firstLabel setFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    self.firstLabel.backgroundColor = THEMECOLOR;
    [self.contentLabel setFrame:CGRectMake(5, 0, 100, viewHeight)];
    self.contentLabel.font = [UIFont systemFontOfSize:17];
    self.contentLabel.textColor = TEXTCOLOR;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
