//
//  MoneyViewController.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/26.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "MoneyViewController.h"

@interface MoneyViewController ()

@end

@implementation MoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"钱包";
    self.topHeight.constant = kNavHeight;
}
- (IBAction)tixianBtnClicked:(id)sender {
}
- (IBAction)incomeBtnClicked:(id)sender {
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
