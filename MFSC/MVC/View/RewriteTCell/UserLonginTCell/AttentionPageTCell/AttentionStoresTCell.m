//
//  AttentionStoresTCell.m
//  MFSC
//
//  Created by mfwl on 16/3/22.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "AttentionStoresTCell.h"

@interface AttentionStoresTCell ()
@property (strong, nonatomic) IBOutlet StartView *stareView;

@end

@implementation AttentionStoresTCell



- (void)awakeFromNib {
    self.stareView = [[StartView alloc] initWithFrame:CGRectMake(118, 39, 120, 38)];
    [self.contentView addSubview:self.stareView];
    
    [self.stareView startWithStringCount:@"9"];
}

@end
