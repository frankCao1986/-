//
//  MyCartTableViewController.h
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/14.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCartTableViewCell.h"
#import "ClothDataModel.h"
#import "ClothDetailDataModel.h"
@interface MyCartTableViewController : UITableViewController
@property (nonatomic,strong) ClothDataModel *cloth;
@property (nonatomic,strong) ClothDetailDataModel *clothDetail;
@end
