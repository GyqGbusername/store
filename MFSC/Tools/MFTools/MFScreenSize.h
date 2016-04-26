//
//  MFScreenSize.h
//  MFSC
//
//  Created by mfwl on 16/4/19.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#ifndef MFScreenSize_h
#define MFScreenSize_h


#define layoutWidth layoutAttributes.frame.size.width
#define layoutHeight layoutAttributes.frame.size.height
#define applyFrame (CGRectMake(0, 0, layoutWidth, layoutHeight))


#define viewWidth self.frame.size.width
#define viewHeight self.frame.size.height


#define kScreen_Height      ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width       ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame       (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))


#endif /* MFScreenSize_h */
