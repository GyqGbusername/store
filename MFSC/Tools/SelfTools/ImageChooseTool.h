//
//  ImageChooseTool.h
//  MFSC
//
//  Created by mfwl on 16/3/23.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface ImageChooseTool : NSObject

/** 获取单例对象 PhotoManager */
+ (instancetype)sharedManager;

/** 读取所有相册的信息 返回数组<AlbumModel *> */
- (void)loadAlbumInfoWithCompletionBlock:(void(^)(NSArray * albumsModelArray))completionBlock;

/** 读取某个asset的图片*/
- (void)getThumbnailImageWithAsset:(PHAsset *)asset completionBlock:(void(^)(UIImage *thumbnail))completionBlock;

/** 读取预览图片 屏幕的大小*/
- (void)getPreviewImageWithAsset:(PHAsset *)asset completionBlock:(void(^)(UIImage *result))completionBlock;

/** 读取原图图片 */
- (void)getOriginImageWithAsset:(PHAsset *)asset completionBlock:(void(^)(UIImage *result))completionBlock;

@end
