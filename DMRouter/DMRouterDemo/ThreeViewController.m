//
//  ThreeViewController.m
//  DMRouter
//
//  Created by duanmu on 2018/10/15.
//  Copyright © 2018年 duanmu. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // 创建button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置frame
    button.frame = CGRectMake(0, 80, 80, 44);
    //设置背景颜色,状态
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button setTitle:@"dismiss" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(dismissEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

-(void)dismissEvent:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
