//  代码地址: https://github.com/CoderMJLee/MJRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+MJRefresh.h
//  MJRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  给ScrollView增加下拉刷新、上拉刷新的功能

#import <UIKit/UIKit.h>
#import "MJRefreshConst.h"

@class MJRefreshHeader, MJRefreshFooter;


/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, MJRefreshAnimationType) {
    /** Gif 动画 */
    MJRefreshAnimationType_Gif = 1,
    /** 正常状态 */
    MJRefreshAnimationType_Normal,
};

@interface UIScrollView (MJRefresh)
/** 下拉刷新控件 */
@property (strong, nonatomic) MJRefreshHeader *mj_header;
@property (strong, nonatomic) MJRefreshHeader *header MJRefreshDeprecated("使用mj_header");
/** 上拉刷新控件 */
@property (strong, nonatomic) MJRefreshFooter *mj_footer;
@property (strong, nonatomic) MJRefreshFooter *footer MJRefreshDeprecated("使用mj_footer");

#pragma mark - other
- (NSInteger)mj_totalDataCount;
@property (copy, nonatomic) void (^mj_reloadDataBlock)(NSInteger totalDataCount);

/**
 设置下拉刷新控件动画样式 【后期修改添加方法】

 @param animationType 动画样式
 @param target 响应对象
 @param action 绑定方法
 @return 返回刷新对象
 */
-(MJRefreshHeader *)headerWithAnimationType:(MJRefreshAnimationType)animationType refreshingTarget:(id)target refreshingAction:(SEL)action;

@end
