//
//  ViewController.m
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "ViewController.h"
#import "HKPOP.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HKTest
- (IBAction)test1TUI:(UIButton *)sender {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    view.backgroundColor = [UIColor whiteColor];
    [HKPOP showView:view];
}

- (IBAction)test2TUI:(UIButton *)sender {
    
}

-(UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
