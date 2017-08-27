//
//  FrankDetailDropDelegate.h
//  RefectoryProject
//
//  Created by Frank on 2017/8/24.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FrankDetailDropDelegate <NSObject>

@required

/**
 设置弹出的上部视图
 */
- (UIView *)frankDropBounsViewResetTopView;

/**
 配置toolbar的名字

 @return 返回名字数组
 */
- (NSArray *)resetToolbarTitles;
/**
 配置底部视图
 
 @param index 对应的索引

 */
- (UIView *)resetBottomViewsWithIndex:(NSInteger)index;

@end

