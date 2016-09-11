//
//  HKPOP.m
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "HKPOP.h"

@interface HKPOP ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL canTapToClose;
@property (nonatomic, assign )BOOL haveGrayBack;
@property (nonatomic, strong) UIView *displayedView;

@end

@implementation HKPOP

+ (instancetype)showView:(UIView *)view {
    static HKPOP *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance=[[self alloc]init];
    });
    [instance updateCanTapToClose:YES haveGrayBack:YES];
    instance.displayedView = view;
    return  instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0. alpha:.6];
        self.canTapToClose = YES;
        self.haveGrayBack = YES;
    }
    return self;
}

- (void)updateCanTapToClose:(BOOL)canTapToClose haveGrayBack:(BOOL)haveGrayBack {
    self.canTapToClose = canTapToClose;
    self.haveGrayBack = haveGrayBack;
}
#pragma mark - Setters & Getters

- (void)setDisplayedView:(UIView *)displayedView {
    if (_displayedView) {
        [_displayedView removeFromSuperview];
        _displayedView = nil;
    }
    _displayedView = displayedView;
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

- (void)setCanTapToClose:(BOOL)canTapToClose {
    _canTapToClose = canTapToClose;
    self.tap.enabled = _canTapToClose;
}

- (void)setHaveGrayBack:(BOOL)haveGrayBack {
    _haveGrayBack = haveGrayBack;
    if (!_haveGrayBack) {
        self.frame = self.displayedView.frame;
        self.backgroundColor = [UIColor clearColor];
        self.displayedView.frame = CGRectMake(0, 0, self.displayedView.frame.size.width, self.displayedView.frame.size.height);
    } else {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0. alpha:.6];
    }
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromSuperview)];
        _tap.delegate = self;
        [self addGestureRecognizer:_tap];
    }
    return _tap;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(self.displayedView.frame, currentPoint) ) {
        return NO;
    }
    return YES;
}

@end
