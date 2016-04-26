//
//  NetworkHandle.m
//  UI17_网络封装_图片异步下载
//
//  Created by dllo on 15/9/8.
//  Copyright (c) 2015年 GYQ. All rights reserved.
//

#import "NetworkHandle.h"

@interface NetworkHandle ()

@end


@implementation NetworkHandle


/* 将网络请求进行封装 */
+ (void)asynGETJSONWithURL:(NSString *)urlString completion:(void(^)(id result))block {
    /* 1.转码 */
    NSString *enCodingStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    /* 2.创建URL对象 */
    NSURL *url = [NSURL URLWithString:enCodingStr];
    /* 3.创建请求 */
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionConfiguration *configur = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:configur];
    /* 4.创建链接接受数据 */
    NSURLSessionTask *task = [mySession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        /* 6.通过block将result值返回出去 */
        NSError *er = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&er];

        block(result);
    }];
    [task resume];
}





@end
