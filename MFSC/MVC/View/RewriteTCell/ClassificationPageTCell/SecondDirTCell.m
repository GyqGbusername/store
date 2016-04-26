//
//  secondDirTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/9.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "SecondDirTCell.h"
#import "ProjectNameCell.h"

@interface SecondDirTCell () < UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *threeDirectoryCV;

@end


@implementation SecondDirTCell



-(void)dealloc {
    _threeDirectoryCV.delegate = nil;
    _threeDirectoryCV.dataSource = nil;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
        [flowLayout setItemSize:CGSizeMake((kScreen_Width - 120) / 3, 40)];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 5;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 0, 0, 0);
        self.threeDirectoryCV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 265, 185) collectionViewLayout:flowLayout];
        [self.contentView addSubview:self.threeDirectoryCV];
        [self.threeDirectoryCV mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
        }];
        self.threeDirectoryCV.delegate = self;
        self.threeDirectoryCV.dataSource = self;
        self.threeDirectoryCV.backgroundColor = [UIColor whiteColor];
        [self.threeDirectoryCV registerClass:[ProjectNameCell class] forCellWithReuseIdentifier:@"ProjectNameCell"];
        
    }
    return self;
}


#pragma set CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     ProjectNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProjectNameCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
  
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self post:[NSString stringWithFormat:@"%d", indexPath.item]];
    
}
- (void)post:(NSString *)goodsName {
   
    [mFNotiCenter postNotificationName:@"goodsCellName" object:@"goodsCellName" userInfo:@{@"cellName":goodsName}];
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
