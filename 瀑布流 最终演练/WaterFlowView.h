//
//  WaterFlowView.h
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowCell.h"
@class WaterFlowView;
@protocol WaterFlowViewDataSource <NSObject>
@required

- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumn:(NSInteger)column;

- (WaterFlowCell *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView;
@end

@protocol WaterFlowViewDelegate<NSObject, UIScrollViewDelegate>
@optional
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface WaterFlowView : UIScrollView
@property (nonatomic,weak) id <WaterFlowViewDelegate> delegate;
@property (nonatomic,weak) id <WaterFlowViewDataSource> dataSource;
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (void)reloadData;
@end
