//
//  CommentsDetailsVC.m
//  MFSC
//
//  Created by mfwl on 16/3/30.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "CommentsDetailsVC.h"

@interface CommentsDetailsVC () <UITableViewDataSource, UITableViewDelegate ,UITextFieldDelegate> {
    
    NSString *tempStr;
}

@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UIView *titleBV;

@property (strong, nonatomic) IBOutlet UILabel *titleLB;

@property (strong, nonatomic) IBOutlet UITableView *commentsListTBV;
@property (strong, nonatomic) IBOutlet UITextField *inputTF;
@property (strong, nonatomic) IBOutlet UIButton *send;

@property (strong, nonatomic) IBOutlet UIView *bv;




@end

@implementation CommentsDetailsVC



- (void)dealloc {
    _commentsListTBV.delegate = nil;
    _commentsListTBV.dataSource = nil;
    _inputTF.delegate = nil;
    [mFNotiCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [mFNotiCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [_inputTF removeTarget:self action:@selector(textChange:) forControlEvents:(UIControlEventEditingChanged)];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _commentsListTBV.delegate = self;
        _commentsListTBV.dataSource = self;
        _send.enabled = NO;
        _send.backgroundColor = [UIColor grayColor];
        _inputTF.delegate = self;
        [_inputTF addTarget:self action:@selector(textChange:) forControlEvents:(UIControlEventEditingChanged)];
        [self setTailControls];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

#pragma mark 暂存输入的text

- (void)textChange:(UITextField *)tf {
    tempStr = tf.text;
    if (tf.text.length > 0) {
        _send.enabled = YES;
        _send.backgroundColor = THEMECOLOR;
    } else {
        _send.enabled = NO;
        _send.backgroundColor = [UIColor grayColor];
    }
}
- (IBAction)send:(UIButton *)sender {
#warning mark 发送输入的文字到服务器
    
    [self tableView:_commentsListTBV scrollTableToFoot:YES];
}




- (void)tableView:(UITableView *)tableView scrollTableToFoot:(BOOL)animated
{
    NSInteger s = [tableView numberOfSections];  //有多少组
    if (s<1) return;  //无数据时不执行 要不会crash
    NSInteger r = [tableView numberOfRowsInSection:s-1]; //最后一组有多少行
    if (r<1) return;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];  //取最后一行数据
    [tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:animated]; //滚动到最后一行
}


- (void)setTailControls{
    self.inputTF.layer.cornerRadius = 5;
    self.inputTF.layer.masksToBounds = YES;
    self.send.layer.cornerRadius = 5;
    self.send.layer.masksToBounds = YES;
}


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark TBV data
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = nil;
    BaseModel *model = [BaseModel modelWithDictionary:@{@"name":@"123123"}];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsDetailsTCell"];
    if (!cell) {
        cell = [CellFactory creatCellWithClassName:@"CommentsDetailsTCell" cellModel:model indexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 4:
            return 10;
            break;
            
        default:
            return CGFLOAT_MIN;
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
#pragma mark 设置标题
- (void)setTitleLBText:(NSString *)titleLBText {
    if (_titleLBText != titleLBText) {
        _titleLBText = titleLBText;
    }
    self.titleLB.text = _titleLBText;
}

#pragma mark 添加约束
- (void)addMasnory {
    [_titleBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleBV).with.offset(8);
        make.top.equalTo(self.titleBV).with.offset(30);
        make.height.width.equalTo(@25);
    }];
    [_titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.titleBV);
        make.top.equalTo(self.titleBV).with.offset(26);
        make.height.equalTo(@28);
        make.width.equalTo(@109);
    }];
    [_commentsListTBV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.titleBV.mas_bottom);
        make.bottom.equalTo(self.bv.mas_top);
        make.right.left.equalTo(self.view);
    }];
    
   [self.bv setFrame:CGRectMake(0, kScreen_Height - 49, kScreen_Width, 49)];
    [_inputTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bv).with.offset(10);
        make.bottom.equalTo(self.bv).with.offset(-10);
        make.left.equalTo(self.bv).with.offset(20);
        make.right.equalTo(self.send.mas_left).with.offset(-20);
    }];
    [_send mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bv).with.offset(10);
        make.bottom.equalTo(self.bv).with.offset(-10);
        make.right.equalTo(self.bv).with.offset(- 20);
        make.width.equalTo(@55);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField  {
    [textField resignFirstResponder];
    return YES;
}


- (void)noti {
    [mFNotiCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [mFNotiCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark 计算控件在屏幕中的位置
- (CGFloat)screenViewYValue:(UIView *)textfield {
    CGFloat y = 0;
    for (UIView *view = textfield; view; view = view.superview) {
        y += view.frame.origin.y;
        if ([view isKindOfClass:[UIScrollView class]]) {
            // 如果父视图是UIScrollView则要去掉内容滚动的距离
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

#pragma mark 弹出键盘时 跟随移动
- (void)keyboardWillShow:(NSNotification *)noti {
   
    // 弹出键盘的高度
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value =[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyboardEndY = value.CGRectValue.origin.y;
    // 弹出动画
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.bv setFrame:CGRectMake(0, keyboardEndY - 49, kScreen_Width, 49)];
    } completion:^(BOOL finished) {
       
    }];
}


- (void)keyboardWillHide:(NSNotification *)noti {
  
   
    [UIView animateWithDuration:0.25 animations:^{
             [self.bv setFrame:CGRectMake(0, kScreen_Height - 49, kScreen_Width, 49)];
    } completion:^(BOOL finished) {
       
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self noti];
    [self addMasnory];
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
