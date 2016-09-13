//
//  MsgView.h
//  HKDisplayerDemo
//
//  Created by hukaiyin on 16/9/13.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgView : UIView
@property (nonatomic, copy) dispatch_block_t closeHandler;
@end
