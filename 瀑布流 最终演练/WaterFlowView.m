//
//  WaterFlowView.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "WaterFlowView.h"
@interface WaterFlowView()
@property (nonatomic,strong) NSMutableArray *cellFrameArrayM;
@property (nonatomic,strong) NSMutableArray *indexPathArrayM;
@property (nonatomic,strong) NSMutableDictionary *cellsOnScreenDictM;
@property (nonatomic,strong) NSMutableSet *reuseCellSet;
@property (nonatomic,assign) NSInteger columnNumber;
@end
@implementation WaterFlowView
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self reloadData];
}

- (void)generateCacheData{
    NSInteger numberOfRow = [self rowCount];
    if (self.cellFrameArrayM == nil) {
        self.cellFrameArrayM = [NSMutableArray arrayWithCapacity:numberOfRow];
    }
    else{
        [self.cellFrameArrayM removeAllObjects];
    }
    if (self.indexPathArrayM == nil) {
        self.indexPathArrayM = [NSMutableArray arrayWithCapacity:numberOfRow];
    }
    else{
        [self.indexPathArrayM removeAllObjects];
    }
    for (NSInteger i = 0; i < numberOfRow; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.indexPathArrayM addObject:indexPath];
    }
    
    if (self.cellsOnScreenDictM == nil) {
        self.cellsOnScreenDictM = [NSMutableDictionary dictionary];
    }
    else{
        [self.cellsOnScreenDictM removeAllObjects];
    }
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[WaterFlowCell class]]) {
              [view removeFromSuperview];
        }
      
    }
}
- (void)reloadData{
    [self generateCacheData];

    CGFloat colw = self.bounds.size.width / self.columnNumber;
    CGFloat currentY[_columnNumber];
    for (NSInteger i = 0; i < _columnNumber; i++) {
        currentY[i] = 0.0;
    }
    // 确定每一个单元格的位置
    // 确定 contentSize 以保证用户滚动的流畅
    NSInteger col = 0;
    
    // 设置每个单元格的frame
    for (NSIndexPath *indexPath in self.indexPathArrayM) {
        CGFloat h = [self.delegate waterFlowView:self heightForRowAtIndexPath:indexPath];
        CGFloat x  = col * colw;
        CGFloat y = currentY[col];
        currentY[col] += h;
        NSInteger nextCol = (col + 1) % _columnNumber;
        if (currentY[col] > currentY[nextCol]) {
            col = nextCol;
        }
        [self.cellFrameArrayM addObject:[NSValue valueWithCGRect:CGRectMake(x, y, colw,h)]];
    }
    // 3. layout View
    
    CGFloat maxH = 0;
    for (NSInteger i = 0; i < _columnNumber; i++) {
        if (currentY[i] > maxH) {
            maxH = currentY[i];
        }
    }
    // 设置scroll view 的 content size
    [self setContentSize:CGSizeMake(self.bounds.size.width, maxH)];

}

- (void)layoutSubviews{
    // 实例化单元格，并且加入当前视图
    [super layoutSubviews];
    for (NSIndexPath *indexPath in self.indexPathArrayM) {
        // 1. 从当前视图中取出单元格
        // 2. 如果为空，则通过dataSource 调用新的单元格
        //  2.1 如果单元格应该加入视图，则添加进视图
        // 3. 如果不为空，则判定此单元格是否在当前视图中
        //  3.1 如果不应该在当前视图，则从当前视图中删除，病加入缓存池
        WaterFlowCell *cell = self.cellsOnScreenDictM[indexPath];
        if (cell == nil) {
            CGRect frame = [self.cellFrameArrayM[indexPath.row] CGRectValue];
            cell = [self.dataSource waterFlowView:self cellForRowAtIndexPath:indexPath];
            if ([self isInScreenWithFrame:frame]) {
                [cell setFrame:frame];
                [self.cellsOnScreenDictM setObject:cell forKey:indexPath];
                [self addSubview:cell];
            }
        }
        else{
            if (![self isInScreenWithFrame:cell.frame]) {
                [cell removeFromSuperview];
                [self. reuseCellSet addObject:cell];
                [self.cellsOnScreenDictM removeObjectForKey:indexPath];
            }
        }
    }
    NSLog(@"%d",self.subviews.count);
}
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    // 从缓存池中实例化一个可以重用单元格
    WaterFlowCell *cell = [self.reuseCellSet anyObject];
    if (cell) {
        [self.reuseCellSet removeObject:cell];
    }
    return cell;
}
- (BOOL)isInScreenWithFrame:(CGRect)frame{
    return (frame.origin.y + frame.size.height > self.contentOffset.y) && (frame.origin.y < self.contentOffset.y + self.frame.size.height);
}
-(NSInteger)rowCount{
    return [self.dataSource waterFlowView:self numberOfRowsInColumn:0];
}
-(NSInteger)columnNumber{
    _columnNumber = [self.dataSource numberOfColumnsInWaterFlowView:self];
    return _columnNumber;
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    NSIndexPath *touchedIndexPath = nil;
    for (NSIndexPath *indexPath in self.indexPathArrayM) {
        CGRect frame = [self.cellFrameArrayM[indexPath.row] CGRectValue];
        CGFloat frameTop = frame.origin.y;
        CGFloat frameBottom = frame.origin.y + frame.size.height;
        CGFloat frameLeft = frame.origin.x;
        CGFloat frameRight = frame.origin.x + frame.size.width;
        if (location.y > frameTop && location.y < frameBottom && location.x > frameLeft && location.x < frameRight) {
            touchedIndexPath = indexPath;
            break;
        }
    }
    [self.delegate waterFlowView:self didSelectRowAtIndexPath:touchedIndexPath];
}
@end
