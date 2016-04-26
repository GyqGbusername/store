//
//  HeadportraitView.h
//  MFSC
//
//  Created by mfwl on 16/3/22.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadportraitViewDelegate <NSObject>

- (void)passTag:(NSInteger)tag;

@end

@interface HeadportraitView : UIView

@property (nonatomic, assign) id <HeadportraitViewDelegate> delegate;

@end
