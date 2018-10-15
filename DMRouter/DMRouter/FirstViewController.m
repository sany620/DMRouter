//
//  FirstViewController.m
//  DMRouter
//
//  Created by duanmu on 2018/10/15.
//  Copyright © 2018年 duanmu. All rights reserved.
//

#import "FirstViewController.h"
#import "DMSASRouter.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"First";
    self.view.backgroundColor = [UIColor redColor];
    
    // 创建push button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置frame
    button.frame = CGRectMake(0, 80, 80, 44);
    //设置背景颜色,状态
    button.backgroundColor = [UIColor greenColor];
    [button setTitle:@"Push" forState:UIControlStateNormal];
    [button setTitle:@"Push" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(pushEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // 创建Present button
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置frame
    presentButton.frame = CGRectMake(0, 150, 80, 44);
    //设置背景颜色,状态
    presentButton.backgroundColor = [UIColor greenColor];
    [presentButton setTitle:@"Present" forState:UIControlStateNormal];
    [presentButton setTitle:@"Present" forState:UIControlStateHighlighted];
    [presentButton addTarget:self action:@selector(presentEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:presentButton];
}
#pragma mark 按钮事件
- (void)pushEvent:(id)sender {
   [[DMSASRouter sharedDMSASRouter] openURL:DMModule1(DMPPJIJinModule)  className:@"SecondViewController" options:@{@"NavTitle":@"第二个页"}];
   
}
- (void)presentEvent:(id)sender
{
     [[DMSASRouter sharedDMSASRouter] openURL:DMModule2(DMPPJIJinModule, DMRouterActionPresent) className:@"ThreeViewController" options:nil];
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
