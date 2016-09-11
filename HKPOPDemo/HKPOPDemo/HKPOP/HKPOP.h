//
//  HKPOP.h
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HKPOPDisplayStyle) {
    //Keep display before use [HKPOP remove]
    HKPOPDisplayStyleKeep,
    //Remove by self after A while, set showTime to change time
    HKPOPDisplayStyleShowForAWhile
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

@property (nonatomic, assign) HKPOPDisplayStyle style;/**< Default is HKPOPDisplayStyleAWhile */

@property (nonatomic, assign) NSTimeInterval showTime;/**< default is 3 seconds*/

@end