//
//  HomePageSecCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "HomePageSecCCell.h"
#import "TitleCell.h"
#import "ElaborationTCell.h"
#import "LastTCell.h"

@interface HomePageSecCCell () <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSArray *classArr;



@end

@implementation HomePageSecCCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.classArr = @[@"仔猪保育料", @"药", @"asd", @"asd", @"asd", @"asd"];
        self.backgroundColor = BACKCOLOR;
        [self createTableView];
    }
    return self;
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
    [self.homePageTableView registerClass:[TitleCell class] forCellReuseIdentifier:@"HomePageSecCCell_TitleCell"];
    [self.homePageTableView registerClass:[ElaborationTCell class] forCellReuseIdentifier:@"HomePageSecCCell_ElaborationTCell"];
    [self.homePageTableView registerClass:[LastTCell class] forCellReuseIdentifier:@"HomePageSecCCell_LastTCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageSecCCell_TitleCell"];
        return cell;
    } else if (indexPath.row == 1) {
        ElaborationTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageSecCCell_ElaborationTCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    } else {
        LastTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageSecCCell_LastTCell"];
        cell.surperTableViewName = @"Main";
        cell.contentArr =  @[@{@"com": @"万嘉",@"name": @"血浆蛋白", @"title":@"喷雾干燥猪血浆蛋白粉 NP - 2009", @"img" : @"danchang", @"price": @"￥123.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥123.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥23.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥23.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白" ,@"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥23.00"}, @{@"com": @"中粮",@"name": @"血浆蛋白", @"title":@"保育大母猪饲料 SB - 2012", @"img" : @"danfang", @"price": @"￥23.00"}];
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
        return 260;
    } else {
        return ((kScreen_Width - 30) / 2 + 40) * 5;
    }
}



@end
