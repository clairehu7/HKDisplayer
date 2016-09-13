//
//  ViewController.m
//  HKPOPDemo
//
//  Created by hukaiyin on 16/9/11.
//  Copyright © 2016年 HKY. All rights reserved.
//

#import "ViewController.h"
#import "HKPOP.h"
#import "UIColor+Extends.h"

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
- (void)test0{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
    view.center = [UIApplication sharedApplication].keyWindow.center;
    view.backgroundColor = [UIColor randomColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(150, 0, 50, 50)];
    [btn addTarget:self action:@selector(test1) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"icon_x"] forState:UIControlStateNormal];
    [view addSubview: btn];
    
//    HKPOP *pop = [HKPOP showView:view];
    
    [HKPOP showView:view];
}

- (void)test1{
    [HKPOP remove];
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
