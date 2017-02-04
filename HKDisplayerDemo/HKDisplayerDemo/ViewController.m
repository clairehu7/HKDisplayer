//
//  ViewController.m
//  HKDisplayerDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "ViewController.h"
#import "HKDisplayer.h"

//Test views
#import "MsgView.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

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
- (void)test0 {
    MsgView *view = [[MsgView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    __weak ViewController *weakSelf = self;
    view.closeHandler = ^{
        __strong ViewController *strongSelf = weakSelf;
        [strongSelf test1];
    };
    HKDisplayer *displayer = [HKDisplayer showView:view animationStyle:HKDisplayerAnimationStyleDown];
    displayer.haveGrayBg = YES;
    displayer.cancleHandler = ^{
        NSLog(@"已移除");
    };
    displayer.displayStyle = HKDisplayerDisplayKeep;
}

- (void)test1 {
    [HKDisplayer removeAll];
}

- (void)test2 {
    UIView *view = [[UIView alloc]initWithFrame:(CGRect){0,0,300,20}];
    view.backgroundColor = [UIColor redColor];
    HKDisplayer *displayer = [HKDisplayer showView:view  animationStyle:HKDisplayerAnimationStyleUp];
    displayer.displayStyle = HKDisplayerDisplayKeep;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            [self test0];
            break;
        }
        case 1: {
            [self test1];
            break;
        }
        case 2: {
            [self test2];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

@end
