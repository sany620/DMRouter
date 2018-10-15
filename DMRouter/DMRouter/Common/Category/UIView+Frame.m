//
//  UIView+Frame.m
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
-(void)setXx:(CGFloat)xx
{
    CGRect frame = self.frame;
    frame.origin.x = xx;
    self.frame = frame;
}


- (CGFloat)xx
{
    return self.frame.origin.x;
}

- (void)setYy:(CGFloat)yy
{
    CGRect frame = self.frame;
    frame.origin.y = yy;
    self.frame = frame;
}

- (CGFloat)yy
{
    return self.frame.origin.y;
}

- (void)setCenterXX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerXX
{
    return self.center.x;
}

- (void)setCenterYY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerYY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}
-(CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

-(void)setMaxX:(CGFloat)maxX
{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

-(void)setMaxY:(CGFloat)maxY
{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}
@end
