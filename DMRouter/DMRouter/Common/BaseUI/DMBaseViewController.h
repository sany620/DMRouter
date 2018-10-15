//
//  TaurusBaseViewController.h
//  PPJiJin
//
//  Created by duanmu on 15/3/23.
//  Copyright (c) 2015年 FuEr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMBaseViewController : UIViewController

@property (nonatomic, assign)BOOL isError;
@property (nonatomic, assign)BOOL isLoadError;
@property (nonatomic, strong) NSDictionary *argDict;

- (void)backToVC;

- (void)pushViewController:(NSString *)viewControllerName withArgment:(NSDictionary *)argDict;

@end
