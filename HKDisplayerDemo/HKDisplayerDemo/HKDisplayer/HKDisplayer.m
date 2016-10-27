//
//  HKDisplayer.m
//  HKDisplayerDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "HKDisplayer.h"

@interface HKDisplayerManager : NSObject

@property (nonatomic, strong) NSMutableArray<HKDisplayer *> *showDisplayers;
+ (instancetype)shareManager;

@end

@implementation HKDisplayerManager

+ (instancetype)shareManager {
    static HKDisplayerManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc]init];
        instance.showDisplayers = [NSMutableArray array];
    });
    return instance;
}

@end

@interface HKDisplayer ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *displayedView;
@property (nonatomic, weak) NSTimer *showTimer;
@property (nonatomic, assign) BOOL keepOthers;
@property (nonatomic, assign) HKDisplayerAnimationStyle animationStyle;
@property (nonatomic, strong) UIButton *bgBtn;
@end

@implementation HKDisplayer

#pragma mark - Life Cycle

- (instancetype)init {
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

+ (instancetype)showView:(UIView *)view animationStyle:(HKDisplayerAnimationStyle)style {
    HKDisplayer *displayer = [[self alloc]init];
    [[HKDisplayerManager shareManager].showDisplayers addObject:displayer];
    displayer.animationStyle = style;
    displayer.displayedView = view;
    [displayer commonInit];
    return displayer;
}

+ (instancetype)showView:(UIView *)view {
    return [self showView:view animationStyle:HKDisplayerAnimationStyleDefault];
}

- (void)commonInit {
    self.displayStyle = HKDisplayerDisplayDefault;
    self.showTime = 3;
    self.keepOthers = NO;
    self.haveGrayBg = YES;
}

- (void)remove {
    [self removeFromSuperview];
    [_bgBtn removeFromSuperview];
    [[HKDisplayerManager shareManager].showDisplayers removeObject:self];
}

+ (void)removeAll {
//    HKDisplayer *pop = [self shareManager];
//    [pop removeFromSuperview];
    
//    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
//        if ([view isKindOfClass:self]) {
//            [view removeFromSuperview];
//        }
//    }
    
    for (HKDisplayer *displayer in [HKDisplayerManager shareManager].showDisplayers) {
        [displayer removeFromSuperview];
    }
    [[HKDisplayerManager shareManager].showDisplayers removeAllObjects];
}

- (void)removeSubViews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
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

//- (void)addDisplayedView:(UIView *)view keepOthers:(BOOL)keep {
//    self.keepOthers = keep;
//    self.displayedView = view;
//}

#pragma mark - Timer

- (void)timerRepeat {
    self.showTime --;
    if (self.showTime <= 0) {
        [self remove];
        [self invalidTimer];
    }
}

- (void)invalidTimer {
    [self.showTimer invalidate];
    self.showTimer = nil;
}

#pragma mark - Animation

- (void)showWithAnimated {
    
    switch (self.animationStyle) {
        case HKDisplayerAnimationStyleNone: {
            return;
            break;
        }
        case HKDisplayerAnimationStyleDefault: {
            [self defaultAnimation];
            break;
        }
        case HKDisplayerAnimationStyleUp: {
            [self positionAnimationOffset:CGPointMake(0, 20)];
            break;
        }
        case HKDisplayerAnimationStyleDown: {
            [self positionAnimationOffset:CGPointMake(0, -20)];
            break;
        }
    }
}

- (void)defaultAnimation {
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    [_displayedView.layer addAnimation:animation forKey:nil];
}

- (void)positionAnimationOffset:(CGPoint)offset {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    CGRect rect = [self convertRect:_displayedView.frame toView:self.superview];
    CGPoint toPoint = CGPointMake(rect.size.width /2, rect.size.height /2);
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(toPoint.x + offset.x, toPoint.y + offset.y)];
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    
    animation.duration = 0.3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
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
    if (_displayedView && !self.keepOthers) {
        [_displayedView removeFromSuperview];
        _displayedView = nil;
    }
    _displayedView = displayedView;
    
    self.frame = _displayedView.frame;
    _displayedView.frame = (CGRect){0,0,_displayedView.frame.size};
    [self addSubview:_displayedView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self showWithAnimated];
}

- (void)setDisplayStyle:(HKDisplayerDisplay)displayStyle {
    _displayStyle = displayStyle;
    if (_displayStyle == HKDisplayerDisplayKeep) {
        [self invalidTimer];
    }
}

- (void)setHaveGrayBg:(BOOL)haveGrayBg {
    _haveGrayBg = haveGrayBg;
    if (_haveGrayBg) {
        [self bgBtn];
    } else {
        [_bgBtn removeFromSuperview];
    }
}

- (UIButton *)bgBtn {
    if (!_bgBtn) {
        _bgBtn = [[UIButton alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        _bgBtn.backgroundColor = [UIColor colorWithWhite:.2 alpha:.7];
        [_bgBtn addTarget:self action:@selector(remove) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:_bgBtn];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    }
    return _bgBtn;
}

@end
