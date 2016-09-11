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
@end

@implementation HKPOP

+ (void)remove {
    HKPOP *pop = [self shareManager];
    [pop removeFromSuperview];
}

+ (instancetype)showView:(UIView *)view {
    HKPOP *pop = [self shareManager];
    pop.displayedView = view;
    return  pop;
}

+ (instancetype)shareManager {
    static HKPOP *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance=[[self alloc]init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}

#pragma mark - Setters & Getters

- (void)setDisplayedView:(UIView *)displayedView {
    if (_displayedView) {
        [_displayedView removeFromSuperview];
        _displayedView = nil;
    }
    _displayedView = displayedView;
    
    self.frame = _displayedView.frame;
    _displayedView.frame = CGRectMake(0, 0, _displayedView.frame.size.width, _displayedView.frame.size.height);
    [self addSubview:_displayedView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_displayedView.layer addAnimation:animation forKey:nil];
}

@end

@implementation HKPOPBackgroundView

- (void)setColor:(UIColor *)color {
    _color = color;
    self.backgroundColor = color;
}
@end