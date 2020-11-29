//
//  UIImage+XMUIImage.h
//  XM
//
//  Created by Robin on 16/10/13.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMUIImage)

//裁剪图片的指定区域
- (UIImage *)getSubImage:(CGRect)rect;

//生成指定颜色的图片
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size;


//生成文字图片
+ (UIImage *)imageToAddText:(UIImage *)img withText:(NSString *)text attributeDic:(NSDictionary *)attributeDic textRect:(CGRect)textRect;

//添加子图片
+ (UIImage *)image:(UIImage *)img withSubImage:(UIImage *)subImage subImageRect:(CGRect)imageRect;

//简单裁剪
- (UIImage *)cutImageWithSize:(CGSize)size;

//简单裁剪图片并保证分辨率;
- (UIImage *)cutImageKeepScaleWithSize:(const CGSize)size;

//在指定尺寸内等比例裁剪并保证分辨率
- (UIImage *)scaleImageWithSize:(CGSize)size;

//裁剪指定圆角
- (UIImage *)imageWithRoundedCornersRadius:(float)cornerRadius byRoundingCorners:(UIRectCorner)corners;

//裁剪圆角
- (UIImage *)imageWithRoundedCornersRadius:(float)cornerRadius;

//切圆
- (UIImage *)circleImageWithInset:(CGFloat)inset;

//改变图片背景渲染颜色
- (UIImage *)maskWithColor:(UIColor *) color;

//生成二维码
+ (UIImage *)QRImage:(NSString *)URL sideLength:(CGFloat)length;


//生成二维码附带添加图
+ (UIImage *)QRImage:(NSString *)URL sideLength:(CGFloat)length InsertImage:(UIImage *)insertImage;

//生成二维码,自定义颜色
+ (UIImage *)QRImage:(NSString *)string andSize:(CGFloat)size andColor:(UIColor *)color;

+ (UIImage *)QRImage:(NSString *)URL sideLength:(CGFloat)length InsertImage:(UIImage *)insertImage rect:(CGRect)insertRect;

+ (UIColor *)mostColor:(UIImage*)image;
//*******************//
- (UIImage *)getCentralImage:(CGSize)size;

- (UIImage *)fixImage;

- (UIImage *)maskWithImage:(const UIImage *)maskImage;

+ (UIImage *)imageFromText:(NSArray*)arrContent withFont: (CGFloat)fontSize;

+ (UIImage *)xm_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end
