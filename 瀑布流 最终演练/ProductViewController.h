//
//  ProductViewController.h
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/13.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothDataModel.h"
#import "ClothDetailDataModel.h"
@interface ProductViewController : UITableViewController
@property (nonatomic,strong) ClothDataModel *cloth;
@property (nonatomic,strong) ClothDetailDataModel *clothDetail;
@end
