//
//  FrankDropBounsView.h
//  RefectoryProject
//
//  Created by Frank on 2017/8/24.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FrankDropBounsView;
@protocol FrankDropBounsViewDelegate <NSObject>

@required
/**
 设置弹出的上部视图
 */
- (UIView *)FrankDropBounsViewResetTopView;


@end

@interface FrankDropBounsView : UIScrollView



/**
 是否需要显示提示文字视图
 */
@property (nonatomic, assign) BOOL needShowAlertView;
/**
 页面显示的提示文字，默认为【上拉查看更多宝贝详情】
 */
@property (nonatomic, strong) NSString * alertTitle;



/* 
 FrankDropBounsViewDelegate,FrankDetailDropDelegate
 */
+ (instancetype)createFrankDropBounsViewWithFrame:(CGRect)frame withDelegate:(id<FrankDropBounsViewDelegate>)delegate;


/**
 显示顶部视图
 */
- (void)showTopPageViewWithCompleteBlock:(void(^)())completeBlock;

/**
 显示底部视图
 */
- (void)showBottomPageViewWithCompleteBlock:(void(^)())completeBlock;

@end
