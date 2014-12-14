//
//  WaterFlowViewController.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "WaterFlowViewController.h"

@interface WaterFlowViewController ()

@end

@implementation WaterFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)loadView{
    _waterFlowView = [[WaterFlowView alloc]initWithFrame:CGRectZero];
    [_waterFlowView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ];
    [_waterFlowView setDelegate:self];
    [_waterFlowView setDataSource:self];
    self.view = _waterFlowView;
}
- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumn:(NSInteger)column{
    return 0;
}

- (WaterFlowCell *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
@end
