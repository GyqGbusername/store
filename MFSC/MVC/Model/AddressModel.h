//
//  AddressModel.h
//  MFSC
//
//  Created by mfwl on 16/3/28.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic, copy) NSString *region_id;
@property (nonatomic, copy) NSString *region_name;
@property (nonatomic, copy) NSDictionary *city;
@property (nonatomic, copy) NSDictionary *area;


@end
