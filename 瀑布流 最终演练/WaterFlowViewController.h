//
//  WaterFlowViewController.h
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowView.h"
@interface WaterFlowViewController : UIViewController <WaterFlowViewDataSource, WaterFlowViewDelegate>
@property (nonatomic,strong) WaterFlowView *waterFlowView;
@end
