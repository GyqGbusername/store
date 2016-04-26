//
//  BaseModel.m
//  ceshi1
//
//  Created by mfwl on 16/1/26.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.nID = value;
    }
}

+ (id)modelWithDictionary:(NSDictionary *)dic {
    __strong Class model = [[[self class] alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

@end
