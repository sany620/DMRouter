//
//  NSObject+Cast.m
//  PPJiJin
//
//  Created by duanmu on 2017/11/28.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import "NSObject+Cast.h"

@implementation NSObject (Cast)
+ (instancetype)cast:(id)object {
    if (!object) {
        return nil;
    }

    if ([object isKindOfClass:self]) {
        return object;
    } else {
        NSLog(@"类型转换失败. 无法将%@转换为%@", NSStringFromClass([object class]), NSStringFromClass(self));
    }

    return nil;
}

+ (BOOL)has:(id)object {
    if (!object) {
        return NO;
    }
    return [object isKindOfClass:self];
}
@end
