//
//  FrankDropBounsView.h
//  RefectoryProject
//
//  Created by Frank on 2017/8/24.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrankDetailDropDelegate.h"


@interface FrankDropBounsView : UIScrollView

/**
 是否需要显示提示文字视图
 */
@property (nonatomic, assign) BOOL needShowAlertView;
/**
 页面显示的提示文字，默认为【上拉查看更多宝贝详情】
 */
@property (nonatomic, strong) NSString * alertTitle;


/**
 创建视图

 @param frame 视图大小
 @param delegate 设置代理
 */
+ (instancetype)createFrankDropBounsViewWithFrame:(CGRect)frame withDelegate:(id<FrankDetailDropDelegate>)delegate;

/**
 显示顶部视图
 */
- (void)showTopPageViewWithCompleteBlock:(void(^)())completeBlock;

/**
 显示底部视图
 */
- (void)showBottomPageViewWithCompleteBlock:(void(^)())completeBlock;



// ------  解决 导航操作对 contentOffset 的影响
/**
 控制器  - (void)viewWillAppear:(BOOL)animated 方法中调用
 */
- (void)viewControllerWillAppear;
/**
 控制器  - (void)viewWillDisappear:(BOOL)animated 方法中调用
 */
- (void)viewControllerWillDisappear;


@end
