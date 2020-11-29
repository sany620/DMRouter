//
//  RouterManager.h
//  Ocean
//
//  Created by duanmu on 2020/2/12.
//  Copyright © 2020 duanmu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMRouter.h"
#import "DMToolsMacros.h"


NS_ASSUME_NONNULL_BEGIN

@interface RouterManager : NSObject


/// push方法
/// @param classname vc string name
/// @param options 参数
+(void)pushViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options;

/// push方法，带回调
/// @param classname vc string name
/// @param options 参数
/// @param completion 回调
+(void)pushViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options completion:(__nullable RouterHandleCallBack)completion;

/// present方法
/// @param classname vc string name
/// @param options  参数
+(void)presentViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options;

/// present方法，带回调
/// @param classname vc string name
/// @param options  参数
/// @param completion 回调
+(void)presentViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options completion:(__nullable RouterHandleCallBack)completion;

@end

NS_ASSUME_NONNULL_END
