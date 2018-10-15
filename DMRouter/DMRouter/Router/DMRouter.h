//
//  DMRouter.h
//  PPJiJin
//
//  Created by duanmu on 2017/11/28.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMRouterHeader.h"
extern NSString* const DMRouterActionPush;
extern NSString* const DMRouterActionPresent;
extern NSString* const DMModuleScheme;

/**
 *   生成模块调用URL
 *
 *  @param module 模块名称
 *  @param action 打开模块的方式. Push或者Present
 *
 */
#define DMModule1(module)         ( [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@",DMModuleScheme,module,DMRouterActionPush]] )
#define DMModule2(module, action)  ( [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@/%@",DMModuleScheme,module,action]] )





typedef NSDictionary<NSString*, id> DMRouterOptions;

@interface DMRouter : NSObject

/**
 *  根据URL创建viewController
 *
 *  @param url     资源的地址, 参考 -(void)openURL:options:方法
 *  @param classname  跳转的VC-name
 *  @param options 对应的参数
 *
 *  @return nil表示无法创建UIViewController
 */
- (DMBaseViewController*)viewControllerForURL:(NSURL*)url  classname:(NSString *)classname  options:(DMRouterOptions*)options;

/**
 *  打开URL对应的页面
 *
 *  @param url     资源的地址
 *  @param options 对应的参数

 *  @note url 资源地址,目前支持以下几种schemem <br/>
 *
 *       - 网络资源: http, https, ftp等 <br/>
 *
 *       - 模块: module, 格式 module://<ModuleName>/action<br/>
 *
 *       - 其中action为push或者present
 *
 *  @note 每个模块必须提供下面模板方法
    @code
   /// 模块名称
   extern NSString*const <ModuleName>;
   /// Options Key的定义
   extern NSString*const KeyName1;
   extern NSString*const KeyName2;
   extern NSString*const KeyName3;
   /// 模块工厂
   @interface <ModuleName>Factory : NSObject
 + (TaurusBaseViewController*)viewControllerWithClass:(NSString *)className   WithOptions:(NSDictionary*)options;
   @end
   @endcode
 */
- (void)openURL:(NSURL*)url  className:(NSString *)classname options:(DMRouterOptions*)options;
@end
