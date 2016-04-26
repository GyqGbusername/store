//
//  GuideViewController.h
//  ceshi
//
//  Created by mfwl on 16/1/26.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GuideViewControllerDelegate <NSObject>

- (void)jump;

@end

@interface GuideViewController : UIViewController

@property (nonatomic, assign) id <GuideViewControllerDelegate> delegate;

@end
