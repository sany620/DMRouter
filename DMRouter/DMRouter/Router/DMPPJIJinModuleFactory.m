//
//  DMPPJIJinModuleFactory.m
//  ChainLink
//
//  Created by duanmu on 2017/12/4.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import "DMPPJIJinModuleFactory.h"
NSString* const DMPPJIJinModule = @"DMPPJIJinModule";

@implementation DMPPJIJinModuleFactory
+ (DMBaseViewController*)viewControllerWithClass:(NSString *)className   WithOptions:(NSDictionary*)options
{
    Class viewControllerClass=NSClassFromString(className);
    DMBaseViewController *viewController = [[viewControllerClass alloc] init];
    if([viewController isKindOfClass:[DMBaseViewController class]] && viewController!=nil){
        viewController.argDict = options;
    }
    return viewController;
}
@end
