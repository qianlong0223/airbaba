//
//  CustomNavViewController.m
//  FreedomLife
//
//  Created by apple on 15/3/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CustomNavViewController.h"
@interface CustomNavViewController ()

@end

@implementation CustomNavViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7)
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
   

    
    [super pushViewController:viewController animated:animated];
    
   
}


#pragma mark  强制横屏代码
- (BOOL)shouldAutorotate
{
    if ([self.topViewController respondsToSelector:@selector(shouldAutorotate)]) {
        return [self.topViewController shouldAutorotate];
    }
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([self.topViewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
        return [self.topViewController supportedInterfaceOrientations];
    }
    return [super supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    if ([self.topViewController respondsToSelector:@selector(preferredInterfaceOrientationForPresentation)]) {
        return [self.topViewController preferredInterfaceOrientationForPresentation];
    }
    return [super preferredInterfaceOrientationForPresentation];
}

// 是否隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return [self.topViewController prefersStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
