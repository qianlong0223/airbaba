//
//  AlertViewViewController.m
//  dongfeng
//
//  Created by apple on 16/11/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AlertViewViewController.h"

@interface AlertViewViewController ()

@end

@implementation AlertViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, myDeviceScreenWidth, myDeviceScreenHeight)];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(popButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self setBackView];
}

-(void)popButtonPressed
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)setBackView
{
    
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
