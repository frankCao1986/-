//
//  ClothDetailDataModel.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/13.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "ClothDetailDataModel.h"

@implementation ClothDetailDataModel
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.price forKey:@"price"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeInteger:self.cfav forKey:@"cfav"];
    [aCoder encodeInteger:self.creply forKey:@"creply"];
    [aCoder encodeObject:self.gid forKey:@"gid"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self.price = [aDecoder decodeObjectForKey:@"price"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.cfav = [aDecoder decodeIntegerForKey:@"cfav"];
    self.creply = [aDecoder decodeIntegerForKey:@"creploy"];
    self.gid = [aDecoder decodeObjectForKey:@"gid"];
    return self;
}
@end
