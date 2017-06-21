//
//  ZNBTestViewController.m
//  商品详情页
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ZNBTestViewController.h"
#import "UIImage+Image.h"
@interface ZNBTestViewController ()

@end

@implementation ZNBTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = [UIImage imageWithFrame:CGRectMake(0, 0, 2, 2) color:ZNBColorAlpha(99, 99, 99, 0.1) cornerRadius:0];
    [self.navigationController.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
