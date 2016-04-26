//
//  AuthCodeView.h
//  MFSC
//
//  Created by mfwl on 16/2/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthCodeView : UIView


@property (strong, nonatomic) NSArray *dataArray;//字符素材数组

@property (strong, nonatomic) NSMutableString *authCodeStr;//验证码字符串


- (void)reloadContent;


@end
