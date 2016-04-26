//
//  ShufflingFigureView.m
//  MFSC
//
//  Created by mfwl on 16/2/17.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ShufflingFigureView.h"
#import "HomePageModel.h"
#import "GuidePageView.h"


@interface ShufflingFigureView () <UIScrollViewDelegate> {
    id __block mainVC;
}

@property (nonatomic, strong) GuidePageView *pageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, assign) NSInteger tempNum;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, assign) NSInteger pageNum;



@end


@implementation ShufflingFigureView

- (void)dealloc {
    _scrollView.delegate = nil;
    [mFNotiCenter removeObserver:mainVC];
}

- (void)noti {
   mainVC = [mFNotiCenter addObserverForName:@"mainVC" object:@"sufferView" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        BOOL is = [[note .userInfo objectForKey:@"code"] boolValue];
        if (is == YES) {
            [self addTimer];
        } else {
            [self deleteTimer];
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
    }];
}

- (instancetype)initWithPageNum:(NSInteger)num {
    self = [super init];
    if (self) {
        [self noti];
        self.scrollView = [[UIScrollView alloc] init];
        self.tempNum = 0;
    
        for (NSInteger i = 0; i < num; i++) {
            self.img = [[UIImageView alloc] init];
            [self.scrollView addSubview:self.img];
            self.tempNum++;
        }
        
        [self addSubview:self.scrollView];
        [self addTimer];
        
        self.pageView = [[GuidePageView alloc] initWith:7];
        [self addSubview:self.pageView];
        [self.pageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kScreen_Width / 2  , 10));
            make.bottom.equalTo(self).offset(-10);
            make.centerX.equalTo(self);
        }];
      
        
    }
    return self;
}



- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.scrollView addGestureRecognizer:tap];
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    [mFNotiCenter postNotificationName:@"ShufflingFigureView" object:@"ShufflingFigure" userInfo:@{@"page":[NSNumber numberWithInteger:self.pageNum]}];
}

- (void)setScrView {
    [self addTap];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.tempNum, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    for (NSInteger i = 0; i < self.tempNum; i++) {
        self.img = [self.scrollView.subviews objectAtIndex:i];
        self.img.backgroundColor = [UIColor redColor];
        [self.img mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scrollView.mas_top);
            make.left.equalTo(self.scrollView.mas_left).with.offset(self.frame.size.width * i);
            make.height.equalTo([NSNumber numberWithDouble:self.frame.size.height]);
            make.width.equalTo([NSNumber numberWithDouble:self.frame.size.width]);
        }];
        _img.image = [UIImage imageNamed:@"placeImage"];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self setScrView];
}
#pragma mark date;
- (void)setArr:(NSMutableArray *)arr {
    if (_arr != arr) {
        _arr = arr;
    }
    for (NSInteger i = 0; i < self.tempNum; i++) {
        HomePageModel *model = arr[i];
        UIImageView *img = [self.scrollView.subviews objectAtIndex:i];
        NSString *str = [NSString stringWithFormat:@"http://www.51maifeng.com/%@", model.logo];
        [img setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"mai"]];
    }
}


/* 添加定时器方法 */
- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/* 删除定时器方法 */
- (void)deleteTimer {
    [self.timer invalidate];
    self.timer = nil;
}
/* 实现NStimer方法 */
- (void)nextPage {
    static int page = 0;
    if (self.scrollView.contentOffset.x / kScreen_Width == self.tempNum - 1) {
        page = 0;
    } else {
        page = self.scrollView.contentOffset.x / kScreen_Width + 1;
    }
    /* 计算滚动的位置 */
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    if (offsetX == 0) {
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
    } else {
        CGPoint offset = CGPointMake(offsetX, 0);
        [self.scrollView setContentOffset:offset animated:YES];
    }
}
#pragma  - mark UIScrollViewDelegate
/* 监听滚动的位置,q*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageNum = scrollView.contentOffset.x / kScreen_Width;
    for (UILabel *label in self.pageView.subviews) {
        label.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
    }

    NSLog(@"%ld", _pageNum);
    self.tempLabel = [self.pageView.subviews objectAtIndex:self.pageNum];
    self.tempLabel.backgroundColor = [UIColor whiteColor];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self deleteTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
