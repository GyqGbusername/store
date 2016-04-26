//
//  CommentsPageVC.m
//  MFSC
//
//  Created by mfwl on 16/3/28.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "CommentsPageVC.h"
#import "CommentsDetailsVC.h"

@interface CommentsPageVC () <UITableViewDataSource, UITableViewDelegate> {
    id __block commentsTCellJump;
}

@property (strong, nonatomic) IBOutlet UILabel *all;

@property (strong, nonatomic) IBOutlet UILabel *allNum;
@property (strong, nonatomic) IBOutlet UILabel *good;

@property (strong, nonatomic) IBOutlet UILabel *goodNum;
@property (strong, nonatomic) IBOutlet UILabel *mid;
@property (strong, nonatomic) IBOutlet UILabel *midNum;
@property (strong, nonatomic) IBOutlet UILabel *low;
@property (strong, nonatomic) IBOutlet UILabel *lowNum;

@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UITableView *commentsListTBV;

@end

@implementation CommentsPageVC

- (void)dealloc {
    _commentsListTBV.delegate = nil;
    _commentsListTBV.dataSource = nil;
    [mFNotiCenter
     removeObserver:commentsTCellJump];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.commentsListTBV.delegate = self;
        self.commentsListTBV.dataSource = self;
        self.commentsListTBV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}



#pragma mark TBV handleData 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseTableViewCell *cell = nil;
    BaseModel *model = [BaseModel modelWithDictionary:@{@"name":@"123123"}];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsTCell"];
    if (!cell) {
        cell = [CellFactory creatCellWithClassName:@"CommentsTCell" cellModel:model indexPath:indexPath];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 172;
}



#pragma mark 返回事件
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark title点击

- (IBAction)titleButton:(UIButton *)sender {
    int i = 0;
    for (UILabel *lb in self.backView.subviews) {
        lb.textColor = [UIColor blackColor];
        i++;
        if (i == 8) {
            break;
        }
    }
    
      switch (sender.tag) {
        case 511: {
            self.all.textColor = THEMECOLOR;
            self.allNum.textColor = THEMECOLOR;
        }
            
            break;
        case 512: {
            self.good.textColor = THEMECOLOR;
            self.goodNum.textColor = THEMECOLOR;
        }
            
            break;
        case 513: {
            self.mid.textColor = THEMECOLOR;
            self.midNum.textColor = THEMECOLOR;
        }
            
            break;
        case 514: {
            self.low.textColor = THEMECOLOR;
            self.lowNum.textColor = THEMECOLOR;
        }

            break;
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    if (_selectIndex != selectIndex) {
        _selectIndex = selectIndex;
    }
    int i = 0;
    for (UILabel *lb in self.backView.subviews) {
        lb.textColor = [UIColor blackColor];
        i++;
        if (i == 8) {
            break;
        }
    }
    switch (selectIndex) {
        case 1: {
            self.good.textColor = THEMECOLOR;
            self.goodNum.textColor = THEMECOLOR;
        }
            
            break;
        case 2: {
            self.mid.textColor = THEMECOLOR;
            self.midNum.textColor = THEMECOLOR;
        }
            
            break;
        case 3: {
            self.low.textColor = THEMECOLOR;
            self.lowNum.textColor = THEMECOLOR;
        }
            break;
        
    }
}

#pragma mark 通知中心

- (void)noti {
    WS(weakSelf);
    commentsTCellJump = [mFNotiCenter addObserverForName:@"CommentsTCelljump" object:@"CommentsTCelljump" queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        CommentsDetailsVC *details = [[CommentsDetailsVC alloc] init];
        details.titleLBText = note.userInfo[@"asd"];
        
        [weakSelf.navigationController pushViewController:details animated:YES];
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self noti];
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
