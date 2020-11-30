//
//  DMSASRouter.m
//  PPJiJin
//
//  Created by duanmu on 2017/11/28.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import "DMSASRouter.h"

static DMSASRouter *manager = nil;

@implementation DMSASRouter

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [DMSASRouter new];
    });
    return manager;
}

@end
