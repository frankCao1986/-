//
//  WaterFlowCell.m
//  瀑布流 最终演练
//
//  Created by ; CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "WaterFlowCell.h"
#define kWaterCellMargin 5
@implementation WaterFlowCell

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}


- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_imageView];
    }
    return _imageView;
}
- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc]init];
        [_textLabel setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
        [_textLabel setTextColor:[UIColor whiteColor]];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [self insertSubview:_textLabel aboveSubview:self.imageView];
    }
    return _textLabel;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectInset(self.bounds, kWaterCellMargin, kWaterCellMargin)];
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:@[[UIFont systemFontOfSize:18]] forKeys:@[NSFontAttributeName]];
    
    CGRect frame = [self.textLabel.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    
    CGFloat h = frame.size.height;
    
    CGFloat w = self.imageView.bounds.size.width;
    
    CGFloat hh = self.bounds.size.height;
    
    [self.textLabel setFrame:CGRectMake(kWaterCellMargin, hh - h - kWaterCellMargin, w,h)];
    
}
@end

