//
//  FrankMiddleToolbar.m
//  RefectoryProject
//
//  Created by Frank on 2017/8/23.
//  Copyright © 2017年 Frank. All rights reserved.
//

#import "FrankMiddleToolbar.h"

@interface FrankMiddleToolbar ()

/**
 移动边线
 */
@property (strong, nonatomic) CALayer *moveLineLayer;

/**
 记录上次选中的按钮
 */
@property (nonatomic, strong) UIButton * lastBtn;


/**
 是否为点击修改
 */
@property (nonatomic, assign) BOOL isItemClick;

@end

@implementation FrankMiddleToolbar


+ (instancetype)createToolbarWithFrame:(CGRect)frame{
    
    FrankMiddleToolbar * bar = [[FrankMiddleToolbar alloc] initWithFrame:frame];
    
    bar.backgroundColor = [UIColor whiteColor];

    return bar;
}
- (instancetype) initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
    }
    return self;
}
- (void)setupViews{
    
    CALayer * line = [[CALayer alloc] init];
    line.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - 0.5, CGRectGetWidth(self.bounds), 0.5);
    
    line.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5].CGColor;
    
    [self.layer addSublayer:line];
}
- (CALayer *)moveLineLayer{
    
    if (!_moveLineLayer) {
        
        _moveLineLayer = [CALayer layer];
        _moveLineLayer.bounds = CGRectMake(0, 0, 40, 2);
        _moveLineLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _moveLineLayer;
}

- (void)setToolTitles:(NSArray *)toolTitles{
    
    _toolTitles = toolTitles;
    
    for (NSInteger i = 0; i < toolTitles.count; i++) {
        
        CGFloat width = CGRectGetWidth(self.bounds)/toolTitles.count;
        CGFloat height = CGRectGetHeight(self.bounds);
        CGFloat off_x = i * width;
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(off_x, 0, width, height)];
        btn.tag = i + 1;
        [btn setTitle:toolTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.defaultColor?:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        
        
        [btn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            
            btn.selected = YES;
            self.lastBtn = btn;
            [self.layer addSublayer:self.moveLineLayer];
            [self setMoveLineAnimationStatusWithBtn:btn];
        }
        
        [self addSubview:btn];
    }

}
-(void)setMoveLineAnimationStatusWithBtn:(UIButton *)btn{
    
    CGFloat btnWidth = CGRectGetWidth(self.bounds)/self.toolTitles.count;
    CGFloat width = CGRectGetWidth(self.moveLineLayer.bounds);
    CGFloat height = CGRectGetHeight(self.moveLineLayer.bounds);
    CGFloat offset_x = (btn.tag - 1)*btnWidth+(btnWidth-width)/2;
    CGFloat offset_y = CGRectGetHeight(self.bounds)-height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.moveLineLayer.frame = (CGRect){offset_x,offset_y,width,height};
        
    }];
    
    [self.lastBtn setTitleColor:self.defaultColor?:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setTitleColor:self.selectedColor?:[UIColor redColor] forState:UIControlStateNormal];
    self.lastBtn = btn;
    
    
}
- (void)setChangeIndex:(NSInteger)changeIndex{
    
    _changeIndex = changeIndex;
    
    UIButton * btn = (UIButton *)[self viewWithTag:changeIndex];
    
    self.isItemClick = NO;
    
    [self changeBtnState:btn];

}
- (void)clicked:(UIButton *)btn{
    
    self.isItemClick = YES;

    [self changeBtnState:btn];
}
- (void)changeBtnState:(UIButton *)btn{
    
    if (self.lastBtn == btn) { // 存在证明是点击触发
        
        return;
    }
    
    if (self.isItemClick) {
        
        if ([self.delegate respondsToSelector:@selector(chooseBarItemWithIndex:)]) {
            
            [self.delegate chooseBarItemWithIndex:btn.tag];
            
        }else{
            
            [self setMoveLineAnimationStatusWithBtn:btn];
        }
    }else{
        
        [self setMoveLineAnimationStatusWithBtn:btn];
    }
    
}


@end
