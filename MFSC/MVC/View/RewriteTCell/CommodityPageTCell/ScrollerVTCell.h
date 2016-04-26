//
//  ScrollerVTCell.h
//  MFSC
//
//  Created by mfwl on 16/3/16.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ScrollerVTCellDelegate <NSObject>

- (void)jumpWith:(NSInteger)tag;

@end


@interface ScrollerVTCell : BaseTableViewCell

@property (nonatomic, assign) id <ScrollerVTCellDelegate> delegate;

@end
