//
//  UIBarButtonItem+Items.m
//  PPJiJin
//
//  Created by apple on 2017/2/10.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import "UIBarButtonItem+Items.h"
#import "UIView+Frame.h"
#import "UIButton+DuanMu.h"
@implementation UIBarButtonItem (Items)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
     button.frame = CGRectMake(0, 42, 52, 42);
    // 监听按钮点击;
    [button setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(UIBarButtonItem *)itemWithTitle:(NSString *)title textColor:(UIColor *)textColor target:(id)target action:(SEL)action
{
    UIButton*_rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    [_rightButton setTitle:title forState:UIControlStateNormal];
    [_rightButton setTitleColor:textColor forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [_rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
}
+(UIBarButtonItem *)itemWithTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font target:(id)target action:(SEL)action{
    
    UIButton*_rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    [_rightButton setTitle:title forState:UIControlStateNormal];
    [_rightButton setTitleColor:textColor forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:font?:[UIFont systemFontOfSize:15.0]];
    [_rightButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
}
@end
