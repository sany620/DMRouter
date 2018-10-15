//
//  DMToolsMacros.h
//  PPJiJin
//
//  Created by duanmu on 2017/11/29.
//  Copyright © 2017年 Sany. All rights reserved.
//

#ifndef DMToolsMacros_h
#define DMToolsMacros_h


    //单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}


#endif /* DMToolsMacros_h */
