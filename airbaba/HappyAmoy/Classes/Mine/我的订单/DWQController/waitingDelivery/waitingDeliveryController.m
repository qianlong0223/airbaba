//
//  waitingDeliveryController.m
//  DWQListOfDifferentOrderStatus
//
//  Created by 杜文全 on 15/11/1.
//  Copyright © 2015年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "waitingDeliveryController.h"

@interface waitingDeliveryController ()

@end

@implementation waitingDeliveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    //        //如果无网络
    //        [self.view showErrorPageView];
    //        [self.view configReloadAction:^{
    //            NSLog(@"点击我就可以刷新了啊");
    //        }];
    
    //空数据
    [self.view showBlankPageView];
    //隐藏
    //[self.view hideBlankPageView];
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
