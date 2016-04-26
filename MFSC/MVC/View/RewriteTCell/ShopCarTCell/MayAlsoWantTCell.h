//
//  MayAlsoWantTCell.h
//  MFSC
//
//  Created by mfwl on 16/4/13.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "BaseTableViewCell.h"


@protocol  MayAlsoWantTCellDelegate <NSObject>

- (void)passContent:(NSString *)content;

@end

@interface MayAlsoWantTCell : BaseTableViewCell


@property (nonatomic, assign) id <MayAlsoWantTCellDelegate> delegate;

@end
