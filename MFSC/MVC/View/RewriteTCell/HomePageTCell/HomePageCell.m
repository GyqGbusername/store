//
//  HomePageCell.m
//  MFSC
//
//  Created by mfwl on 16/2/17.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "HomePageCell.h"
#import "IntroduceCCell.h"



@interface HomePageCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *introCollectionView;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *introArr;

@end

@implementation HomePageCell

- (void)dealloc {
    _introCollectionView.delegate = nil;
    _introCollectionView.dataSource = nil;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageArr = @[@"gonggao", @"baike", @"huodong", @"yizhan"];
        self.introArr = @[@"麦丰公告", @"麦丰百科", @"精彩活动", @"快马驿站"];
        
        [self createCollectionView];
    }
    return self;
}
- (void)createCollectionView {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.scrollDirection = 1;
    flow.itemSize = CGSizeMake(kScreen_Width / 4, 100);
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    self.introCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100) collectionViewLayout:flow];
    self.introCollectionView.delegate = self;
    self.introCollectionView.dataSource = self;
    self.introCollectionView.scrollEnabled = NO;
    self.introCollectionView.backgroundColor = [UIColor whiteColor];
    self.introCollectionView.showsHorizontalScrollIndicator = NO;
    self.introCollectionView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:self.introCollectionView];
    [self.introCollectionView registerClass:[IntroduceCCell class] forCellWithReuseIdentifier:@"HomePageCell_IntroduceCCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    IntroduceCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCell_IntroduceCCell" forIndexPath:indexPath];
    [cell.introImage setImage:[UIImage imageNamed:self.imageArr[indexPath.item]]];
    cell.introLabel.text = self.introArr[indexPath.item];
    
    return cell;
}

#warning introduce ours events

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    [self clickWith:[NSString stringWithFormat:@"%@", self.introArr[indexPath.item]]];
}

- (void)clickWith:(NSString *)str {
   
    /* 发送通知 */
    /**
     * @param name 通知名
     * @param object 通知发送对象
     * @param userInfo 通知所带的信息(字典)
     */
    [mFNotiCenter postNotificationName:@"change" object:@"intro" userInfo:@{@"push":str}];
}






- (void)layoutSubviews {
    [super layoutSubviews];

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
