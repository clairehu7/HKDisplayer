//
//  HKDisplayer.h
//  HKDisplayerDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HKDisplayerDisplay) {
    //Remove by self after a while, set showTime to change time
    HKDisplayerDisplayDefault,
    //Keep display before use [HKDisplayer remove]
    HKDisplayerDisplayKeep,
};

typedef NS_ENUM(NSInteger, HKDisplayerAnimationStyle) {
    HKDisplayerAnimationStyleNone = -1,
    HKDisplayerAnimationStyleDefault,
    HKDisplayerAnimationStyleUp,
    HKDisplayerAnimationStyleDown
};

@interface HKDisplayer : UIView

/**
 *  create a new displayer
 *
 *  @param view The view you want to show
 *
 *  @return the created displayer
 */
+ (instancetype)showView:(UIView *)view;

+ (instancetype)showView:(UIView *)view animationStyle:(HKDisplayerAnimationStyle)style;

/**
 *  Remove all displayers
 */
+ (void)removeAll;

@property (nonatomic, assign) HKDisplayerDisplay displayStyle;

@property (nonatomic, assign) NSTimeInterval showTime;/**< default is 3 seconds*/

@property (nonatomic, assign) BOOL haveGrayBg;/**< default is NO*/

@property (nonatomic, copy) dispatch_block_t cancelHandler;/**< with GrayBg*/

@end
