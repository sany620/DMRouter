//
//  UIImage+XMUIImage.m
//  XM
//
//  Created by Robin on 16/10/13.
//  Copyright © 2016年 Robin. All rights reserved.
//

#import "UIImage+XMUIImage.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CoreGraphics/CGDataProvider.h>

@implementation UIImage (XMUIImage)

#define CONTENT_MAX_WIDTH   300.0f



void getOrinetationFixTransform(UIImage *image, CGAffineTransform *T)
{
    UIImageOrientation orientation = image.imageOrientation;
    
    CGAffineTransform fixT = CGAffineTransformIdentity;
    
    switch (orientation) {
        case UIImageOrientationUp: // EXIF 1
            break;
        case UIImageOrientationDown: // EXIF 3
            fixT = CGAffineTransformRotate(fixT, M_PI);
            break;
        case UIImageOrientationLeft: // EXIF 6
            fixT = CGAffineTransformRotate(fixT, M_PI/2.0);
            break;
        case UIImageOrientationRight: // EXIF 8
            fixT = CGAffineTransformRotate(fixT, 3.0*M_PI/2.0);
            break;
        case UIImageOrientationUpMirrored: // EXIF 2
            fixT = CGAffineTransformScale(fixT, -1, 1);
            break;
        case UIImageOrientationDownMirrored: // EXIF 4
            fixT = CGAffineTransformScale(fixT, 1, -1);
            break;
        case UIImageOrientationLeftMirrored: // EXIF 5
            fixT = CGAffineTransformScale(fixT, -1, 1);
            fixT = CGAffineTransformRotate(fixT, 3.0*M_PI/2.0);
            break;
        case UIImageOrientationRightMirrored: // EXIF 7
            fixT = CGAffineTransformScale(fixT, -1, 1);
            fixT = CGAffineTransformRotate(fixT, M_PI/2.0);
            break;
    }
    
    *T = fixT;
}



+ (UIImage *)imageToAddText:(UIImage *)img withText:(NSString *)text attributeDic:(NSDictionary *)attributeDic textRect:(CGRect)textRect{
    
    //1.获取上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, [UIScreen mainScreen].scale);
    //2.绘制图片
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //3.绘制文字
    [text drawInRect:textRect withAttributes:attributeDic];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImg;
}

+ (UIImage *)image:(UIImage *)img withSubImage:(UIImage *)subImage subImageRect:(CGRect)imageRect{
    
    //1.获取上下文
    UIGraphicsBeginImageContextWithOptions(img.size, NO, [UIScreen mainScreen].scale);
    //2.绘制图片
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //3.绘制文字
    [subImage drawInRect:imageRect];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();
    
    return watermarkImg;
}



- (UIImage*)getSubImage:(CGRect)rect
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
    
}

+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, (CGRect){CGPointZero,size});
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)scaleImageWithSize:(CGSize)size{
    
    CGFloat heightScale = self.size.height / size.height;
    CGFloat widthScale = self.size.width / size.width;
    CGFloat scale = self.size.height / self.size.width;

    CGSize handledSize = heightScale < widthScale ? CGSizeMake(size.width, size.height *scale) : CGSizeMake(size.width *scale, size.height );
    
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, handledSize.width, handledSize.height);
    imageLayer.contents = (id) self.CGImage;
    
    imageLayer.masksToBounds = YES;
    UIGraphicsBeginImageContextWithOptions(handledSize, NO, [UIScreen mainScreen].scale);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *handledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return handledImage;
}

//根据图片获取图片的主色调
+ (UIColor*)mostColor:(UIImage*)image{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(image.size.width/2, image.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}


- (UIImage *)cutImageWithSize:(CGSize)size
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, size.width, size.height);
    imageLayer.contents = (id) self.CGImage;
    
    imageLayer.masksToBounds = YES;
    
    UIGraphicsBeginImageContext(size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}



+ (UIImage *)QRImage:(NSString *)URL sideLength:(CGFloat)length{
    
  return [[self class] QRImage:URL sideLength:length InsertImage:nil rect:CGRectNull];
}

+ (UIImage *)QRImage:(NSString *)URL sideLength:(CGFloat)length InsertImage:(UIImage *)insertImage{
    
    return [[self class] QRImage:URL sideLength:length InsertImage:insertImage rect:CGRectNull];
}

+ (UIImage *)QRImage:(NSString *)URL sideLength:(CGFloat)length InsertImage:(UIImage *)insertImage rect:(CGRect)insertRect{
    
    NSData * stringData = [URL dataUsingEncoding: NSUTF8StringEncoding];
    
    CIFilter * qrFilter = [CIFilter filterWithName: @"CIQRCodeGenerator"];
    [qrFilter setValue: stringData forKey: @"inputMessage"];
    [qrFilter setValue: @"H" forKey: @"inputCorrectionLevel"];
    
    UIImage *QR =  [UIImage excludeFuzzyImageFromCIImage:qrFilter.outputImage size:length];
    if (!insertImage) {
        return QR;
    }else{
        return [QR insertImage:insertImage insertRect:insertRect];
    }
}

- (UIImage *)insertImage:(UIImage *)insertImage insertRect:(CGRect)insertRect{
    
    CGRect defualtRect = CGRectInset((CGRect){0, 0 ,(self.size)}, self.size.width * 0.7 / 2, self.size.height * 0.7 / 2);
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:(CGRect){0, 0 ,(self.size)}];
    [insertImage drawInRect:CGRectIsNull(insertRect)? defualtRect :insertRect blendMode:kCGBlendModeNormal alpha:1];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)excludeFuzzyImageFromCIImage:(CIImage *)image size: (CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    //创建灰度色调空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext * context = [CIContext contextWithOptions: nil];
    CGImageRef bitmapImage = [context createCGImage: image fromRect: extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    
    UIImage *resultImage = [UIImage imageWithCGImage: scaledImage];
    CGImageRelease(scaledImage);
    
    return resultImage;
}

// Render a UIImage at the specified size. This is needed to render out the resizable image mask before sending it to maskImage:withMask:
- (UIImage *)cutImageKeepScaleWithSize:(const CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size,NO,[UIScreen mainScreen].scale);
    const CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    const CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *renderedImage = [UIImage imageWithCGImage:cgImage];
    
    CGImageRelease(cgImage);
    UIGraphicsEndImageContext();
    
    return renderedImage;
}
//图片上切圆
- (UIImage *)imageWithRoundedCornersRadius:(float)cornerRadius byRoundingCorners:(UIRectCorner)corners
{
    CGRect frame = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1.0);
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)] addClip];
    // Draw your image
    [self drawInRect:frame];
    // Retrieve and return the new image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageWithRoundedCornersRadius:(float)cornerRadius
{
    CGRect frame = CGRectMake(0, 0, self.size.width, self.size.height);
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // Draw your image
    [self drawInRect:frame];
    // Retrieve and return the new image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
 maskWithColor
 takes a (grayscale) image and 'tints' it with the supplied color.
 */
- (UIImage *) maskWithColor:(UIColor *) color
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, self.CGImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef cImage = CGBitmapContextCreateImage(bitmapContext);
    UIImage *coloredImage = [UIImage imageWithCGImage:cImage];
    
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(cImage);
    
    return coloredImage;
    
}

- (UIImage *)circleImageWithInset:(CGFloat)inset
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(0, 0, self.size.width - inset*2.f, self.size.height - inset*2.f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [self drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;
}

- (UIImage*)fixImage
{
    CGSize imageSize = self.size;
    
    CGImageRef cgImage = [self CGImage];
    CGFloat cgWidth = CGImageGetWidth(cgImage);
    CGFloat cgHeight = CGImageGetHeight(cgImage);
    
    UIGraphicsBeginImageContext(imageSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(ctx, 0.3, 0, 0, 1.0);
    CGContextFillRect(ctx, CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    CGAffineTransform T = CGAffineTransformIdentity;
    CGAffineTransform reorientT = CGAffineTransformMakeRotation(M_PI/12.0);
    
    getOrinetationFixTransform(self, &reorientT);
    
    T = CGAffineTransformConcat(T, CGAffineTransformMakeTranslation(-cgWidth*0.5, -cgHeight*0.5) );
    T = CGAffineTransformConcat(T, reorientT);
    T = CGAffineTransformConcat(T, CGAffineTransformMakeScale(1, -1));
    T = CGAffineTransformConcat(T, CGAffineTransformMakeTranslation(imageSize.width*0.5, imageSize.height*0.5));
    
    CGContextConcatCTM(ctx, T);
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, cgWidth, cgHeight), cgImage);
    
    UIImage *fixed = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return fixed;
}


- (UIImage *)maskWithImage:(const UIImage *)maskImage{
    
    const CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    const CGImageRef maskImageRef = maskImage.CGImage;
    
    const CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    if (! mainViewContentContext)
    {
        return nil;
    }
    
    CGFloat ratio = maskImage.size.width / self.size.width;
    
    if (ratio * self.size.height < maskImage.size.height)
    {
        ratio = maskImage.size.height / self.size.height;
    }
    
    const CGRect maskRect  = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    
    const CGRect imageRect  = CGRectMake(-((self.size.width * ratio) - maskImage.size.width) / 2,
                                         -((self.size.height * ratio) - maskImage.size.height) / 2,
                                         self.size.width * ratio,
                                         self.size.height * ratio);
    
    CGContextClipToMask(mainViewContentContext, maskRect, maskImageRef);
    CGContextDrawImage(mainViewContentContext, imageRect, self.CGImage);
    
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    CGImageRelease(newImage);
    
    return theImage;
    
}


+ (UIImage *)xm_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle {
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
#else
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
    }
#endif
}


//******************* 2014.09.01 *****************************


+(UIImage *)imageFromText:(NSArray*)arrContent withFont: (CGFloat)fontSize
{
    // set the font type and size
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableArray *arrHeight = [[NSMutableArray alloc] initWithCapacity:arrContent.count];
    
    CGFloat fHeight = 0.0f;
    for (NSString *sContent in arrContent) {
        CGSize stringSize = [sContent boundingRectWithSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        [arrHeight addObject:[NSNumber numberWithFloat:stringSize.height]];
        
        fHeight += stringSize.height;
    }
    
    
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetCharacterSpacing(ctx, 10);
    //  CGContextSetTextDrawingMode (ctx, kCGTextFillStroke);
    CGContextSetRGBFillColor (ctx, 0.1, 0.2, 0.3, 1); // 6
    CGContextSetRGBStrokeColor (ctx, 0, 0, 0, 1);
    
    int nIndex = 0;
    CGFloat fPosY = 20.0f;
    for (NSString *sContent in arrContent) {
        NSNumber *numHeight = [arrHeight objectAtIndex:nIndex];
        CGRect rect = CGRectMake(10, fPosY, CONTENT_MAX_WIDTH , [numHeight floatValue]);
        
        [sContent drawInRect:rect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        fPosY += [numHeight floatValue];
        nIndex++;
    }
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage*)getCentralImage:(CGSize)size{
    
    float w = 0;
    float h = 0;
    float x = 0;
    float y = 0;
    
    if (size.width > self.size.width*self.scale) {
        
        w = self.size.width*self.scale;
    }
    else
    {
        w = size.width;
    }
    
    if (size.height > self.size.height*self.scale) {
        
        h = self.size.height*self.scale;
    }
    else
    {
        h = size.height;
    }
    
    x = (self.size.width*self.scale - size.width)/2.0;
    y = (self.size.height*self.scale - size.height)/2.0;
    
    CGRect rect = CGRectMake(x, y, w, h);
    return [self getSubImage:rect];
}

@end
