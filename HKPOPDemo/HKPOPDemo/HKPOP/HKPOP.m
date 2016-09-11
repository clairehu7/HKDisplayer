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
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, assign) BOOL haveCloseBtn;
@property (nonatomic, assign) BOOL canTapToClose;
@property (nonatomic, assign )BOOL haveGrayBack;
@end

@implementation HKPOP
+(HKPOP*)shareManager {
    static HKPOP *instance=nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance=[[self alloc]init];
    });
    instance.canTapToClose = YES;
    instance.haveCloseBtn = YES;
    instance.haveGrayBack = YES;
    return  instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0. alpha:.6];
        self.canTapToClose = YES;
        self.haveCloseBtn = YES;
        self.haveGrayBack = YES;
    }
    return self;
}

- (void)updateCanTapToClose:(BOOL)canTapToClose haveCloseBtn:(BOOL)haveCloseBtn haveGrayBack:(BOOL)haveGrayBack {
    self.canTapToClose = canTapToClose;
    self.haveCloseBtn = haveCloseBtn;
    self.haveGrayBack = haveGrayBack;
}
#pragma mark - Setters & Getters

- (void)setCenterView:(UIView *)centerView {
    if (_centerView) {
        [_centerView removeFromSuperview];
        _centerView = nil;
    }
    _centerView = centerView;
    [self addSubview:_centerView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _centerView.center = self.center;
    [_centerView addSubview:self.closeBtn];
    self.closeBtn.center = CGPointMake( _centerView.frame.size.width - 15, 15);
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.2;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.4, 0.4, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_centerView.layer addAnimation:animation forKey:nil];
    
    [self updateUI];
}

- (void)setCanTapToClose:(BOOL)canTapToClose {
    _canTapToClose = canTapToClose;
    self.tap.enabled = _canTapToClose;
}

- (void)setHaveCloseBtn:(BOOL)haveCloseBtn {
    _haveCloseBtn = haveCloseBtn;
    self.closeBtn.hidden = !_haveCloseBtn;
}

- (void)setHaveGrayBack:(BOOL)haveGrayBack {
    _haveGrayBack = haveGrayBack;
    if (!_haveGrayBack) {
        self.frame = self.centerView.frame;
        self.backgroundColor = [UIColor clearColor];
        self.centerView.frame = CGRectMake(0, 0, self.centerView.frame.size.width, self.centerView.frame.size.height);
    } else {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0. alpha:.6];
    }
    [self updateUI];
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromSuperview)];
        _tap.delegate = self;
        [self addGestureRecognizer:_tap];
    }
    return _tap;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
        [_closeBtn setImage:[UIImage imageNamed:@"icon_x"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.hidden = YES;
    }
    return _closeBtn;
}

- (void)updateUI {
    self.closeBtn.hidden = !self.haveCloseBtn;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint currentPoint = [gestureRecognizer locationInView:self];
    if (CGRectContainsPoint(self.centerView.frame, currentPoint) ) {
        return NO;
    }
    return YES;
}

@end
