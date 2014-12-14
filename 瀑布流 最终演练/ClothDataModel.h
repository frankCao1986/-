//
//  ClothDataModel.h
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ClothDataModel : NSObject <NSCoding>
@property (nonatomic,strong)NSURL *img;
@property (nonatomic,assign) CGFloat h;
@property (nonatomic,assign) CGFloat w;
@property (nonatomic,strong) NSString *price;
@end
