//
//  ClothDetailDataModel.h
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/13.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClothDetailDataModel : NSObject <NSCoding>
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSInteger cfav;
@property (nonatomic,assign) NSInteger creply;
@property (nonatomic,strong) NSString *gid;
@end
