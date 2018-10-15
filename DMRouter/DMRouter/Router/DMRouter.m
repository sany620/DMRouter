//
//  DMRouter.m
//  PPJiJin
//
//  Created by duanmu on 2017/11/28.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import "DMRouter.h"
#import "NSObject+Cast.h"
#import "UIView+YYAdd.h"
#import "DMNavigationController.h"

NSString* const DMRouterActionPush    = @"push";
NSString* const DMRouterActionPresent = @"present";
NSString* const DMModuleScheme        = @"module";

@implementation DMRouter
/// 广度优先搜索特殊类
+ (UIView*)BFSSearchView:(Class)clazz inView:(UIView*)root {
    if (!root) {
        return nil;
    }
    UIView         *result = nil;
    NSMutableArray *queue  = [NSMutableArray arrayWithCapacity:0x10];
    UIView         *node   = nil;
    /// push
    [queue addObject:root];
    while (queue.count != 0) {
        /// pop
        node = [queue lastObject];
        [queue removeLastObject];

        /// check
        if ([node isKindOfClass:clazz]) {
            result = node;
            break;
        }

        /// trans all
        [queue addObjectsFromArray:node.subviews];
    }
    return result;
}

+ (DMNavigationController*)findTopmostNavigationController:(UIWindow*)window {
    UIView *expectView      = nil;
    Class   expectViewClass = NSClassFromString(@"UINavigationTransitionView");
    expectView = [self BFSSearchView:expectViewClass inView:window];
    DMNavigationController *navi = [DMNavigationController cast:[expectView viewController]];
    return navi;
}

+ (DMNavigationController*)findTopmostNavigationController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;

    return [self findTopmostNavigationController:window];
}

+ (void)push:(UIViewController*)controller animated:(BOOL)animated {
    DMNavigationController *navi = [self findTopmostNavigationController];
    [navi pushViewController:controller animated:animated];
}


+ (void)pop:(UIViewController*)controller animated:(BOOL)animated {
    DMNavigationController *navi  = [self findTopmostNavigationController];
    UIViewController       *poped = [navi popViewControllerAnimated:animated];
    NSLog(@"----:%@",poped);
}

+ (void)present:(DMBaseViewController*)controller animated:(BOOL)animated {
    UIWindow   *window  = [UIApplication sharedApplication].delegate.window;
    DMBaseViewController *rootViewController = (DMBaseViewController *)window.rootViewController;
    if (rootViewController) {
        [rootViewController presentViewController:controller animated:animated completion:nil];
    } else {

        NSLog(@"rootViewController is nil");
    }
}

+ (void)dismiss:(UIViewController*)controller animated:(BOOL)animated {
}

- (DMBaseViewController*)viewControllerForURL:(NSURL*)url  classname:(NSString *)classname  options:(DMRouterOptions*)options {

    NSString*scheme = url.scheme;
    if (![scheme isEqualToString:DMModuleScheme]) {
        return nil;
    }

    NSString *moduleName = url.host;
    NSString *factoryClassName =  [NSString stringWithFormat:@"%@Factory",moduleName];
    Class     factoryClass     = NSClassFromString(factoryClassName);
    if (!factoryClass) {
        NSLog(@"类: %@不存在",factoryClassName);
        return nil;
    }

    SEL selector = NSSelectorFromString(@"viewControllerWithClass:WithOptions:");
    if (!selector) {
        NSLog(@"方法: viewControllerWithClass:WithOptions:不存在");
        return nil;
    }

    if ([factoryClass respondsToSelector:selector]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        DMBaseViewController*controller = [[factoryClass class] performSelector:selector withObject:classname withObject:options];
        #pragma clang diagnostic pop
        return controller;
    } else {
        NSLog(@"%@ 未实现+ (TaurusBaseViewController*)viewControllerWithClass:(NSString *)className   WithOptions:(NSDictionary*)options 方法", factoryClass);
    }
    return nil;
}

- (void)openURL:(NSURL*)url  className:(NSString *)classname options:(DMRouterOptions*)options;{
    NSString*scheme = url.scheme;
    if ([scheme isEqualToString:DMModuleScheme]) {
        DMBaseViewController*controller = (DMBaseViewController *) [self viewControllerForURL:url  classname:classname  options:options];
        NSString  *action     = url.path;
        if ([action isEqualToString:@"/push"]) {
            [[self class] push:controller animated:YES];
        } else if ([action isEqualToString:@"/present"]) {
            [[self class] present:controller animated:YES];
        } else {
            NSLog(@"unsupport action: %@", action);
        }
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
