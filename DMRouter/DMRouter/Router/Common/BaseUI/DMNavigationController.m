//
//  DMNavigationController.m
//  PPJiJin
//
//  Created by duanmu on 15/3/23.
//  Copyright (c) 2015年 FuEr. All rights reserved.
//

#import "DMNavigationController.h"

@interface DMNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end


@implementation DMNavigationController


- (void)viewDidLoad{
    [super viewDidLoad];
    __weak DMNavigationController *weakSelf = self;
    self.delegate = weakSelf;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
            self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate{
    // Enable the gesture again once the new controller is shown
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        if(self.viewControllers.count>1){
            self.interactivePopGestureRecognizer.enabled = YES;
        }else{
            self.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    __weak DMNavigationController *weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        if(self.viewControllers.count>1){
            self.interactivePopGestureRecognizer.delegate = weakSelf;
        }else{
             self.interactivePopGestureRecognizer.delegate = nil;
        }
    }
}

#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
@end
