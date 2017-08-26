//
//  FrankMiddleToolbar.h
//  RefectoryProject
//
//  Created by Frank on 2017/8/23.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FrankMiddleToolbarDelegate <NSObject>

/**
 当前选中的索引值 【索引值从 1 开始对应】
 */
- (void)chooseBarItemWithIndex:(NSInteger)index;

@end

@interface FrankMiddleToolbar : UIView


@property (nonatomic, weak)id<FrankMiddleToolbarDelegate>delegate;
/**
 按钮标题数组
 */
@property (nonatomic, strong) NSArray * toolTitles;

/**
 选中标题颜色
 */
@property (nonatomic, strong) UIColor * selectedColor;

/**
 默认颜色
 */
@property (nonatomic, strong) UIColor * defaultColor;


/**
 外部滑动修改索引 【索引值从 1 开始对应】
 */
@property (nonatomic, assign) NSInteger changeIndex;

@end
