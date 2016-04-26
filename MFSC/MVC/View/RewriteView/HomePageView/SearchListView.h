//
//  SearchListView.h
//  MFSC
//
//  Created by mfwl on 16/3/24.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchListViewDelegate <NSObject>

- (void)search:(NSString *)name;

@end

@interface SearchListView : UIView

@property (nonatomic, assign) id <SearchListViewDelegate> delegate;

@end
