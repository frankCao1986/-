//
//  ProductViewController.m
//  瀑布流 最终演练
//
//  Created by YUXIANG CAO on 14/12/13.
//  Copyright (c) 2014年 YUXIANG CAO. All rights reserved.
//

#import "ProductViewController.h"
#import "UIImageView+WebCache.h"
#import "MyCartTableViewController.h"
@interface ProductViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign,nonatomic) BOOL isLike;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *cfavLabel;
@property (weak, nonatomic) IBOutlet UILabel *creplyLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSMutableDictionary *dataList;
@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    
    UIBarButtonItem *rightbar = [[UIBarButtonItem alloc]init];
    [rightbar setImage:[UIImage imageNamed:@"detailNote_cart_btn"]];
    self.navigationItem.rightBarButtonItem = rightbar;
    [self.navigationItem.rightBarButtonItem setTarget:self];
    [self.navigationItem.rightBarButtonItem setAction:@selector(viewMyCartClicked)];
    
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [str stringByAppendingPathComponent:@"cart.plist"];
    self.dataList = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    if ([self.dataList.allKeys containsObject:self.clothDetail.gid]) {
        [self.likeButton setImage:[UIImage imageNamed:@"detail_favbutton_bg_highlighted"] forState:UIControlStateNormal];
        _isLike = YES;
    }
    if (self.dataList == nil) {
        self.dataList = [NSMutableDictionary dictionary];
    }
     _isLike = NO;
}

- (void)setupView{
    [self.imageView sd_setImageWithURL:self.cloth.img];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.priceLabel setText:self.clothDetail.price];
    [self.cfavLabel setText:[NSString stringWithFormat:@"%ld",(long)self.clothDetail.cfav]];
    [self.creplyLabel setText:[NSString stringWithFormat:@"累计评价(%ld)",(long)self.clothDetail.creply]];
    [self.titleLabel setText:self.clothDetail.title];
}
- (IBAction)clickLike:(UIButton *)sender {
    NSLog(@"clik");
     NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [str stringByAppendingPathComponent:@"cart.plist"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if (!self.isLike) {
        [self.likeButton setImage:[UIImage imageNamed:@"detail_favbutton_bg_highlighted"] forState:UIControlStateNormal];
        self.isLike = YES;
        self.clothDetail.cfav += 1;
       
        NSData *clothData = [NSKeyedArchiver archivedDataWithRootObject:self.cloth];
        NSData *detailCloth =[NSKeyedArchiver archivedDataWithRootObject:self.clothDetail];
        [userDefault setObject:clothData forKey:@"cloth"];
        [userDefault setObject:detailCloth forKey:@"detail"];
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[clothData,detailCloth] forKeys:@[@"cloth",@"detail"]];

        [self.dataList setObject:dict forKey:self.clothDetail.gid] ;
    
        NSLog(@"%@",path);
        
    }
    else{
        
        [self.likeButton setImage:[UIImage imageNamed:@"detail_favbutton_bg"] forState:UIControlStateNormal];
        self.isLike = NO;
        self.clothDetail.cfav -= 1;
        [self.dataList removeObjectForKey:self.clothDetail.gid];
    }
    
    [self.dataList writeToFile:path atomically:YES];
    [self.cfavLabel setText:[NSString stringWithFormat:@"%ld",(long)self.clothDetail.cfav]];
    
}

- (void)viewMyCartClicked{
    NSLog(@"Hello");
    //    myCartController
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    MyCartTableViewController *myController = [storyBoard instantiateViewControllerWithIdentifier:@"myCartController"];
    [myController setTitle:@"我的宝贝"];
    [self.navigationController pushViewController:myController animated:YES];
}

@end
