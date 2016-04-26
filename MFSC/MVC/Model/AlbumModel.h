//
//  AlbumModel.h
//  MFSC
//
//  Created by mfwl on 16/3/23.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumModel : NSObject

@property (nonatomic, copy) NSString *albumName;//相册名
@property (nonatomic, assign) NSInteger count; //相册里面内容的个数（多少图片或者视频）
@property (nonatomic, strong) PHFetchResult *result; //保存这个相册的内容

@end
