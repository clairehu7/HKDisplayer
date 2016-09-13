//
//  HKPOP.h
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HKPOPAnimationStyle) {
    HKPOPAnimationStyleNone = -1,
    HKPOPAnimationStyleDefault,
//    HKPOPAnimationStyle
};

typedef NS_ENUM(NSInteger, HKPOPDisplay) {
    //Keep display before use [HKPOP remove]
    HKPOPDisplayKeep,
    //Remove by self after A while, set showTime to change time
    HKPOPDisplayForAWhile
};

@interface HKPOP : UIView

/**
 *  creates a new POP
 *
 *  @param view The view you want to show
 *
 *  @return the created POP
 */
+ (instancetype)showView:(UIView *)view;

/**
 *  Remove self
 */
+ (void)remove;

@property (nonatomic, assign) HKPOPDisplay displayStyle;/**< Default is HKPOPDisplayForAWhile */

@property (nonatomic, assign) NSTimeInterval showTime;/**< default is 3 seconds*/

@end