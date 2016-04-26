//
//  ImageVC.m
//  MFSC
//
//  Created by mfwl on 16/3/16.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ImageVC.h"

#define taga self.showSrc.contentOffset.x / self.showSrc.frame.size.width

@interface ImageVC () <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *showSrc;

@property (strong, nonatomic) IBOutlet UILabel *bigLB;

@property (strong, nonatomic) IBOutlet UILabel *smLB;


@end

@implementation ImageVC

- (void)dealloc {
    _showSrc.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.showSrc.delegate = self;
       
    }
    return self;
}

- (void)addTap {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.showSrc addGestureRecognizer:tap];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.bigLB.text = [NSString stringWithFormat:@"%.0f",taga + 1];

}

- (void)setTempOffSet:(NSInteger)tempOffSet {
    if (_tempOffSet != tempOffSet) {
        _tempOffSet = tempOffSet;
    }
    [self.showSrc setContentOffset:CGPointMake(self.tempOffSet * kScreen_Width, 0)];
}

- (void)setShowSrcBack:(NSInteger)num {
    [self addTap];
    self.smLB.text = [NSString stringWithFormat:@"/%ld", (long)num];
    self.showSrc.contentSize = CGSizeMake(kScreen_Width * num, 0);
    
    
    UIImageView *temView = nil;
    for (NSInteger i = 0; i < num
         ; i++) {
        temView = [[UIImageView alloc] init];

        [self.showSrc addSubview:temView];
        temView.backgroundColor  =[UIColor cyanColor];
        [temView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showSrc.mas_top);
            make.left.equalTo(self.showSrc.mas_left).with.offset(self.showSrc.frame.size.width * i);
            make.height.equalTo([NSNumber numberWithDouble:self.showSrc.frame.size.height]);
            make.width.equalTo([NSNumber numberWithDouble:self.showSrc.frame.size.width]);
        }];
    }
    
}
- (void)tap:(UITapGestureRecognizer *)tap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setShowSrcBack:5];
    
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
