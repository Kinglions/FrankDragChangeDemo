//
//  FrankDropBounsView.m
//  RefectoryProject
//
//  Created by Frank on 2017/8/24.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "FrankDropBounsView.h"
#import "FrankPagesView.h"

@interface FrankDropBounsView ()<UIScrollViewDelegate>

@property (nonatomic, strong) id<FrankDetailDropDelegate>dropDelegate;

/**
 上方内容视图
 */
@property (nonatomic, strong) UIView * topContentView;
@property (nonatomic, strong) UIView * topView;
/**
 下方内容视图
 */
@property (nonatomic, strong) FrankPagesView * bottomContentView;
/**
 提示视图
 */
@property (nonatomic, strong) UILabel * middleLabel;

/**
 顶部偏移高度
 */
@property (nonatomic, assign) CGFloat topHeight;

/**
 记录当前的视图偏移量
 */
@property (nonatomic, assign) CGPoint currentOffset;


@end


@implementation FrankDropBounsView

@synthesize alertTitle = _alertTitle;


+ (instancetype)createFrankDropBounsViewWithFrame:(CGRect)frame withDelegate:(id)delegate{
    
    
    CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    FrankDropBounsView * view = [[FrankDropBounsView alloc] initWithFrame:rect];
    
    view.dropDelegate = delegate;
    [view setupViews];
    return view;
}

- (CGFloat)topHeight{
    
    return 0;
}

- (void)setNeedShowAlertView:(BOOL)needShowAlertView{
    
    _needShowAlertView = needShowAlertView;
    
    // 不需要显示提示文字视图
    if (!needShowAlertView) {
        self.middleLabel.hidden = YES;
        self.topView.frame = CGRectMake(0, self.topHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
}
- (void)setAlertTitle:(NSString *)alertTitle{
    
    _alertTitle = alertTitle;
    
    if (!alertTitle) {
        
        _alertTitle = @"上拉查看更多宝贝详情";
    }
    
    self.middleLabel.text = _alertTitle;
}
- (NSString *)alertTitle{
    
    if (_alertTitle.length > 0) {
        
        return _alertTitle;
    }
    
    return @"上拉查看更多宝贝详情";
}
- (UIView *)topContentView{
    
    if (!_topContentView) {
        _topContentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topHeight, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _topContentView.backgroundColor = [UIColor whiteColor];
        if ([self.dropDelegate respondsToSelector:@selector(frankDropBounsViewResetTopView)]) {
            
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_topContentView.frame) - 30, CGRectGetWidth(self.frame), 30)];
            label.text = self.alertTitle;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15.f];
            label.textColor = [UIColor blackColor];
            [_topContentView addSubview:label];
            self.middleLabel = label;
            UIView * view = [self.dropDelegate frankDropBounsViewResetTopView];
            
            if (!view) {
                view = [[UIView alloc] init];
                view.backgroundColor = [UIColor whiteColor];
            }
            
            view.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(_topContentView.frame) - CGRectGetHeight(label.frame));
            self.topView = view;
            [_topContentView addSubview:view];
            
        }
    }
    
    return _topContentView;
}
- (FrankPagesView *)bottomContentView{
    
    if (!_bottomContentView) {
        
        _bottomContentView = [FrankPagesView createFrankPagesViewWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) delegate:(id<FrankDetailDropDelegate>)self.dropDelegate];
    }
    return _bottomContentView;
}
- (void)setupViews{
    
    
    self.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame));
    [self addSubview:self.topContentView];
    self.topContentView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self addSubview:self.bottomContentView];
    
}

/**
 显示顶部视图
 */
- (void)showTopPageViewWithCompleteBlock:(void (^)())completeBlock{
    
    [self setContentOffset:(CGPoint){0,0} animated:YES];
    
    if (self.needShowAlertView) {
        
        self.middleLabel.hidden = NO;
    }
    if (completeBlock) {
        completeBlock();
    }
}

/**
 显示底部视图
 */
- (void)showBottomPageViewWithCompleteBlock:(void (^)())completeBlock{
    
    [self setContentOffset:(CGPoint){0,CGRectGetHeight(self.bounds) - self.topHeight} animated:YES];
    if (self.needShowAlertView) {
        
        self.middleLabel.hidden = YES;
    }
    
    if (completeBlock) {
        completeBlock();
    }
}


- (void)viewControllerWillAppear {
    
    self.contentOffset = self.currentOffset;
}
- (void)viewControllerWillDisappear {
    
    self.currentOffset = self.contentOffset;
}

@end
