//
//  GuideViewController.m
//  ceshi
//
//  Created by mfwl on 16/1/26.
//  Copyright © 2016年 mfwl. All rights reserved.
//


#import "GuideViewController.h"
#import "HomePageViewController.h"
#import "GuidePageView.h"



@interface GuideViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *srcView;
@property (nonatomic, strong) NSArray *guideImageArr;
@property (nonatomic, strong) GuidePageView *pageView;
@property (nonatomic, strong) UILabel *tempLabel;
@property (nonatomic, assign) NSInteger tempNum;

@end

@implementation GuideViewController


- (void)dealloc {
    [_srcView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![DEVICEMODEL isEqualToString:@"iPad"]) {
            self.guideImageArr = @[@"1",@"2",@"3"];
        } else {
            self.guideImageArr = @[@"pad1", @"pad2", @"pad3"];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createGuide];
    [self setGuidePage];
}



/* 创建引导页 */
- (void)createGuide {
    self.srcView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.srcView.contentSize = CGSizeMake(kScreen_Width * 3, kScreen_Height);
    self.srcView.pagingEnabled = YES;
    self.srcView.delegate = self;
    self.srcView.bouncesZoom = NO;
    self.srcView.showsHorizontalScrollIndicator = NO;
    self.srcView.showsVerticalScrollIndicator = NO;
    self.srcView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 3; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScreen_Width, 0, kScreen_Width, kScreen_Height)];
        img.image = [UIImage imageNamed:self.guideImageArr[i]];
        [self.srcView addSubview:img];

    }
    [self setJumpButton];
    [self.srcView addObserver:self forKeyPath:@"contentOffset" options:1 | 2 context:nil];
    [self.view addSubview:self.srcView];
    [self saveNSUserDefaultsWith:@"NO"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    CGPoint point = [[change objectForKey:@"new"] CGPointValue];
    for (UILabel *label in self.pageView.subviews) {
        label.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
    }
    if (point.x < kScreen_Width * 0.5) {
        self.tempLabel = [self.pageView.subviews objectAtIndex:0];
        self.tempLabel.backgroundColor = [UIColor whiteColor];
    }
    if (point.x >= kScreen_Width * 0.5 && point.x < kScreen_Width * 1.5) {
        self.tempLabel = [self.pageView.subviews objectAtIndex:1];
        self.tempLabel.backgroundColor = [UIColor whiteColor];
    }
    if (point.x >= kScreen_Width * 1.5 && point.x < kScreen_Width * 2.5) {
        self.tempLabel = [self.pageView.subviews objectAtIndex:2];
        self.tempLabel.backgroundColor = [UIColor whiteColor];
    }
}
/* 跳转按钮 */
- (void)setJumpButton {
    UIButton *endButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageView *img= [self.srcView.subviews objectAtIndex:2];
    //UIImageView *img = [self.srcView.subviews objectAtIndex:2];
    [self.srcView addSubview:endButton];
    [endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img);
        make.bottom.equalTo(img.mas_bottom).offset(-70);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 3, 50));
    }];
    endButton.backgroundColor = [UIColor clearColor];
    endButton.layer.borderColor = [UIColor whiteColor].CGColor;
    endButton.layer.borderWidth = 2;
    endButton.layer.cornerRadius = 8;
    endButton.layer.masksToBounds = YES;
    [endButton setTitle:@"立即体验" forState:(UIControlStateNormal)];
    [endButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    endButton.titleLabel.font = [UIFont systemFontOfSize:28];
    [endButton addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setGuidePage {
    self.pageView = [[GuidePageView alloc] initWith:self.guideImageArr.count];
    
    [self.view addSubview:self.pageView];
    [_pageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreen_Width / 3, 20));
        make.centerX.equalTo(_srcView);
        make.bottom.equalTo(_srcView).offset(- 30);
    }];
    
}

- (void)buttonSize:(UIButton *)button {

}

- (BOOL)shouldAutorotate {
    return  NO;
}

- (void)buttonClick:(UIButton *)button {
    
    [UIView animateWithDuration:1 animations:^{
        self.pageView.alpha = 0;
        self.srcView.alpha = 0; /** 让scrollview 渐变消失 */
    } completion:^(BOOL finished) {
        [self.srcView  removeFromSuperview]; /** 将scrollView移除 */
        [self.pageView removeFromSuperview];
        [self.delegate jump];
    } ];
}

/* 保存数据到NSUserDefaults */
- (void)saveNSUserDefaultsWith:(NSString *)str {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:@"guideStr"];
    /* 这里建议同步存储到磁盘中，不写也可以建议写 */
    [userDefaults synchronize];
}

- (id)readNSUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"guideStr"]; /* 读取 */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
         
}



@end
