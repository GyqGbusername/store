//
//  StoreIntroAndImageTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/30.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "StoreIntroAndImageTCell.h"

@interface StoreIntroAndImageTCell ()


@end


@implementation StoreIntroAndImageTCell




- (IBAction)show:(id)sender {
    
    [mFNotiCenter postNotificationName:@"introduceBT" object:@"introduceBT"];

}

@end
