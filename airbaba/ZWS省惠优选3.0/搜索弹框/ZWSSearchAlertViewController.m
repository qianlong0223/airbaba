//
//  ZWSSearchAlertViewController.m
//  HappyAmoy
//
//  Created by 曾威盛 on 2018/10/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZWSSearchAlertViewController.h"

@interface ZWSSearchAlertViewController ()

@end

@implementation ZWSSearchAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setBackView
{
    UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, myDeviceScreenWidth-40, 300)];
    [self.view addSubview:backView];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.masksToBounds=YES;
    backView.layer.cornerRadius=12;
    backView.center=CGPointMake(myDeviceScreenWidth/2, myDeviceScreenHeight/2);
    
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, myWidth(backView), myWidth(backView)/580*180)];
    [backView addSubview:imageView];
    imageView.image=[UIImage filePathName:@"SearchAlertTitle.png"];
    
    UILabel * textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, myHeight(imageView), myWidth(backView)-20, myHeight(backView)-myHeight(imageView)-50)];
    [backView addSubview:textLabel];
    textLabel.text=self.keyword;
    textLabel.numberOfLines=0;

    UIButton * leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, myHeight(backView)-50, myWidth(backView)/2, 50)];
    [backView addSubview:leftButton];
    [leftButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"取消" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(popButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [leftButton shapeLayer:CGPointMake(0, 0) andEndPoint:CGPointMake(myWidth(leftButton), 0) andColor:[UIColor lightGrayColor] andLineWeight:0.5];
    
    UIButton * rightButton=[[UIButton alloc]initWithFrame:CGRectMake(myWidth(leftButton), myoriginY(leftButton), myWidth(leftButton), myHeight(leftButton))];
    [backView addSubview:rightButton];
    [rightButton setAttributedTitle:[[NSAttributedString alloc]initWithString:@"确定" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [rightButton shapeLayer:CGPointMake(0, 0) andEndPoint:CGPointMake(myWidth(leftButton), 0) andColor:[UIColor lightGrayColor] andLineWeight:0.5];
    [rightButton shapeLayer:CGPointMake(0, 0) andEndPoint:CGPointMake(0, myHeight(rightButton)) andColor:[UIColor lightGrayColor] andLineWeight:0.5];
}
-(void)rightButtonPressed
{
    [self popButtonPressed];
    [self.delegate searchAlertViewController:self];

//    [mykeyWindowView rootViewController];
    
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
