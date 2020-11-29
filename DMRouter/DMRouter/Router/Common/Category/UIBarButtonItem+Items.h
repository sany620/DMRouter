//
//  UIBarButtonItem+Items.h
//  PPJiJin
//
//  Created by apple on 2017/2/10.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Items)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;


+(UIBarButtonItem *)itemWithTitle:(NSString *)title textColor:(UIColor *)textColor target:(id)target action:(SEL)action;



+(UIBarButtonItem *)itemWithTitle:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font target:(id)target action:(SEL)action;

@end
