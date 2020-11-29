//
//  TaurusBaseViewController.h
//  PPJiJin
//
//  Created by duanmu on 15/3/23.
//  Copyright (c) 2015年 FuEr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouterResultState.h"


@interface DMBaseViewController : UIViewController

@property (nonatomic, strong) NSDictionary *argDict;
@property (nonatomic, copy) RouterHandleCallBack callBlock;

- (void)backToVC;

- (void)pushViewController:(NSString *)viewControllerName withArgment:(NSDictionary *)argDict;

@end
