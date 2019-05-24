//
//  ViewController.m
//  chuangke
//
//  Created by apple on 16/5/4.
//  Copyright (c) 2016年 apple. All rights reserved.
//

#import "ZWSViewController.h"

@interface ZWSViewController ()

@end

@implementation ZWSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    self.view.backgroundColor=[UIColor backColor];

    [self setNavigationBarColor];

    if ([self.navigationController.viewControllers indexOfObject:self])
        [self setBarButtonItem];
}

-(NSMutableArray *)dataArr
{
    if (_dataArr==nil)
    {
        _dataArr=[NSMutableArray new];
    }
    return _dataArr;
}

-(void)setNavigationBarColor
{
    //    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

-(void)setBarButtonItem
{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_1"] style:UIBarButtonItemStylePlain target:self action:@selector(popButtonPressed)];
}

-(UIBarButtonItem*)setFixedSpaceBarButtonItem
{
    UIBarButtonItem * bar=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    bar.width=-10;
    return bar;
}


-(void)popButtonPressed
{
    if (_jsonData) {
        [_jsonData cancelAllOperations];
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];

    [self.navigationController popViewControllerAnimated:YES];
}

-(JSONData *)jsonData
{
    if (_jsonData==nil)
    {
        _jsonData=[JSONData new];
        _jsonData.view=self.view;
        _jsonData.activity=self.activity;
    }
    return _jsonData;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)pushViewController:(UIViewController*)viewController
{
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self presentViewController:viewController animated:YES completion:nil];
}
-(void)showText:(NSString *)text
{
    [WYProgress showErrorWithStatus:text];
}
-(void)showFailure
{
    [self showText:@"网络错误"];
}



-(BOOL)isSuccess:(NSArray*)dataArr
{
    [self.view endEditing:YES];
    
    for (id dic in dataArr)
    {
        if ([dic isKindOfClass:[NSDictionary class]])
        {
            if (![dic[@"text"]length])
            {
//                [self showText:dic[@"placeholder"]];

                return NO;
            }
        }else
        {
            for (NSDictionary * dic2  in dic)
            {
                if (![dic2[@"text"]length])
                {
//                    [self showText:dic2[@"placeholder"]];
                    return NO;
                }
            }
        }
        
    }
    
    return YES;
}
-(CGFloat)getNavHeight
{
    //获取状态栏的rect
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    //获取导航栏的rect
    CGRect navRect = self.navigationController.navigationBar.frame;
    //    那么导航栏+状态栏的高度
    CGFloat height= statusRect.size.height+navRect.size.height;
    return height;
}
-(void)scrollViewEdgeTop:(UIScrollView*)scrollView
{
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *))
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
#endif
    self.automaticallyAdjustsScrollViewInsets = NO;self.edgesForExtendedLayout = UIRectEdgeTop;
}


-(UIActivityIndicatorView *)activity
{
    if (_activity==nil)
    {
        _activity=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activity.frame=CGRectMake(myWidth(self.view)/2-30, 150, 60, 60);
        _activity.color=[UIColor blackColor];
        [self.view addSubview:_activity];
    }
    [self.view bringSubviewToFront:_activity];
    return _activity;
}
//支持旋转
-(BOOL)shouldAutorotate
{
    return YES;
}
//支持的方向 因为界面A我们只需要支持竖屏

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
