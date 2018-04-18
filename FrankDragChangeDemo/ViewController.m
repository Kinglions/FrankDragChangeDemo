//
//  ViewController.m
//  FrankDragChangeDemo
//
//  Created by Frank on 2017/8/26.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "ViewController.h"
#import "FrankDefineHeader.h"
#import "MJRefresh.h"

@interface ViewController ()<FrankDetailDropDelegate>

@property (nonatomic, strong) FrankDropBounsView * dropView;
@property (nonatomic, strong) UILabel * tabbarView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.dropView];
    [self.view addSubview:self.tabbarView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 消除导航影响
    [self.dropView viewControllerWillAppear];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
     // 消除导航影响
    [self.dropView viewControllerWillDisappear];
}


- (UILabel *)tabbarView{
    
    if (!_tabbarView) {
        _tabbarView = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 50, CGRectGetWidth(self.view.frame), 50)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.text = @"这里定义操作界面";
        _tabbarView.textAlignment = NSTextAlignmentCenter;
    }
    
    return _tabbarView;
}
- (FrankDropBounsView *)dropView{
    
    if (!_dropView) {
        
        CGFloat height = CGRectGetHeight(self.view.frame) - CGRectGetHeight(self.tabbarView.frame) - 64;
        _dropView = [FrankDropBounsView createFrankDropBounsViewWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), height) withDelegate:self];
        _dropView.needShowAlertView = YES;// 设置是否显示提示文字
        _dropView.alertTitle = @"这是一个自定义的文字提示";
    }
    
    return _dropView;
}


- (void)pullDownToReloadData:(MJRefreshNormalHeader *)table{
    NSLog(@"--- 下拉");
    
    [self.dropView showTopPageViewWithCompleteBlock:^{
        
        [table endRefreshing];
    }];
}
- (void)pullUpToReloadMoreData:(MJRefreshBackNormalFooter *)table{
    NSLog(@"--- 上拉");
    
    [self.dropView showBottomPageViewWithCompleteBlock:^{
        
        [table endRefreshing];
    }];
}
#pragma mark ---------  TripDetailDropDelegate  -------------
/**
 自定义上部展示视图模块 代理方法
 */
- (UIView *)frankDropBounsViewResetTopView{
    
    UITableView * view = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    view.backgroundColor = [UIColor redColor];
    
    view.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpToReloadMoreData:)];
    
    return view;
}
#pragma mark ---------  TripDetailDropDelegate  -------------
/**
 自定义切换标题模块 代理方法
 */
- (NSArray *) resetToolbarTitles{
    
    return @[@"产品详情",@"用户评价(0)",@"费用及须知"];
}
/**
 自定义底部展示视图模块 代理方法
 */
- (UIView *)resetBottomViewsWithIndex:(NSInteger)index{
    
    UITableView * view = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    view.backgroundColor = index == 1?[UIColor redColor]:index == 2?[UIColor greenColor]:[UIColor yellowColor];
    view.mj_header = [view headerWithAnimationType:MJRefreshAnimationType_Normal refreshingTarget:self refreshingAction:@selector(pullDownToReloadData:)];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    
    return view;
}

- (void)clickBtn {
    NSLog(@"--- push");
    UIViewController * controller = [UIViewController new];
    controller.view.backgroundColor = [UIColor yellowColor];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
