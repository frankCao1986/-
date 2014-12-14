//
//  MyCartTableViewController.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/14.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "MyCartTableViewController.h"
#import "ProductViewController.h"
@interface MyCartTableViewController ()
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) NSMutableArray *detailDataList;
@end

@implementation MyCartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSData *cloth = [userDefault objectForKey:@"cloth"];
    NSData *detalCloth = [userDefault objectForKey:@"detail"];
    self.cloth = [NSKeyedUnarchiver unarchiveObjectWithData:cloth];
    self.clothDetail = [NSKeyedUnarchiver unarchiveObjectWithData:detalCloth];
    
    if (self.dataList == nil) {
        self.dataList = [NSMutableArray array];
    }
    else{
        [self.dataList removeAllObjects];
    }
    
    if (self.detailDataList == nil) {
        self.detailDataList = [NSMutableArray array];
    }
    else{
        [self.detailDataList removeAllObjects];
    }
    
    
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [str stringByAppendingPathComponent:@"cart.plist"];
    
    NSDictionary *allDict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    
    for (NSDictionary *dict in allDict) {
        ////        NSData *data =
        

        //        NSLog(@"%@",cloth.price);
        ClothDataModel *cloth = [NSKeyedUnarchiver unarchiveObjectWithData:allDict[dict][@"cloth"]];
        ClothDetailDataModel *detail = [NSKeyedUnarchiver unarchiveObjectWithData:allDict[dict][@"detail"]];
        [self.dataList addObject:cloth];
        [self.detailDataList addObject:detail];
    }
    
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    if (cell == nil) {
        cell = [[MyCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemCell"];
    }
    // Configure the cell...
    cell.cloth = self.dataList[indexPath.row];
    cell.clothDetail = self.detailDataList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    ProductViewController *productController = [storyBoard instantiateViewControllerWithIdentifier:@"productController"];
    [self.navigationController pushViewController:productController animated:YES];
    productController.cloth = self.dataList[indexPath.row];
    productController.clothDetail = self.detailDataList[indexPath.row];
    productController.title = @"宝贝详情";
}
@end
