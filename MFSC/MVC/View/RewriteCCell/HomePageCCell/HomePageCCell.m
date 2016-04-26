//
//  HomePageCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/17.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "HomePageCCell.h"
#import "HomePageCell.h"
#import "TitleCell.h"
#import "IntroTCell.h"
#import "GoodsTCell.h"
#import "LastTCell.h"
#import "StoreModel.h"

@interface HomePageCCell () <UITableViewDataSource, UITableViewDelegate>


//@property (nonatomic, strong) UITableView *homePageTableView;
@property (nonatomic, strong) NSArray *classArr;
@property (nonatomic, strong) NSMutableArray *modelArr;
@property (nonatomic, strong) NSDictionary *exDic;

@end

@implementation HomePageCCell

- (void)dealloc {
    _homePageTableView.dataSource = nil;
    _homePageTableView.delegate = nil;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
#warning 商品列表数据
        self.modelArr = [NSMutableArray arrayWithCapacity:0];
        self.classArr = @[@{@"type" : @"饲料",@"img":@"siliaochang",
                            @"content" : @[@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img1"},@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img2"},@{@"title":@"仔猪药料",@"price":@"123.00",@"img":@"img3"},@{@"title":@"仔猪保育料",@"price":@"153.00",@"img":@"img4"},@{@"title":@"粉末",@"price":@"143.00",@"img":@"img2"},@{@"title":@"鱼饲料",@"price":@"173.00",@"img":@"img4"},@{@"title":@"蛋疼",@"price":@"133.00",@"img":@"img2"}]} ,
                          @{@"type" : @"兽药",@"img":@"shouyaochang",
                            @"content" : @[@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img1"},@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img2"},@{@"title":@"仔猪药料",@"price":@"123.00",@"img":@"img3"},@{@"title":@"仔猪保育料",@"price":@"153.00",@"img":@"img4"},@{@"title":@"粉末",@"price":@"143.00",@"img":@"img2"},@{@"title":@"鱼饲料",@"price":@"173.00",@"img":@"img4"},@{@"title":@"蛋疼",@"price":@"133.00",@"img":@"img2"}]},
                          @{@"type" : @"添加剂",@"img":@"siliaochang",
                            @"content" : @[@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img1"},@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img2"},@{@"title":@"仔猪药料",@"price":@"123.00",@"img":@"img3"},@{@"title":@"仔猪保育料",@"price":@"153.00",@"img":@"img4"},@{@"title":@"粉末",@"price":@"143.00",@"img":@"img2"},@{@"title":@"鱼饲料",@"price":@"173.00",@"img":@"img4"},@{@"title":@"蛋疼",@"price":@"133.00",@"img":@"img2"}]},
                          @{@"type" : @"原料",@"img":@"shouyaochang",
                            @"content" : @[@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img1"},@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img2"},@{@"title":@"仔猪药料",@"price":@"123.00",@"img":@"img3"},@{@"title":@"仔猪保育料",@"price":@"153.00",@"img":@"img4"},@{@"title":@"粉末",@"price":@"143.00",@"img":@"img2"},@{@"title":@"鱼饲料",@"price":@"173.00",@"img":@"img4"},@{@"title":@"蛋疼",@"price":@"133.00",@"img":@"img2"}]},
                          @{@"type" : @"机械设备",@"img":@"siliaochang",
                            @"content" : @[@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img1"},@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img2"},@{@"title":@"仔猪药料",@"price":@"123.00",@"img":@"img3"},@{@"title":@"仔猪保育料",@"price":@"153.00",@"img":@"img4"},@{@"title":@"粉末",@"price":@"143.00",@"img":@"img2"},@{@"title":@"鱼饲料",@"price":@"173.00",@"img":@"img4"},@{@"title":@"蛋疼",@"price":@"133.00",@"img":@"img2"}]},
                          @{@"type" : @"畜禽",@"img":@"shouyaochang",
                            @"content" : @[@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img1"},@{@"title":@"仔猪保育料",@"price":@"123.00",@"img":@"img2"},@{@"title":@"仔猪药料",@"price":@"123.00",@"img":@"img3"},@{@"title":@"仔猪保育料",@"price":@"153.00",@"img":@"img4"},@{@"title":@"粉末",@"price":@"143.00",@"img":@"img2"},@{@"title":@"鱼饲料",@"price":@"173.00",@"img":@"img4"},@{@"title":@"蛋疼",@"price":@"133.00",@"img":@"img2"}]}];

        self.backgroundColor = BACKCOLOR;
        [self createTableView];
        [self handleData];
    }
    return self;
}

- (void)handleData {
    for (NSDictionary *dic in self.classArr) {
        StoreModel *model = [StoreModel modelWithDictionary:dic];
        [self.modelArr addObject:model];
    }
   
}


#pragma mark 创建tableView
- (void)createTableView {
    self.homePageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 153) style:(UITableViewStylePlain)];
    self.homePageTableView.delegate = self;
    self.homePageTableView.dataSource = self;
    self.homePageTableView.showsHorizontalScrollIndicator = NO;
    self.homePageTableView.showsVerticalScrollIndicator = NO;

    [self.contentView addSubview:self.homePageTableView];
    self.homePageTableView.backgroundColor = BACKCOLOR;
    [self.homePageTableView registerClass:[TitleCell class] forCellReuseIdentifier:@"HomePageCCell_TitleCell"];
    [self.homePageTableView registerClass:[HomePageCell class] forCellReuseIdentifier:@"HomePageCCell_HomePageCell"];
    [self.homePageTableView registerClass:[IntroTCell class] forCellReuseIdentifier:@"HomePageCCell_IntroTCell"];
    [self.homePageTableView registerClass:[GoodsTCell class] forCellReuseIdentifier:@"HomePageCCell_GoodsTCell"];
    [self.homePageTableView registerClass:[LastTCell class] forCellReuseIdentifier:@"HomePageCCell_LastTCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCCell_TitleCell"];
        return cell;
    } else if (indexPath.row == 1) {
        HomePageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCCell_HomePageCell"];
        return cell;
    } else if (indexPath.row == 2) {
        IntroTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCCell_IntroTCell"];
        return cell;
    } else if (indexPath.row >= 3 && indexPath.row <= 8) {
        GoodsTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCCell_GoodsTCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.storeModel = self.modelArr[indexPath.row - 3];
        cell.goodsCollectionView.contentOffset = CGPointMake(0, 0);
        return cell;
    } else {
        LastTCell *cell = [tableView dequeueReusableCellWithIdentifier: @"HomePageCCell_LastTCell"];
        cell.surperTableViewName = @"Main";
        cell.contentArr =  @[@{@"com": @"万嘉",@"name": @"血浆蛋白", @"title":@"喷雾干燥猪血浆蛋白粉 NP - 2009", @"img" : @"danchang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.0"}];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 150;
    } else if (indexPath.row == 1) {
        return 100;
    } else if (indexPath.row == 2) {
        return 200;
    } else if (indexPath.row >= 3 && indexPath.row <= 8) {
        return 275;
    } else {
        return ((kScreen_Width - 30) / 2 + 70) * 5;/* 间隙10 行数 * 间隙个数 + sectionInsert(10)*/
    }
    
}




@end
