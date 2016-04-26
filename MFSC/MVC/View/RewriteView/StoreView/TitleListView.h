//
//  TitleListView.h
//  MFSC
//
//  Created by mfwl on 16/4/6.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseView.h"

@protocol TitleListViewDelegate <NSObject>

- (void)postNum:(NSInteger)row;

@end

@interface TitleListView : BaseView

@property (nonatomic, strong) NSArray *dicArr;

@property (nonatomic, assign) id<TitleListViewDelegate> delegate;

@end
