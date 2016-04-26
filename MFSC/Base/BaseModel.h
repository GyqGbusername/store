//
//  BaseModel.h
//  ceshi1
//
//  Created by mfwl on 16/1/26.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nID;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *content;
+ (id)modelWithDictionary:(NSDictionary *)dic;

@end
