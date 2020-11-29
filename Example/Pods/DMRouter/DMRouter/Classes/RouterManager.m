//
//  RouterManager.m
//  Ocean
//
//  Created by duanmu on 2020/2/12.
//  Copyright © 2020 duanmu. All rights reserved.
//

#import "RouterManager.h"
#import "DMSASRouter.h"
#import "DMPPJIJinModuleFactory.h"

@implementation RouterManager

+(void)pushViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options{
   [[DMSASRouter manager] openURL:DMModule1(DMPPJIJinModule)  className:classname options:options];
}
+(void)pushViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options completion:(__nullable RouterHandleCallBack)completion{
    [[DMSASRouter manager] openURL:DMModule1(DMPPJIJinModule) className:classname options:options completion:completion];
}

+(void)presentViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options{
    [[DMSASRouter manager] openURL:DMModule2(DMPPJIJinModule, DMRouterActionPresent) className:classname options:options];
}

+(void)presentViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options completion:(__nullable RouterHandleCallBack)completion{
    [[DMSASRouter manager] openURL:DMModule2(DMPPJIJinModule, DMRouterActionPresent) className:classname options:options completion:completion];
}

@end
