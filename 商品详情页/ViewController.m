//
//  ViewController.m
//  商品详情页
//
//  Created by mac on 2017/5/23.
//  Copyright © 2017年 CoderZNBmm. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <MJRefresh.h>
#import "ZNBTestCell.h"
#import "IndicateView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate>
@property (strong, nonatomic) UIScrollView *contentView;
@property (strong, nonatomic) UITableView *tabV;
@property (strong, nonatomic) WKWebView *webV;

@property (strong, nonatomic) UILabel *tabVIndicate;
@property (strong, nonatomic) UILabel *webVIndicate;
@property (strong, nonatomic) IndicateView *indicateView;
@end

@implementation ViewController

- (UILabel *)tabVIndicate
{
    if (_tabVIndicate == nil) {
        _tabVIndicate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        _tabVIndicate.text = @"继续拖动查看更多信息";
        _tabVIndicate.font = [UIFont systemFontOfSize:13];
        _tabVIndicate.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        _tabVIndicate.textAlignment = NSTextAlignmentCenter;
        
    }
    return _tabVIndicate;
}
- (UILabel *)webVIndicate
{
    if (_webVIndicate == nil) {
        _webVIndicate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
        _webVIndicate.text = @"继续拖动回到顶部";
        _webVIndicate.font = [UIFont systemFontOfSize:13];
        _webVIndicate.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        _webVIndicate.textAlignment = NSTextAlignmentCenter;
    }
    return _webVIndicate;
}
- (IndicateView *)indicateView
{
    if (_indicateView == nil) {
        _indicateView = [IndicateView shareIndicateView];
        _indicateView.frame = CGRectMake(0, 0, ScreenW, 40);
    }
    return _indicateView;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, (ScreenH-64))];
    self.contentView.contentSize = CGSizeMake(ScreenW, (ScreenH-64)*2);
    self.contentView.pagingEnabled = YES;
    self.contentView.scrollEnabled = NO;
    [self.view addSubview:self.contentView];
    self.tabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-64) style:UITableViewStylePlain];
    self.tabV.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.tabV.delegate = self;
    self.tabV.dataSource = self;
    self.tabV.tableFooterView = self.indicateView;
    [self.contentView addSubview:self.tabV];
    [self.tabV registerNib:[UINib nibWithNibName:NSStringFromClass([ZNBTestCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.webV = [[WKWebView alloc] initWithFrame:CGRectMake(0, ScreenH-64, ScreenW, ScreenH-64)];
    self.webV.scrollView.delegate = self;
    self.webV.navigationDelegate = self;
    [self.contentView addSubview:_webV];
    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉执行对应的操作
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.contentView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            //结束加载
            [self.webV.scrollView.mj_header endRefreshing];
        }];
        
    }];
    [header setTitle:@"继续拖动回到顶部" forState:MJRefreshStateIdle];
    [header setTitle:@"松手回到顶部" forState:MJRefreshStatePulling];
    [header setTitle:@"准备回到顶部" forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.arrowView.hidden = YES;
    self.webV.scrollView.mj_header = header;
    
    
    [self.tabV reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZNBTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}


#pragma mark - scrollView 的代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    CGFloat maxOffset = contentHeight - scrollView.bounds.size.height;
    if (scrollView == self.tabV) {
        if (offsetY+10 > maxOffset ) {
            
            [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0/0.55 options:0 animations:^{
                scrollView.contentOffset = CGPointMake(0, offsetY+10);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.5 animations:^{
                    self.contentView.contentOffset = CGPointMake(0, ScreenH-64);
                }];
            }];
           
            [UIView animateWithDuration:0.9 animations:^{
                
            }completion:^(BOOL finished) {
               
            }];
        }
        
    }
}

#pragma mark - <WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
