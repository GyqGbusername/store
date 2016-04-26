//
//  MFCurrentDevice.h
//  MFSC
//
//  Created by mfwl on 16/4/19.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#ifndef MFCurrentDevice_h
#define MFCurrentDevice_h

/* 关于真机信息的宏 */
#import "CurrentDevice.h"
#define DEVICEMODEL [[CurrentDevice shareCurrentDevice] deviceModel]
#define DEVICEMODEL_t [[CurrentDevice sharedDeviceManager] deviceModel]
#define DEVICEINFO [[CurrentDevice shareCurrentDevice] getDeviceVersionInfo]
#define CORRESPONDVERSION [[CurrentDevice shareCurrentDevice] correspondVersion]


#endif /* MFCurrentDevice_h */
