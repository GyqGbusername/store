//
//  TitleCCell.m
//  MFSC
//
//  Created by mfwl on 16/2/19.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "TitleCCell.h"

@interface  TitleCCell () {
    NSString *allPlist;
    NSString *name;
    NSString *isFirst;
}
@property (nonatomic, strong) NSMutableDictionary *dic;




@end

@implementation TitleCCell

- (void)firstRunning {
    
    self.dic = [NSMutableDictionary dictionaryWithContentsOfFile:allPlist];
    name = [self.dic objectForKey:@"FirstRunning"];
}



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        allPlist = [[NSBundle mainBundle] pathForResource:@"TitleList" ofType:@"plist"];
        self.label1 = [[UILabel alloc] init];
        [self firstRunning];
        [self.contentView addSubview:self.label1];
    }
    return self;
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    [self.label1 setFrame:CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height - 2)];
    self.label1.textAlignment = 1;
    self.label1.font = [UIFont systemFontOfSize:15];
}

- (void)setTempStr:(NSString *)tempStr {
    if (_tempStr != tempStr) {
        _tempStr = tempStr;
    }
    [self firstRunning];
    if ([self.label1.text isEqualToString:name]) {
        self.label1.textColor = STEXTCOLOR;
    } else {
        self.label1.textColor = TEXTCOLOR;
    }
}



@end
