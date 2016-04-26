//
//  OrderStateTVCell.h
//  MFSC
//
//  Created by mfwl on 16/3/17.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderStateTVCellDelegate <NSObject>

- (void)jumpWith:(NSInteger)tag;

@end

@interface OrderStateTVCell : UITableViewCell
@property (nonatomic, assign) id <OrderStateTVCellDelegate> delegate;

@end
