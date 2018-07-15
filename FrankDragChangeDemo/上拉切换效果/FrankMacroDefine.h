//
//  FrankMacroDefine.h
//  FrankDragChangeDemo
//
//  Created by KingLions on 2018/7/15.
//  Copyright © 2018年 Frank. All rights reserved.
//

#import <Foundation/Foundation.h>


//获取当前设备对应的height
#define Screen_height (MAX([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width))
//获取当前设备对应的width
#define Screen_width (MIN([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width))

#define IS_IPHONE_X (fabs( (double)Screen_height - (double )812) < DBL_EPSILON)


// 适配 iPhone X
// 状态栏高度
#define Frank_Status_Height (IS_IPHONE_X ? 44.f:20.f) // 直接区别于  iPhoneX 的状态栏高度
#define FrankCurrent_Status_Height [[UIApplication sharedApplication] statusBarFrame].size.height // 获取状态栏高度
// Tabbar 高度
#define Frank_Tabbar_Height (IS_IPHONE_X ? (49.f + 34.f):20.f) // 直接区别于  iPhoneX 的Tabbar高度
// navigationBar 高度
#define Frank_NavigationBar_Height 44.f // navigationBar高度
// navigationBar + statusBar
#define Frank_StatusAndNavBar_Height (IS_IPHONE_X ? 88.f:64.f) // 直接区别于  iPhoneX 的 navigationBar + statusBar 高度
// Tabbar Safe bottom margin
#define Frank_Tabbar_Safe_BottomMargin (IS_IPHONE_X ? 34.f:0.f) // 底部约束高度

// 配置视图安全区域范围
#define Frank_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

