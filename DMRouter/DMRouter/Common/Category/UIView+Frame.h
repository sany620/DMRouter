//
//  UIView+Frame.h
//  RMTiOSApp
//
//  Created by Jason on 2016/11/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat xx;
@property (nonatomic, assign) CGFloat yy;
@property (nonatomic, assign) CGFloat centerXX;
@property (nonatomic, assign) CGFloat centerYY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic,assign) CGFloat maxY;
@property (nonatomic,assign) CGFloat maxX;
@end
