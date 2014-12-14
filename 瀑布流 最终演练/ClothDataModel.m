//
//  ClothDataModel.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "ClothDataModel.h"

@implementation ClothDataModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeFloat:self.h forKey:@"h"];
    [aCoder encodeFloat:self.w forKey:@"w"];
    [aCoder encodeObject:self.price forKey:@"price"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self.img = [aDecoder decodeObjectForKey:@"img"];
    self.h = [aDecoder decodeFloatForKey:@"h"];
    self.w = [aDecoder decodeFloatForKey:@"w"];
    self.price = [aDecoder decodeObjectForKey:@"price"];
    
    return  self;
}
@end
