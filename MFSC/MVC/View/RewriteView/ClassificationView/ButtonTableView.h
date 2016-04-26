//
//  ButtonTableView.h
//  MFSC
//
//  Created by mfwl on 16/4/8.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseView.h"

@protocol ButtonTableViewDelegate <NSObject>

- (void)pass:(NSString *)name;

@end


@interface ButtonTableView : BaseView

@property (nonatomic, assign) id<ButtonTableViewDelegate> delegate;

@end
