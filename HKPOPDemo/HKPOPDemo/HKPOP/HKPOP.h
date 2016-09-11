//
//  HKPOP.h
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKPOP : UIView

+(HKPOP *)shareManager;
@property (nonatomic, strong) UIView *centerView;/**<需要显示的 View*/
- (void)updateCanTapToClose:(BOOL)canTapToClose haveCloseBtn:(BOOL)haveCloseBtn haveGrayBack:(BOOL)haveGrayBack;

@end
