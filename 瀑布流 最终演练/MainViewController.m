//
//  MainViewController.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/12.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "MainViewController.h"
#import "ClothDataModel.h"
#import "UIImageView+WebCache.h"
#import "ProductViewController.h"
#import "ClothDetailDataModel.h"
#import "MyCartTableViewController.h"
#import "SDImageCache.h"
#import "UIImage+WebP.h"
@interface MainViewController ()
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,weak) UIRefreshControl *refreshControl;
@property (nonatomic,strong)NSArray *urlList;
@property (nonatomic,strong) NSMutableArray *dataDetailList;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"myURL" withExtension:@"plist"];
    self.urlList = [NSArray arrayWithContentsOfURL:url];
    [self setupNavigationBar];
    [self setupTabBar];
    [self setupRefreshControl];

    
}
#pragma mark - 当前视图navigation bar and tab bar 视图设置
#pragma mark 设置菊花
- (void)setupRefreshControl{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(testRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.waterFlowView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    [self testRefresh:self.refreshControl];
}
- (void)testRefresh:(UIRefreshControl *)refreshControl
{
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
//        [NSThread sleepForTimeInterval:3];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM d, h:mm a"];
            NSString *lastUpdate = [NSString stringWithFormat:@"Last updated on %@", [formatter stringFromDate:[NSDate date]]];
            
            refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdate];
            [self loadData];

            [refreshControl endRefreshing];
    
        });
//    });

    
    
}

#pragma mark 设置 navigation bar
- (void)setupNavigationBar{

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mine_bac_pink"] forBarMetrics:UIBarMetricsDefault];
    self.title = @"女装";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    NSDictionary *dicninoary = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dicninoary ;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc]init];
    [rightbar setImage:[UIImage imageNamed:@"detailNote_cart_btn"]];
    self.navigationItem.rightBarButtonItem = rightbar;
    [self.navigationItem.rightBarButtonItem setTarget:self];
    [self.navigationItem.rightBarButtonItem setAction:@selector(viewMyCartClicked)];
    
    
}
#pragma mark 设置tab bar
- (void)setupTabBar{
    [self.navigationController.tabBarItem setTitle:@"流行趋势"];
    [self.navigationController.tabBarItem setImage:[[UIImage imageNamed:@"tabbar_icon_cat"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.navigationController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tabbar_icon_cat_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    NSDictionary *attriSelected = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:255/255 green:76/255 blue:108/255 alpha:1] forKey:NSForegroundColorAttributeName];
    [self.navigationController.tabBarItem setTitleTextAttributes:attriSelected forState:UIControlStateSelected];
    
}
#pragma mark 点击navigation bar 右上按钮事件
- (void)viewMyCartClicked{

//    myCartController
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    MyCartTableViewController *myController = [storyBoard instantiateViewControllerWithIdentifier:@"myCartController"];
    [myController setTitle:@"我的宝贝"];
    [self.navigationController pushViewController:myController animated:YES];
}
- (void)refreshData{

    [self.waterFlowView setContentOffset:CGPointMake(0, -100) animated:YES];
    [self.refreshControl beginRefreshing];
    [self testRefresh:self.refreshControl];
}
#pragma mark - 加载网络数据
- (void)loadData{
    static int index = 0;

    if (index >= self.urlList.count) {
        return;
    }
//    for (NSInteger i = 0; i < self.urlList.count; i++) {
    

    NSString *str = self.urlList[index];
    index++;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];

    NSData *data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:nil error:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = dict[@"result"][@"list"];
    if (self.dataList  == nil) {
        self.dataList = [NSMutableArray array];
    }
    if (self.dataDetailList == nil) {
        self.dataDetailList = [NSMutableArray array];
    }
    for (NSDictionary *dict in array) {
        ClothDataModel *cloth = [[ClothDataModel alloc]init];
        NSDictionary *showDict = dict[@"show"];
        NSDictionary *detailDict = dict[@"goods"][0];
        [cloth setValuesForKeysWithDictionary:showDict];
        
        ClothDetailDataModel *clothDetail = [[ClothDetailDataModel alloc]init];
        clothDetail.price = cloth.price;
        clothDetail.title = detailDict[@"title"];
        clothDetail.gid = detailDict[@"gid"];
        clothDetail.cfav = [dict[@"cfav"] integerValue];
        clothDetail.creply = [dict[@"creply"] integerValue];
        [self.dataList addObject:cloth];
        [self.dataDetailList addObject:clothDetail];
    }
//        }
    [self.waterFlowView reloadData];
}
#pragma mark - water flow view 数据源方法
#pragma mark water flow 列数
- (NSInteger)numberOfColumnsInWaterFlowView:(WaterFlowView *)waterFlowView{
    return 3;
}
#pragma mark water flow 单元格数
- (NSInteger)waterFlowView:(WaterFlowView *)waterFlowView numberOfRowsInColumn:(NSInteger)column{
    return self.dataList.count;
}
#pragma mark 实例化单元格
- (WaterFlowCell *)waterFlowView:(WaterFlowView *)waterFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static int count = 0;
    WaterFlowCell *cell = [waterFlowView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[WaterFlowCell alloc]initWithReuseIdentifier:@"ID"];
        count++;
        NSLog(@"%d",count);
    }

    ClothDataModel *cloth = self.dataList[indexPath.row];
    
    [cell.imageView sd_setImageWithURL:cloth.img];
    [cell.textLabel setText:cloth.price];
    
    return cell;
}
#pragma mark 设置单元格高度
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClothDataModel *cloth = self.dataList[indexPath.row];
    CGFloat colWidth = self.view.bounds.size.width / 3;
    return colWidth / cloth.w * cloth.h;
}
#pragma mark -  water flow 代理方法
#pragma mark 选中单元格方法
- (void)waterFlowView:(WaterFlowView *)waterFlowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    ProductViewController *productController = [storyBoard instantiateViewControllerWithIdentifier:@"productController"];
    [self.navigationController pushViewController:productController animated:YES];
    productController.cloth = self.dataList[indexPath.row];
    productController.clothDetail = self.dataDetailList[indexPath.row];
    productController.title = @"宝贝详情";

}
#pragma mark - scroll view delegate 方法
#pragma mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height) {
        [self loadData];
    }
   
}


@end
