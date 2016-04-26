//
//  TitleListTCell.m
//  MFSC
//
//  Created by mfwl on 16/4/6.
//  Copyright © 2016年 mfwl. All rights reserved.
//

#import "TitleListTCell.h"

@interface TitleListTCell ()


@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *titleLaB;


@end

@implementation TitleListTCell



- (void)setModel:(BaseModel *)model {
    self.img.image = [UIImage imageNamed:model.img];
    self.titleLaB.text = model.content;
}


- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
