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
    //    HKDisplayerAnimationStyle
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

/**
 *  Remove all displayers
 */
+ (void)removeAll;

@property (nonatomic, assign) HKDisplayerDisplay displayStyle;

@property (nonatomic, assign) HKDisplayerAnimationStyle animationStyle;

@property (nonatomic, assign) NSTimeInterval showTime;/**< default is 3 seconds*/

@end