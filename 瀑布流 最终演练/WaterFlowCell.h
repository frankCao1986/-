//
//  WaterFlowCell.h
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFlowCell : UIView
{
    UITableViewCell *myCell;
}


@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) NSString *reuseIdentifier;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
