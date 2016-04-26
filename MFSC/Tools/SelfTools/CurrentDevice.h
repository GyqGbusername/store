//
//  CurrentDevice.h
//  MFSC
//
//  Created by mfwl on 16/1/29.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CurrentDevice : NSObject

+ (instancetype)sharedDeviceManager; /* 单利 */
+ (instancetype)shareCurrentDevice; /* 单利 */

- (id)deviceModel;/* 类型 ipad iphone ipod */
- (NSString *)getDeviceVersionInfo; /* 设备信息 */
- (NSString *)correspondVersion; /* 对应的设备名 iphone5 iphone5s */


@end
