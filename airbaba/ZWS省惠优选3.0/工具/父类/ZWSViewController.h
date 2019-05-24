//
//  ViewController.h
//  chuangke
//
//  Created by apple on 16/5/4.
//  Copyright (c) 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MyData.h"
@interface ZWSViewController : UIViewController

@property(nonatomic,strong)UIActivityIndicatorView *activity;

@property (nonatomic,strong)NSMutableArray * dataArr;

@property(nonatomic,strong)JSONData * jsonData;

/**导航栏 间距*/
-(UIBarButtonItem*)setFixedSpaceBarButtonItem;
/**导航栏 颜色*/
-(void)setNavigationBarColor;
/**导航栏 按钮*/
-(void)setBarButtonItem;

/**导航栏 返回*/
-(void)popButtonPressed;


-(CGFloat)getNavHeight;

/** 是否登陆 未登录 跳转登陆界面*/
-(BOOL)isLogin;

-(void)showText:(NSString *)text;

-(void)showFailure;

-(BOOL)isSuccess:(NSArray*)dataArr;

/**模态跳转 背景是半透明 视图 */
-(void)pushViewController:(UIViewController*)viewController;

-(void)scrollViewEdgeTop:(UIScrollView*)scrollView;

@end

