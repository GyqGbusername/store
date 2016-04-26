//
//  SearchResultVC.h
//  MFSC
//
//  Created by mfwl on 16/3/11.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseController.h"

@interface SearchResultVC : BaseController
@property (nonatomic, copy) NSString *tempStr;
@property (nonatomic, strong) IBOutlet UITableViewCell *searchTCell;
@end
