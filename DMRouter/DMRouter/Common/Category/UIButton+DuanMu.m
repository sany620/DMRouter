//
//  UIButton+DuanMu.m
//  PPJiJin
//
//  Created by Quan on 16/6/5.
//  Copyright © 2016年 Sany. All rights reserved.
//

#import "UIButton+DuanMu.h"
#import <objc/runtime.h>
@implementation UIButton (DuanMu)
static char topNameKey;

static char rightNameKey;

static char bottomNameKey;

static char leftNameKey;
- (void)setEnlargeEdge:(CGFloat) size
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}



- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}



- (CGRect)enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }else{
        return self.bounds;
    }
    
}



- (UIView*)hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    
    CGRect rect = [self enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds)){
        
        return [super hitTest:point withEvent:event];
    }
    
    return CGRectContainsPoint(rect, point) ? self : nil;
    
}

#pragma MARK - Event
-(void)setOnClick:(dispatch_block_t)block{
    objc_setAssociatedObject(self, "touchUpInside", block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onClick:(id)sender{
    dispatch_block_t block = objc_getAssociatedObject(self, "touchUpInside");
    if (block) {
        block();
    }
}
@end
