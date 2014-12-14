//
//  MainViewController.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "SecondViewController.h"
#import "ClothDataModel.h"
#import "UIImageView+WebCache.h"
@interface SecondViewController ()
@property (nonatomic,strong) NSArray *dataList;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupNavigationBar];
    [self setupTabBar];
    
    
}
- (void)setupNavigationBar{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mine_bac_pink"] forBarMetrics:UIBarMetricsDefault];
    self.title = @"女装";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSDictionary *dicninoary = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dicninoary ;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
}

- (void)setupTabBar{
    [self.navigationController.tabBarItem setTitle:@"时尚前沿"];
    [self.navigationController.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_icon_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_icon_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //    NSDictionary *attriNormal = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:252/255 green:60/255 blue:100/255 alpha:1] forKey:NSForegroundColorAttributeName];
    NSDictionary *attriSelected = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:255/255 green:76/255 blue:108/255 alpha:1] forKey:NSForegroundColorAttributeName];
    [self.navigationController.tabBarItem setTitleTextAttributes:attriSelected forState:UIControlStateSelected];
    
}
- (void)refreshData{
    NSLog(@"Hello World");
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y > 50) {
        [self refreshData];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    NSLog(@"%f",scrollView.contentOffset.y);
}
- (void)loadData{
    NSString *str = @"http://www.mogujie.com/app_mgj_v511_book/clothing?_adid=5503509D-800B-45EF-B767-F6586FFF165E&_did=0f607264fc6318a92b9e13c65db7cd3c&_atype=iPhone&_source=NIMAppStore511&_fs=NIMAppStore511&_swidth=640&_network=2&_mgj=%@&title=最热&from=hot_element&login=false&fcid=6550&q=最热&track_id=1377824666&homeType=shopping";
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = dict[@"result"][@"list"];
    NSMutableArray *resultM = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        ClothDataModel *cloth = [[ClothDataModel alloc]init];
        NSDictionary *showDict = dict[@"show"];
        [cloth setValuesForKeysWithDictionary:showDict];
        [resultM addObject:cloth];
    }
    self.dataList = resultM;
}

- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView{
    return 3;
}

- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumn:(NSInteger)column{
    return self.dataList.count;
}

- (WaterFlowCell *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WaterFlowCell *cell = [waterFlowView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[WaterFlowCell alloc]initWithReuseIdentifier:@"ID"];
    }
    ClothDataModel *cloth = self.dataList[indexPath.row];
    [cell.imageView sd_setImageWithURL:cloth.img];
    [cell.textLabel setText:cloth.price];
    
    return cell;
}

- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    rh = OH * (OW/3)/OW
    ClothDataModel *cloth = self.dataList[indexPath.row];
    CGFloat colWidth = self.view.bounds.size.width / 3;
//    NSLog(@"%f",colWidth / cloth.w * cloth.h);
    
    return colWidth / cloth.w * cloth.h;
}
@end
