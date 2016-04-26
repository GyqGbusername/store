//
//  UserButtonView.h
//  MFSC
//
//  Created by mfwl on 16/2/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserInfoModel;

@interface UserButtonView : UIView

@property (nonatomic, strong) UIButton *vouchers;
@property (nonatomic, strong) UIButton *comments;

@property (nonatomic, strong) UserInfoModel *userMode;


@end
