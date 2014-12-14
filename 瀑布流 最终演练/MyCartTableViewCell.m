//
//  MyCartTableViewCell.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/14.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "MyCartTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface MyCartTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;


@end
@implementation MyCartTableViewCell

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.itemImageView sd_setImageWithURL:self.cloth.img];
    [self.itemImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.itemTitleLabel setText:self.clothDetail.title];
    [self.itemPriceLabel setText:self.cloth.price];
}

@end
