//
//  MsgView.m
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/13.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "MsgView.h"

@interface MsgView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

#define LABELSIZE CGSizeMake(self.frame.size.width - 20, 21)

@implementation MsgView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, 190, 90)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
 
    self.titleLabel.text = @"Surprise";
    self.tipsLabel.text = @"+100";
    self.contentLabel.text = @"you have 5000 points now";
}

- (void)close {
    !_closeHandler?[self removeFromSuperview]:_closeHandler();
}

#pragma mark - Setters & Getters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:(CGRect){10,10,LABELSIZE}];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc]initWithFrame:(CGRect){10,self.titleLabel.frame.origin.y + LABELSIZE.height + 5,LABELSIZE}];
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont boldSystemFontOfSize:20.];
        _tipsLabel.textColor = [UIColor colorWithRed:1.000 green:0.808 blue:0.149 alpha:1.000];
        _tipsLabel.center = self.center;
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]initWithFrame:(CGRect){10,self.frame.size.height - 10 - LABELSIZE.height,LABELSIZE}];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:12.f];
        _contentLabel.textColor = [UIColor whiteColor];
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}
@end
