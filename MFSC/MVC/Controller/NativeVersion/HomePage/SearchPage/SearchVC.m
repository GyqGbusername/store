//
//  SearchVC.m
//  MFSC
//
//  Created by mfwl on 16/3/9.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SearchVC.h"
#import "SearchModel.h"
#import "SearchResultVC.h"
#import "HotRecommendedTCell.h"
#import "SearchListView.h"

@interface SearchVC () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, SearchListViewDelegate> {
    NSString *tempStr;
}



@property (nonatomic, strong) FMDatabase *db_obj;
@property (strong, nonatomic) IBOutlet UISearchBar *search;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UITableView *resultTV;

#pragma mark dateArr
@property (nonatomic, strong) NSMutableArray *searchResultArr;
@property (nonatomic, strong) SearchModel *searchModel;

#pragma mark showlist 
@property (nonatomic, strong) SearchListView *searchListView;


@end

@implementation SearchVC

- (void)dealloc {
    _resultTV.delegate = nil;
    _resultTV.dataSource = nil;
    _search.delegate = nil;
    _searchListView.delegate = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.resultTV.delegate = self;
        self.resultTV.dataSource = self;
        self.search.delegate  = self;
        /* 删除分割线 */
//        self.resultTV.separatorStyle = UITableViewCellSelectionStyleNone;
        self.resultTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (IBAction)searchButton:(UIButton *)sender {
    if (tempStr.length == 0) {
        return;
    }
    [self insertObjWith:tempStr];
    SearchResultVC *searchResultVC = [[SearchResultVC alloc] init];
    searchResultVC.tempStr = tempStr;
    [self.navigationController pushViewController:searchResultVC animated:true];
    [self dbClose];
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    tempStr = searchText;
    switch (searchText.length) {
        case 0:
            [_searchListView removeFromSuperview];
            _searchListView = nil;
            break;
        default:
            [self searchListView:_searchListView];
            [self setSearchListView];
            break;
    }
}
- (void)setSearchListView {
    [_searchListView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark searchListView 懒加载
- (SearchListView *)searchListView:(SearchListView *)searchListView {
    if (!_searchListView) {
        self.searchListView = [[SearchListView alloc] init];
        [self.view addSubview:_searchListView];
        _searchListView.delegate = self;
    }
    return _searchListView;
}

- (void)search:(NSString *)name {
    [self insertObjWith:name];
    SearchResultVC *searchResultVC = [[SearchResultVC alloc] init];
    searchResultVC.tempStr = name;
    [self.navigationController pushViewController:searchResultVC animated:true];
    [self dbClose];

}


- (IBAction)cleanDB:(UIButton *)sender {
    
    FMResultSet *rs = [_db_obj executeQuery:@"SELECT * FROM searchHistroytab"];
    /* 查询 */
    while ([rs next]) {
        NSString *iD = [rs stringForColumn:@"ID"];
        /* 删除 */
        BOOL isSuccess = [_db_obj executeUpdate:@"delete from searchHistroytab where ID = ?",iD];
        if (isSuccess) {
            NSLog(@"删除成功!!");
        }else{
            NSLog(@"删除失败!!");
        }
    }
    self.searchResultArr = [NSMutableArray arrayWithCapacity:0];
    [self.resultTV reloadData];
}

//- (void)setFMDB {
//    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
//    if (![db open]) {
//        NSLog(@"Could not open db.");
//        [db close];
//    }
//    NSString *sqlStr =@"CREATE TABLE table1 (id integer, name text, image blob)";
//    BOOL res = [db executeUpdate:sqlStr];
//    if (!res) {
//        NSLog(@"error when creating db tabletable1");
//        [db close];
//    }
//    int idvalue;
//    NSString *name;
//    NSData *data;
//    
//    sqlStr = @"insert into table1 values (?,?,?)";
//    res = [db executeUpdate:sqlStr,idvalue,name,data];
//    if (!res) {
//        NSLog(@"error when insert intotable1");
//        [db close];
//    }
//    FMResultSet *s = [db executeQuery:@"SELECT * FROM table1"];
//    while ([s next]) {
//        int idvalue = [s intForColumn:@"id"];
//        NSString *name = [s stringForColumn:@"name"];
//        NSData *data = [s dataForColumn:@"image"];
//    }
//    
//}


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self dbClose];
   
}
/* 背景去图层 */
- (void)setSearchController {
    for (UIView *view in self.search.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    self.search.backgroundColor = THEMECOLOR;
}

- (void)viewWillAppear:(BOOL)animated {
    self.db_obj = [FMDatabase databaseWithPath:dbPath];
    [self setDb];
    [self queryInfo];
    self.tabBarController.tabBar.hidden = YES;
    [_searchListView removeFromSuperview];
    _searchListView = nil;
    tempStr = @"";
    self.search.text = @"";
    [self.search becomeFirstResponder];
}

- (void)setDb {
    if ([_db_obj open]) {
        NSLog(@"打开数据库成功");
    } else {
        NSLog(@"Could not open db.");
        [_db_obj close];
    }
    
    if ([self readNSUserDefaults] == nil) {
        NSString *sqlStr = @"CREATE TABLE searchHistroytab (id integer PRIMARY KEY, content text, time text)";
        BOOL res = [_db_obj executeUpdate:sqlStr];
        if (!res) {
            NSLog(@"error when creating searchHistroytab");
            [_db_obj close];
        } else {
            [self saveNSUserDefaultsWith:@"NO"];
        }
    }
}

- (void)dbClose {
    if ([_db_obj close]) {
        NSLog(@"关闭成功");
    } else  {
        NSLog(@"关闭失败");
    }

}

/* 保存数据到NSUserDefaults */
- (void)saveNSUserDefaultsWith:(NSString *)str {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:str forKey:@"historyTab"];
    /* 这里建议同步存储到磁盘中，不写也可以建议写 */
    [userDefaults synchronize];
}

- (id)readNSUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"historyTab"]; /* 读取 */
}



- (void)queryInfo {
    self.searchResultArr = [NSMutableArray arrayWithCapacity:0];
    FMResultSet *rs = [_db_obj executeQuery:@"SELECT * FROM searchHistroytab"];
    /* 查询 */
    while ([rs next]) {
        NSInteger iD = [rs intForColumn:@"id"];
        NSString *content = [rs stringForColumn:@"content"];
        NSString *time = [rs stringForColumn:@"time"];
        self.searchModel = [[SearchModel alloc] init];
        self.searchModel.iD = iD;
        self.searchModel.content = content;
        self.searchModel.time = time;
        [self.searchResultArr addObject:self.searchModel];
    }
    [self.resultTV reloadData];
}

- (void)insertObjWith:(NSString *)str {
    [_db_obj executeUpdate:@"INSERT INTO searchHistroytab (content, time) VALUES (?,?)",
    str, [self getNowTime]];
    
}


/* 获取本地时间 */
- (NSString *)getNowTime {
    NSDate *senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSearchController];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (self.searchResultArr.count) {
        case 0:
            return 1;
            break;
            
        default:
            return 2;
            break;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.searchResultArr.count) {
        case 0:
            return 2;
            break;
            
        default: {
            switch (section) {
                case 0:
                    return self.searchResultArr.count + 2;
                    break;
                    
                default:
                    return 2;
                    break;
            }
        }
            break;
    
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.searchResultArr.count) {
        case 0: {
            switch (indexPath.row) {
                case 0:{
                    static NSString *cellName = @"searchHot";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.textLabel.text = @"热门推荐";
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.textLabel.font = [UIFont systemFontOfSize:13];
                    return cell;
                }
                    break;
                    
                default: {
                    static NSString *hotrCell = @"hotrCell";
                    HotRecommendedTCell *cell = [tableView dequeueReusableCellWithIdentifier:hotrCell];
                    if (!cell) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotRecommendedTCell" owner:nil options:nil] firstObject];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    return cell;
                }
                    break;
            }
            
        }
            break;
            
        default: {
            
            switch (indexPath.section) {
                case 0: {
                    if (indexPath.row == 0) {
                        static NSString *cellName = @"searchName";
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName];
                        }  else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
                        {
                            while ([cell.contentView.subviews lastObject] != nil) {
                                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                            }
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        cell.textLabel.text = @"历史搜索";
                        cell.textLabel.textColor = [UIColor lightGrayColor];
                        cell.textLabel.font = [UIFont systemFontOfSize:13];
                        return cell;
                        
                    } else if (indexPath.row == self.searchResultArr.count + 1) {
                        
                        static NSString *cellIdentify = @"cellclean";
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
                        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CleanCell" owner:self options:nil];
                        if ([nib count] > 0) {
                            self.cleanCell = [nib objectAtIndex:0];
                            cell = self.cleanCell;
                        }
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
                        
                    } else {
                        static NSString *cellName = @"searchName11";
                        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                        if (!cell) {
                            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName];
                        }  else//当页面拉动的时候 当cell存在并且最后一个存在 把它进行删除就出来一个独特的cell我们在进行数据配置即可避免
                        {
                            while ([cell.contentView.subviews lastObject] != nil) {
                                [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
                            }
                        }
                        SearchModel *model = self.searchResultArr[indexPath.row - 1];
                        cell.textLabel.text = model.content;
                        return cell;
                    }
                    
                }
                    
                    break;
                    
                default: {
                    switch (indexPath.row) {
                        case 0:{
                            static NSString *cellName = @"searchHot";
                            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                            if (!cell) {
                                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellName];
                            }
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            cell.textLabel.text = @"热门推荐";
                            cell.textLabel.textColor = [UIColor lightGrayColor];
                            cell.textLabel.font = [UIFont systemFontOfSize:13];
                            return cell;
                            
                        }
                            break;
                            
                        default: {
                            static NSString *hotrCell = @"hotrCell";
                            HotRecommendedTCell *cell = [tableView dequeueReusableCellWithIdentifier:hotrCell];
                            if (!cell) {
                                cell = [[[NSBundle mainBundle] loadNibNamed:@"HotRecommendedTCell" owner:nil options:nil] firstObject];
                            }
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            return cell;
                        }
                            break;
                    }
                }
                    break;
            }
            
        }
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
            return 10;
            break;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.searchResultArr.count) {
        case 0: {
            switch (indexPath.row) {
                case 0:
                    return 20;
                    break;
                    
                default:
                    return 60;
                    break;
            }

        }
            break;
        default: {
            switch (indexPath.section) {
                case 0: {
                    switch (indexPath.row) {
                        case 0:
                            return 20;
                            break;
                            
                        default:
                            return 44;
                            break;
                    }
                }
                    
                    break;
                    
                default: {
                    switch (indexPath.row) {
                        case 0:
                            return 20;
                            break;
                            
                        default:
                            return 60;
                            break;
                    }
                }
                    break;
            }
            
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (self.searchResultArr.count) {
        case 0: {
            switch (indexPath.row) {
                case 0:
                   
                    break;
                    
                default:
                   
                    break;
            }
            
        }
            break;
        default: {
            switch (indexPath.section) {
                case 0: {
                    switch (indexPath.row) {
                        case 0:
                            
                            break;
                            
                        default:{
                            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                            SearchResultVC *searchResultVC = [[SearchResultVC alloc] init];
                            searchResultVC.tempStr = cell.textLabel.text;
                            [self.navigationController pushViewController:searchResultVC animated:true];
                            [self dbClose];
                        }
                            break;
                    }
                }
                    
                    break;
                    
                default: {
                    switch (indexPath.row) {
                        case 0:
                            
                            break;
                            
                        default:
                           
                            break;
                    }
                }
                    break;
            }
            
        }
            break;
    }
    
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
