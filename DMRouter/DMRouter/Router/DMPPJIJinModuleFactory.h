//
//  DMPPJIJinModuleFactory.h
//  ChainLink
//
//  Created by duanmu on 2017/12/4.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMRouterHeader.h"

extern NSString* const DMPPJIJinModule;

@interface DMPPJIJinModuleFactory : NSObject

/**
 *  创建模块入口
 *   @param className  VC的name
 *  @param options 创建模块需要的参数
 *
 *  @return nil表示无法创建模块入口
 */
+ (DMBaseViewController*)viewControllerWithClass:(NSString *)className WithOptions:(NSDictionary*)options;

@end
