//
//  ClassListView.h
//  MFSC
//
//  Created by mfwl on 16/3/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassListViewDelegate <NSObject>

- (void)ClassListViewDidSelectTitleName:(NSString *)titleName;

@end

@interface ClassListView : UIView

@property(nonatomic, assign) id <ClassListViewDelegate> delegate;

- (instancetype)initWith:(NSArray *)titleArr with:(NSInteger)selectedIndex;

@end
