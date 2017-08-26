//
//  FrankPagesView.m
//  RefectoryProject
//
//  Created by Frank on 2017/8/25.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "FrankPagesView.h"
#import "FrankMiddleToolbar.h"

@interface FrankPagesView ()<UIScrollViewDelegate,FrankMiddleToolbarDelegate>

@property (nonatomic, weak) id<FrankDetailDropDelegate>delegate;

/**
 展示条
 */
@property (nonatomic, strong) FrankMiddleToolbar * toolBar;
/**
 底部滑动视图
 */
@property (nonatomic, strong) UIScrollView * bottomScrollView;

@property (nonatomic, strong)NSMutableArray * titlesArr;

/**
 当前视图
 */
@property (nonatomic, strong) UIView * currentScrollView;
/**
 存放底部视图
 */
@property (nonatomic, strong) NSMutableArray * bottomViewArr;


@end

@implementation FrankPagesView



- (NSMutableArray *)bottomViewArr{
    
    if (!_bottomViewArr) {
        _bottomViewArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _bottomViewArr;
}
- (NSMutableArray *)titlesArr{
    
    if (!_titlesArr) {
        
        if ([self.delegate respondsToSelector:@selector(resetToolbarTitles)] && [self.delegate resetToolbarTitles]) {
            _titlesArr = [[NSMutableArray alloc] initWithCapacity:0];
            
            [_titlesArr addObjectsFromArray:[self.delegate resetToolbarTitles]];
        }
    }
    return _titlesArr;
}

- (FrankMiddleToolbar *)toolBar{
    
    if (!_toolBar) {
        
        _toolBar = [[FrankMiddleToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 44)];
        _toolBar.delegate = self;
        _toolBar.toolTitles = self.titlesArr;
    }
    return _toolBar;
}
- (void)chooseBarItemWithIndex:(NSInteger)index{
    
    CGPoint offset = CGPointMake((index - 1) * CGRectGetWidth(self.frame), 0);
    [self.bottomScrollView setContentOffset:offset animated:YES];
}

- (UIScrollView *)bottomScrollView{
    
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.toolBar.frame),  CGRectGetWidth(self.frame),  CGRectGetHeight(self.frame) - CGRectGetHeight(self.toolBar.frame))];
        
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        
        _bottomScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.titlesArr.count, CGRectGetHeight(_bottomScrollView.bounds));
        
        for (NSInteger i = 0; i < self.titlesArr.count; i++) {
            
            UIView * view = nil;
            if ([self.delegate respondsToSelector:@selector(resetBottomViewsWithIndex:)]) {
                
                view = [self.delegate resetBottomViewsWithIndex:i+1];
                
            }
            
            if (!view) {
                view = [[UIView alloc] init];
                view.backgroundColor = [UIColor whiteColor];
            }
            CGFloat width = CGRectGetWidth(self.bounds);
            CGFloat height =  CGRectGetHeight(self.bounds) - CGRectGetHeight(self.toolBar.bounds);
            CGFloat off_x = i * width;
            
            view.frame = CGRectMake(off_x, 0, width, height);
            
            [self.bottomViewArr addObject:view];
            
            [_bottomScrollView addSubview:view];
        }
        
        
    }
    return _bottomScrollView;
}
#pragma mark ------  UIScrollViewDelegate  -----------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.bottomScrollView) {
        
        CGFloat x = scrollView.contentOffset.x/CGRectGetWidth(scrollView.bounds);
        
        NSInteger index = roundf(x);
                
        self.toolBar.changeIndex = index + 1;
    }
}

+ (instancetype)createFrankPagesViewWithFrame:(CGRect)frame delegate:(id<FrankDetailDropDelegate>)delegate{
    
    FrankPagesView * view = [[FrankPagesView alloc] initWithFrame:frame];
    view.delegate = delegate;
    [view setupViews];
    
    return view;
    
}
- (void)setupViews{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.toolBar];
    [self addSubview:self.bottomScrollView];
    
}

@end
