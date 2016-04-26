//
//  MFMacro.h
//  MFSC
//
//  Created by mfwl on 16/4/19.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#ifndef MFMacro_h
#define MFMacro_h


/* 避免循环持有 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define mFNotiCenter [NSNotificationCenter defaultCenter]

#endif /* MFMacro_h */
