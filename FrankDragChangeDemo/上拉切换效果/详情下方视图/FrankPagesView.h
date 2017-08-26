//
//  FrankPagesView.h
//  RefectoryProject
//
//  Created by Frank on 2017/8/25.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrankDetailDropDelegate.h"

@interface FrankPagesView : UIView

/**
 偏移量
 */
@property (nonatomic, assign) CGPoint contentOffset;

+ (instancetype)createFrankPagesViewWithFrame:(CGRect)frame delegate:(id<FrankDetailDropDelegate>)delegate;

@end
