//
//  NetworkHandle.h
//  UI17_网络封装_图片异步下载
//
//  Created by dllo on 15/9/8.
//  Copyright (c) 2015年 GYQ. All rights reserved.
//

#import <Foundation/Foundation.h>


/* 协议 */
@protocol NetworkHandleDelegate <NSObject>

- (void)didFinishLoading:(id)result;

@end

@interface NetworkHandle : NSObject




#pragma mark - 封装:通过block向外传值
+ (void)asynGETJSONWithURL:(NSString *)urlString completion:(void(^)(id result))block;



@end
