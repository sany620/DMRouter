//
//  UIButton+DuanMu.h
//  PPJiJin
//
//  Created by Quan on 16/6/5.
//  Copyright © 2016年 Sany. All rights reserved.
//
/*使用事例：[self.button setEnlargeEdgeWithTop:20 right:20 bottom:20 left:20];
 [self.button setOnClick:^{
 NSLog(@"fdfdfdfdf");
 }];
 *
 */
#import <UIKit/UIKit.h>

@interface UIButton (DuanMu)
/*扩大button的点击区域
 */
- (void)setEnlargeEdge:(CGFloat) size;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;

//添加一个button点击事件的block调用
-(void)setOnClick:(dispatch_block_t)block;
@end
