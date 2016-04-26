//
//  ClearBV.h
//  MFSC
//
//  Created by mfwl on 16/4/7.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseView.h"

@protocol ClearBVDelegate <NSObject>

- (void)closeSelf;

@end

@interface ClearBV : BaseView

@property (nonatomic, strong) id<ClearBVDelegate> delegate;

@end
