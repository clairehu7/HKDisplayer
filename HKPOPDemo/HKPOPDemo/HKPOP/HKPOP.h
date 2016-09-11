//
//  HKPOP.h
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import <UIKit/UIKit.h>

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
@end

@interface HKPOPBackgroundView : UIView
@property (nonatomic, strong) UIColor *color;
@end