//
//  HKPOP.m
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "HKPOP.h"

@interface HKPOP ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *displayedView;
@property (nonatomic, weak) NSTimer *showTimer;

@end

@implementation HKPOP

#pragma mark - Life Cycle

- (instancetype)init {
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

+ (instancetype)shareManager {
    static HKPOP *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance=[[self alloc]init];
    });
    return instance;
}

+ (instancetype)showView:(UIView *)view {
    HKPOP *pop = [self shareManager];
    pop.displayedView = view;
    [pop commonInit];
    return pop;
}

- (void)commonInit {
    self.showTime = 3;
    self.displayStyle = HKPOPDisplayForAWhile;
}

+ (void)remove {
    HKPOP *pop = [self shareManager];
    [pop.displayedView removeFromSuperview];
    if (!pop.subviews.count) {
        [pop removeFromSuperview];
    }
}

//-(void)dealloc {
//    [self invalidTimer];
//}
//
//-(void)removeFromSuperview {
//    [super removeFromSuperview];
//    [self invalidTimer];
//}

#pragma mark - Timer

- (void)timerRepeat {
    self.showTime --;
    if (self.showTime <= 0) {
        [HKPOP remove];
        [self invalidTimer];
    }
}

- (void)invalidTimer {
    [self.showTimer invalidate];
    self.showTimer = nil;
}

#pragma mark - Animation

- (void)showWithAnimated:(HKPOPAnimationStyle)animated {
    
    //TODO:多种show方式（上浮/下沉/弹出/淡入淡出）
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_displayedView.layer addAnimation:animation forKey:nil];
}
#pragma mark - Setters & Getters

- (void)setShowTime:(NSTimeInterval)showTime {
    _showTime = showTime;
    [self showTimer];
}

- (NSTimer *)showTimer {
    if (!_showTimer) {
         NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerRepeat) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _showTimer = timer;
    }
    return _showTimer;
}

- (void)setDisplayedView:(UIView *)displayedView {
    if (_displayedView) {
        [_displayedView removeFromSuperview];
        _displayedView = nil;
    }
    _displayedView = displayedView;
    
    self.frame = _displayedView.frame;
    _displayedView.frame = (CGRect){0,0,_displayedView.frame.size};
    [self addSubview:_displayedView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self showWithAnimated:HKPOPAnimationStyleDefault];
}


- (void)setDisplayStyle:(HKPOPDisplay)displayStyle {
    _displayStyle = displayStyle;
    if (_displayStyle != HKPOPDisplayForAWhile) {
        [self invalidTimer];
    }
}

@end