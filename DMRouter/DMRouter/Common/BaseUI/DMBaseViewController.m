//
//  TaurusBaseViewController.m
//  PPJiJin
//
//  Created by duanmu on 15/3/23.
//  Copyright (c) 2015年 FuEr. All rights reserved.
//

#import "DMBaseViewController.h"
#import "UIImage+XMUIImage.h"
#import "UIColor+Extend.h"
#import "UIBarButtonItem+Items.h"
#import "AppDelegate.h"


typedef void(^ReloadViewBlock)(void);
@interface DMBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation DMBaseViewController

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    
    return UIStatusBarAnimationFade;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexColorString:@"#FFFFF5"] size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)]];
   
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = [[UIScreen mainScreen] bounds];
    if(self.navigationController.viewControllers.count > 1){
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"ic_arrow_back" highImageName:@"ic_arrow_back" target:self action:@selector(backToVC)];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)backToVC{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pushViewController:(NSString *)viewControllerName withArgment:(NSDictionary *)argDict{
    Class viewControllerClass=NSClassFromString(viewControllerName);
    DMBaseViewController *viewController = [[viewControllerClass alloc] init];
    if([viewController isKindOfClass:[DMBaseViewController class]] && viewController!=nil){
        viewController.argDict = argDict;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}





@end
