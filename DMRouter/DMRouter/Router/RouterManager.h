//
//  RouterManager.h
//  Ocean
//
//  Created by duanmu on 2020/2/12.
//  Copyright © 2020 duanmu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMRouter.h"


NS_ASSUME_NONNULL_BEGIN

@interface RouterManager : NSObject


+(void)pushViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options;

+(void)presentViewClassName:(NSString *)classname options:(DMRouterOptions*_Nullable)options;

@end

NS_ASSUME_NONNULL_END
