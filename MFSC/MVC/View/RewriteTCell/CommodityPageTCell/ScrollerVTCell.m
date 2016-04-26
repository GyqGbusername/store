//
//  ScrollerVTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/16.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ScrollerVTCell.h"

#define tag self.showScr.contentOffset.x / self.showScr.frame.size.width

@interface ScrollerVTCell ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *showScr;
@property (strong, nonatomic) IBOutlet UILabel *bigLB;

@property (strong, nonatomic) IBOutlet UILabel *smLB;

@end

@implementation ScrollerVTCell

- (void)dealloc {
    _showScr.delegate = nil;
}

- (void)setShowScrWith:(NSInteger)num {
    self.showScr.delegate = self;
    
    self.showScr.contentSize = CGSizeMake(kScreen_Width * num, 0);
    self.smLB.text = [NSString stringWithFormat:@"/%ld", (long)num];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.showScr addGestureRecognizer:tap];
    UIImageView *temView = nil;
    for (NSInteger i = 0; i < num
        ; i++) {
        temView = [[UIImageView alloc] init];
        [temView setImage:[UIImage imageNamed:@"placeImage"]];
        temView.backgroundColor = [UIColor cyanColor];
        [self.showScr addSubview:temView];
        [temView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showScr.mas_top);
            make.left.equalTo(self.showScr.mas_left).with.offset(kScreen_Width * i);
            make.height.equalTo([NSNumber numberWithDouble:self.showScr.frame.size.height]);
            make.width.equalTo([NSNumber numberWithDouble:self.showScr.frame.size.width]);
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.bigLB.text = [NSString stringWithFormat:@"%.0f",tag + 1];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    [self.delegate jumpWith:tag];
}
- (void)awakeFromNib {
    // Initialization code
    [self setShowScrWith:5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
