//
//  ShufflingFigureView.h
//  MFSC
//
//  Created by mfwl on 16/2/17.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ShufflingFigureView : UIView


@property (nonatomic, strong) NSMutableArray *arr;


- (instancetype)initWithPageNum:(NSInteger)num;


@end
