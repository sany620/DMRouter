//
//  NSObject+Cast.h
//  PPJiJin
//
//  Created by duanmu on 2017/11/28.
//  Copyright © 2017年 Sany. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Cast)
+ (instancetype)cast:(id)object;
+ (BOOL)has:(id)object;
@end

NS_ASSUME_NONNULL_END
