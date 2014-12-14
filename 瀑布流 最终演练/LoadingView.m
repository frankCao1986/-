//
//  loadingView.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/13.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIActivityIndicatorView *activityIndictator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndictator setCenter:self.center];
    [activityIndictator startAnimating];
    [self addSubview:activityIndictator];
}


@end
