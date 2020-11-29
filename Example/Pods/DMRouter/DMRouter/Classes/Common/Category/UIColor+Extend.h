//
//  UIColor+Extend.h
//  Wifi
//
//  Created by muxi on 14/11/19.
//  Copyright (c) 2014年 muxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)
/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)stringToConvert;


/**
 *  十六进制颜色 透明度
 */
+ (UIColor *)colorWithHexColorString:(NSString *)stringToConvert andAlpha:(CGFloat )alp;

@end
