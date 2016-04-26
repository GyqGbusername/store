//
//  ImageChooseTool.m
//  MFSC
//
//  Created by mfwl on 16/3/23.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "ImageChooseTool.h"
#import "AlbumModel.h"

@interface ImageChooseTool ()

@property (nonatomic, strong) PHCachingImageManager *cacheImageManager;


@end

@implementation ImageChooseTool


+ (instancetype)sharedManager{
    static ImageChooseTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ImageChooseTool alloc] init];
    });
    
    return instance;
}

- (void)loadAlbumInfoWithCompletionBlock:(void (^)(NSArray *))completionBlock{
    //用来存放每个相册model
    NSMutableArray *albumModelsArray = [NSMutableArray array];
    
    //创建读取哪些相册的subType
    PHAssetCollectionSubtype subType = PHAssetCollectionSubtypeSmartAlbumVideos|PHAssetCollectionSubtypeSmartAlbumUserLibrary|PHAssetCollectionSubtypeSmartAlbumScreenshots;
    
    //1.获取所有相册的信息PHFetchResult<PHAssetCollection *>
    PHFetchResult *albumsCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:subType options:nil];
    
    //2.遍历albumsCollection获取每一个相册的具体信息
    [albumsCollection enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //将obj转化为某个具体类型 PHAssetCollection 代表一个相册
        PHAssetCollection *collection = (PHAssetCollection *)obj;
        
        //创建读取相册信息的options
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        
        //读取相册里面的所有信息 PHFetchResult <PHAsset *>
        PHFetchResult *assetsResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        
        if (assetsResult.count > 0) {
            //创建一个model封装这个相册的信息
            AlbumModel *model = [[AlbumModel alloc] init];
            model.albumName = collection.localizedTitle;//相册名
            model.count = assetsResult.count; //相册里面内容的个数（多少图片或者视频）
            model.result = assetsResult; //保存这个相册的内容
            [albumModelsArray addObject:model];
        }
        
    }];
    
    //回调
    //completionBlock ? completionBlock(albumModelsArray) : nil;
    if (completionBlock != nil) {
        completionBlock(albumModelsArray);
    }
}

- (PHCachingImageManager *)cacheImageManager {
    if (_cacheImageManager == nil) {
        self.cacheImageManager = [[PHCachingImageManager alloc] init];
    }
    return _cacheImageManager;
}

- (void)getThumbnailImageWithAsset:(PHAsset *)asset completionBlock:(void (^)(UIImage *))completionBlock{
    
    //创建异步读取图片的选项options
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.synchronous = NO;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    [self.cacheImageManager requestImageForAsset:asset targetSize:CGSizeMake(70*scale, 70*scale) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        //回调读取的图片
        completionBlock ? completionBlock(result) : nil;
    }];
}

- (void)getPreviewImageWithAsset:(PHAsset *)asset completionBlock:(void (^)(UIImage *))completionBlock{
    //创建异步读取图片的选项options
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.synchronous = NO;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    [self.cacheImageManager requestImageForAsset:asset targetSize:CGSizeMake(screenSize.width*scale, screenSize.height*scale) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        //回调读取的图片
        completionBlock ? completionBlock(result) : nil;
    }];
    
}

- (void)getOriginImageWithAsset:(PHAsset *)asset completionBlock:(void (^)(UIImage *))completionBlock{
    //创建异步读取图片的选项options
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = NO;
    
    [self.cacheImageManager requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        //回调读取的图片
        completionBlock ? completionBlock(result) : nil;
    }];
}

@end
