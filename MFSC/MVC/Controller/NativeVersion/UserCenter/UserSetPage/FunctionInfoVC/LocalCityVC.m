//
//  LocalCityVC.m
//  MFSC
//
//  Created by mfwl on 16/3/7.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "LocalCityVC.h"

@interface LocalCityVC () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchCityTF;
@property (strong, nonatomic) IBOutlet UITableView *showCityList;


@property (nonatomic, copy) NSString *localCity;
@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSMutableArray *keys;
@property (nonatomic, strong) NSMutableArray *arrayCitys;
@property (nonatomic, strong) NSMutableArray *arrayHotCity;
@property (nonatomic, strong) NSMutableArray *positCityArr;
@property (nonatomic, strong) NSMutableArray *allCities;



@property (nonatomic, strong) NSMutableDictionary *resultDic;
@property (nonatomic, strong) NSMutableDictionary *newsDic;

@property (nonatomic, assign) NSInteger tempNum;
@property (nonatomic, strong) NSMutableArray *resultArr;
@property (nonatomic, strong) NSArray *tempArr;




@end

@implementation LocalCityVC

- (void)dealloc {
    _searchCityTF.delegate = nil;
    _showCityList.delegate = nil;
    _showCityList.dataSource = nil;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tempNum = 0;
        self.showCityList.delegate = self;
        self.showCityList.dataSource = self;
        self.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州", @"成都", @"上海", @"北京", @"深圳", nil];
    
        self.positCityArr = [NSMutableArray arrayWithObjects:@"51麦丰", nil];
        self.keys = [NSMutableArray arrayWithCapacity:0];
        self.arrayCitys = [NSMutableArray arrayWithCapacity:0];
        self.showCityList.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.allCities = [NSMutableArray arrayWithCapacity:0];
        self.searchCityTF.delegate = self;
        [self cityInfoHandle];
        self.showCityList.sectionIndexBackgroundColor = [UIColor clearColor];
        self.showCityList.sectionIndexColor = THEMECOLOR;
    }
    return self;
}


- (void)localCityHandle {
    [HTTPTOOL GETLocalCityWithURL:@"http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js" withBody:nil withHttpHead:nil responseStyle:JSON withSuccess:^(id result) {
        
        NSString *temResult = [[NSString alloc] initWithData:result  encoding:NSUTF8StringEncoding];
        if (temResult.length == 0) {
            return ;
        }
        temResult = [temResult substringFromIndex:21];
        temResult = [temResult substringToIndex:temResult.length - 1];
        NSData *xmlData = [temResult dataUsingEncoding:NSUTF8StringEncoding];
        id results = [NSJSONSerialization JSONObjectWithData:xmlData options:NSJSONReadingMutableContainers error:nil];
        self.localCity = results[@"city"];
        [self.showCityList reloadData];
    } withFail:^(id result) {
        
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.tempNum = searchText.length;
    NSString *search = @"🔍";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [cd] %@",searchText];
    self.resultArr = [NSMutableArray arrayWithCapacity:0];
    self.keys = [NSMutableArray arrayWithCapacity:0];
    switch (searchText.length) {
        case 0: {
            [self cityInfoHandle];
        }
            break;
            
        case 1: {
            _resultArr = [self.cities objectForKey:[searchText uppercaseString]];
            if (_resultArr.count == 0) {
                _resultArr = (NSMutableArray *)[self.allCities filteredArrayUsingPredicate:predicate];
                if (_resultArr.count == 0) {
                    _resultArr = [NSMutableArray arrayWithObject:@"暂无相关搜索"];
                }
            }
            self.keys = [NSMutableArray arrayWithCapacity:0];
            [self.keys insertObject:search atIndex:0];
            self.newsDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [self.newsDic setObject:_resultArr forKey:search];
        }
            break;
            
        default: {
            _resultArr = (NSMutableArray *)[self.allCities filteredArrayUsingPredicate:predicate];
            self.tempArr = [self.cities objectForKey:[[searchText substringWithRange:NSMakeRange(0, 1)] uppercaseString]];
            
            if (_resultArr.count == 0) {
                NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:0];
                for (NSString *str in self.tempArr) {
                    NSString *strHan = str;
                    NSMutableString *strPinyin = [NSMutableString string];
                    for (NSInteger i = 0; i < strHan.length; i++) {
                        NSString *str1  = [strHan substringWithRange:NSMakeRange(i, 1)] ;
                        str1 = [str1 firstCharacterOfName];
                        [strPinyin appendString:str1];
                    }
                    if ([predicate evaluateWithObject:strPinyin]) {
                        [newArr addObject:str];
                    }
                }
                _resultArr = newArr;
                
            }
            
            if (_resultArr.count == 0) {
                NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:0];
                for (NSString *str in self.tempArr) {
                    NSString *strHan = str;
                    NSMutableString *strPinyin = [NSMutableString string];
                    for (NSInteger i = 0; i < strHan.length; i++) {
                        NSString *str1  = [strHan substringWithRange:NSMakeRange(i, 1)] ;
                        str1 = [str1 pinyinOfName];
                        [strPinyin appendString:str1];
                    }
                    if ([predicate evaluateWithObject:strPinyin]) {
                        [newArr addObject:str];
                    }
                }
                _resultArr = newArr;
            }
            self.keys = [NSMutableArray arrayWithCapacity:0];
            [self.keys insertObject:search atIndex:0];
            self.newsDic = [NSMutableDictionary dictionaryWithCapacity:0];
            [self.newsDic setObject:_resultArr forKey:search];

        }
            break;
    }
    [self.showCityList reloadData];
    
}



#pragma mark - get data
- (void)cityInfoHandle {
    self.cities = @{
                    @"A" : @[@"安庆", @"安顺", @"安阳", @"阿拉善盟", @"鞍山", @"阿坝", @"阿里", @"阿克苏", @"阿勒泰", @"安康"],
                    @"B" : @[@"北京", @"蚌埠", @"毫州", @"白银", @"北海", @"百色", @"毕节", @"保定", @"包头", @"巴彦淖尔盟", @"白山", @"本溪", @"滨州", @"巴中", @"博尔塔拉", @"巴音郭楞", @"保山", @"宝鸡"],
                    @"C" : @[@"成都",@"常州", @"重庆", @"滁州", @"巢湖", @"池州", @"潮州", @"崇左", @"承德", @"沧州", @"常德", @"郴州", @"赤峰", @"朝阳", @"昌都", @"昌吉", @"楚雄", @"大理"],
                    @"D" : @[@"定西", @"东莞", @"大庆", @"大兴安岭", @"大连", @"丹东", @"大同", @"东营", @"德州", @"德阳", @"达州", @"德宏", @"迪庆"],
                    @"E" : @[@"鄂州", @"恩施土家族苗族自治州", @"鄂尔多斯"],
                    @"F" : @[@"福州", @"佛山", @"阜阳", @"防城港", @"抚州", @"抚顺", @"阜新"],
                    @"G" : @[@"广州", @"贵阳", @"桂林", @"甘南", @"贵港", @"赣州", @"固原", @"果洛", @"广元", @"广安", @"甘孜"],
                    @"H" : @[@"杭州", @"合肥", @"海口", @"淮南", @"淮北", @"黄山", @"惠州", @"河源", @"贺州", @"河池", @"邯郸", @"衡水", @"哈尔滨", @"鹤岗", @"黑河", @"鹤壁", @"黄石", @"黄冈", @"衡阳", @"怀化", @"呼和浩特", @"呼伦贝尔", @"淮安", @"葫芦岛", @"海东", @"海北", @"黄南", @"海西", @"菏泽", @"哈密", @"和田", @"红河", @"湖州", @"汉中"],
                    @"J" : @[@"济南", @"嘉兴", @"嘉峪关", @"金昌", @"酒泉", @"江门", @"揭阳", @"鸡西", @"佳木斯", @"焦作", @"济源", @"荆门", @"荆州", @"景德镇", @"九江", @"吉安", @"吉林市", @"锦州", @"晋城", @"晋中", @"济宁", @"金华"],
                    @"K" : @[@"昆明", @"开封", @"克拉玛依", @"克孜勒苏", @"喀什"],
                    @"L" : @[@"洛阳", @"柳州", @"连云港", @"六安", @"龙岩", @"兰州", @"陇南", @"临夏", @"来宾", @"六盘水", @"廊坊", @"漯河", @"娄底", @"辽源", @"辽阳", @"临汾", @"吕梁", @"莱芜", @"临沂", @"聊城", @"泸州", @"乐山", @"凉山", @"拉萨", @"林芝", @"丽江", @"临沧", @"丽水"],
                    @"M" : @[@"马鞍山", @"茂名", @"梅州", @"牡丹江", @"绵阳", @"眉山"],
                    @"N" : @[@"南京", @"宁波", @"南宁", @"南通", @"南平", @"宁德", @"南阳", @"南昌", @"内江", @"南充", @"那曲", @"怒江"],
                    @"P" : @[@"莆田", @"平凉", @"平顶山", @"濮阳", @"萍乡", @"盘锦", @"攀枝花"],
                    @"Q" : @[@"青岛", @"泉州", @"庆阳", @"清远", @"钦州", @"黔西南", @"黔东南", @"黔南", @"秦皇岛" ,@"齐齐哈尔", @"七台河", @"潜江", @"曲靖", @"衢州"],
                    @"R" : @[@"日照", @"日喀则"],
                    @"S" : @[@"深圳", @"上海", @"深圳", @"苏州", @"厦门", @"三亚", @"宿州", @"三明", @"韶关", @"汕头", @"汕尾", @"三沙", @"石家庄", @"双鸭山", @"绥化", @"三门峡", @"商丘", @"十堰", @"随州", @"神农架", @"邵阳", @"宿迁", @"上饶", @"四平", @"松原", @"沈阳", @"石嘴山", @"朔州", @"遂宁", @"山南", @"石河子", @"思茅", @"绍兴", @"商洛"],
                    @"T" : @[@"天津", @"铜陵", @"天水", @"铜仁", @"唐山", @"天门", @"通辽", @"泰州", @"通化", @"铁岭", @"太原", @"泰安", @"吐鲁番", @"塔城", @"台州", @"铜川"],
                    @"W" : @[@"芜湖", @"武威", @"梧州", @"乌海", @"乌兰察布盟", @"无锡", @"吴忠", @"潍坊", @"威海", @"乌鲁木齐", @"文山", @"温州", @"渭南"],
                    @"X" : @[@"西安", @"徐州", @"宣城", @"邢台", @"新乡", @"许昌", @"信阳", @"襄阳", @"孝感", @"咸宁", @"仙桃", @"湘潭", @"西乡土家族苗族自治州", @"兴安盟", @"锡林郭勒盟", @"新余", @"西宁", @"忻州", @"西双版纳", @"咸阳"],
                    @"Y" : @[@"阳江", @"云浮", @"玉林", @"伊春", @"宜昌", @"岳阳", @"益阳", @"永州", @"盐城", @"扬州", @"鹰潭", @"宜春", @"延边", @"营口", @"银川", @"玉树", @"阳泉", @"运城", @"烟台", @"宜宾", @"雅安", @"伊犁", @"玉溪", @"延安", @"榆林"],
                    @"Z" : @[@"珠海", @"中山", @"漳州", @"张掖", @"湛江", @"肇庆", @"遵义", @"张家口", @"郑州", @"周口", @"驻马店", @"长沙", @"株洲", @"张家界", @"镇江", @"长春", @"中卫", @"长治", @"淄博", @"枣庄", @"自贡", @"资阳", @"昭通", @"舟山"]
                    }.mutableCopy;
    [self.keys addObjectsFromArray:[[self.cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    /* 添加热门城市 */
    NSString *strHot = @"#";
    NSString *posit =@"&";
    [self.keys insertObject:posit atIndex:0];
    [self.keys insertObject:strHot atIndex:1];
    [self.cities setObject:_arrayHotCity forKey:strHot];
    [self.cities setObject:self.positCityArr forKey:posit];
    for (NSString *key in self.cities) {
        NSArray *arr = self.cities[key];
        for (NSString *str in arr) {
            [self.allCities addObject:str];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}




- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self localCityHandle];
    

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.tempNum) {
        case 0: {
            NSString *key = [_keys objectAtIndex:section];
            NSArray *citySection = [_cities objectForKey:key];
            return [citySection count];
        }
            break;
            
        default: {
            return _resultArr.count;
        }
            break;
    }
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.tempNum) {
        case 0:
            switch (indexPath.section) {
                case 0: {
                    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                             TableSampleIdentifier];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc]
                                initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:TableSampleIdentifier];
                    }
                    if (self.localCity.length == 0) {
                        cell.textLabel.text = @"定位中...";
                    } else {
                        cell.textLabel.text = self.localCity;
                        cell.textLabel.textColor = THEMECOLOR;
                    }
                    return cell;
                }
                    break;
                    
                    
                default: {
                    static NSString *ordinaryCell = @"ordinaryCell";
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ordinaryCell];
                    if (cell == nil) {
                        cell = [[UITableViewCell alloc]
                                initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:ordinaryCell];
                    }
                    cell.textLabel.textColor = [UIColor colorWithRed:20 / 255.0 green:20 / 255.0 blue:20 / 255.0 alpha:1.0f];
                    if (indexPath.section == 1) {
                        cell.textLabel.textColor = [UIColor  redColor];
                    }
                    cell.textLabel.text = [[_cities objectForKey:[_keys objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
                    
                    return cell;
                }
                    break;
            }

            break;
            
        default: {
            static NSString *ordinaryCell = @"resultCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ordinaryCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:ordinaryCell];
            }
            cell.textLabel.textColor = [UIColor colorWithRed:20 / 255.0 green:20 / 255.0 blue:20 / 255.0 alpha:1.0f];
            cell.textLabel.text = [[_newsDic objectForKey:@"🔍"] objectAtIndex:indexPath.row];
            if ([cell.textLabel.text isEqualToString:@"暂无相关搜索"]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
            break;
    }
}


#pragma mark - tableView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    bgView.backgroundColor = [UIColor colorWithRed:201 / 255.0 green:201 / 255.0 blue:206 / 255.0 alpha:1.0f];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 250, 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:60 /255.0 green:60 / 255.0 blue:60 / 255.0 alpha:1.0];
    titleLabel.font = [UIFont systemFontOfSize:12];
    
    NSString *key = [_keys objectAtIndex:section];
    if ([key rangeOfString:@"#"].location != NSNotFound) {
        titleLabel.text = @"热门城市";
    } else if ([key rangeOfString:@"&"].location != NSNotFound) {
        titleLabel.text = @"定位当前城市";
    } else {
        titleLabel.text = key;
    }
    
    [bgView addSubview:titleLabel];
    
    return bgView;
}



- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _keys;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
#warning 常住地发送到服务器

    
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
