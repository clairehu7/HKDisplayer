//
//  UIColor+Extends.m
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/12.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "UIColor+Extends.h"

@implementation UIColor (Extends)

+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
