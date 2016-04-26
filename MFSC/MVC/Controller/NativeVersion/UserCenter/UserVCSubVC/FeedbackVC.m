//
//  FeedbackVC.m
//  MFSC
//
//  Created by mfwl on 16/3/22.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "FeedbackVC.h"
#import "PlaceHolderTextView.h"

@interface FeedbackVC ()

@property (strong, nonatomic) PlaceHolderTextView *feedBackTextView;


/* titleV */
@property (nonatomic, strong) UIView *titleBV;
@property (nonatomic, strong) UILabel *nameLB;
@property (nonatomic, strong) UIButton *messageBT;
@property (nonatomic, strong) UIButton *back;

@end

@implementation FeedbackVC

- (void)setTextView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.feedBackTextView = [[PlaceHolderTextView alloc] initWithFrame:CGRectMake(10, 74, 355, 150)];
    [self.view addSubview:self.feedBackTextView];
    [self.feedBackTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).with.offset(74);
        make.width.equalTo(@355);
        make.height.equalTo(@150);
    }];
    self.feedBackTextView.placeholder = @"亲, 您遇到什么系统问题啦, 或者有什么功能建议吗? 欢迎提给我们, 谢谢!";
    self.feedBackTextView.layer.borderWidth = 1.0;
    //设置边框颜色
    self.feedBackTextView.layer.borderColor = [UIColor grayColor].CGColor;
    //设置圆角
    self.feedBackTextView.layer.cornerRadius = 5.0;
    self.feedBackTextView.font = [UIFont systemFontOfSize:17];
}


- (void)setTitle {
    _titleBV = [[UIView alloc] init];
    [self.view addSubview:_titleBV];
    _back = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_titleBV addSubview:_back];
   
    [_back setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [_back setTintColor:[UIColor whiteColor]];
    [_back addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
    _nameLB = [[UILabel alloc] init];
    [_titleBV addSubview:_nameLB];
    
    _nameLB.text = @"服务/反馈";
    _nameLB.textAlignment = 0;
    _nameLB.textColor = [UIColor whiteColor];
    _nameLB.font = [UIFont systemFontOfSize:17];
    
    _messageBT = [UIButton buttonWithType:UIButtonTypeSystem];
    [_messageBT setTintColor:[UIColor whiteColor]];
    [_messageBT setImage:[UIImage imageNamed:@"feiji"] forState:(UIControlStateNormal)];
    [_messageBT addTarget:self action:@selector(messageBTClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.titleBV addSubview:_messageBT];
    _titleBV.backgroundColor = THEMECOLOR;
}
- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)messageBTClick:(UIButton *)button {
#pragma mark send 反馈
    
}
#pragma mark 添加约束
- (void)addMasnory {
    [_titleBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBV).offset(8);
        make.top.equalTo(self.titleBV).offset(30);
        make.width.height.equalTo(@25);
    }];
    [_nameLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.back.mas_right).offset(10);
        make.top.equalTo(self.titleBV).offset(32);
        make.width.equalTo(@100);
        make.height.equalTo(@21);
    }];
    [_messageBT mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleBV).offset(-15);
        make.width.height.equalTo(@25);
        make.top.equalTo(self.titleBV).offset(30);
    }];
    
}


- (void)righttBarButtonClick:(UIBarButtonItem *)buttonItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sendBarButtonClick:(UIBarButtonItem*)buttonItem {
#pragma mark 发送意见
    
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTextView];
    [self setTitle];
    [self addMasnory];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.feedBackTextView resignFirstResponder];
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
