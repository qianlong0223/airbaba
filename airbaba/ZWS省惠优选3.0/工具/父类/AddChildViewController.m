//
//  AddChildViewController.m
//  dongfeng
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AddChildViewController.h"

@interface AddChildViewController ()

@end

@implementation AddChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


-(UISegmentedControl *)segmentedControl
{
    if (_segmentedControl==nil) {
        _segmentedControl=[[UISegmentedControl alloc]initWithItems:self.dataArr];
        _segmentedControl.backgroundColor=[UIColor whiteColor];
        _segmentedControl.frame=CGRectMake(0, 0, myDeviceScreenWidth, 44);
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:mytitleFont]} forState:UIControlStateNormal];
        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:mytitleFont]} forState:UIControlStateSelected];
        
        _segmentedControl.tintColor=[UIColor clearColor];
        
        [_segmentedControl setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"backLine"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        _segmentedControl.selectedSegmentIndex=0;

        [_segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_segmentedControl];
    }
    return _segmentedControl;
}
-(UIScrollView *)scrollView
{
    if (_scrollView==nil)
    {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, myDeviceScreenWidth, myDeviceScreenHeight)];
        [self.view addSubview:_scrollView];
        _scrollView.bounces=NO;
        _scrollView.delegate=self;
        _scrollView.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.pagingEnabled=YES;
        _scrollView.contentSize=CGSizeMake(myDeviceScreenWidth*self.dataArr.count, 0);

    }
    return _scrollView;
}

-(void)scrollViewAddChildViewController:(UIViewController *)childController andFrame:(CGRect )frame
{
    [self addChildViewController:childController];
    childController.view.frame=frame;
    [self.scrollView addSubview:childController.view];
}

#pragma mark -------------切换界面-----------
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    _segmentedControl.selectedSegmentIndex=scrollView.contentOffset.x/myDeviceScreenWidth;
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _segmentedControl.selectedSegmentIndex=scrollView.contentOffset.x/myDeviceScreenWidth;
    [self addViewController:_segmentedControl.selectedSegmentIndex];

}

-(void)valueChanged:(UISegmentedControl*)seg
{
    self.scrollView.contentOffset=CGPointMake(myDeviceScreenWidth*seg.selectedSegmentIndex, 0);
    [self addViewController:seg.selectedSegmentIndex];
}


#pragma mark 添加界面
-(void)addViewController:(NSInteger)index
{
    if ([self.dataArr[index]isKindOfClass:[UIViewController class]]) {
        return;
    }
    UIViewController * viewController=[UIViewController new];
    
 viewController.view.frame=CGRectMake(myDeviceScreenWidth*index,0, myDeviceScreenWidth, myHeight(self.scrollView));
    [self.scrollView addSubview:viewController.view];
    [self addChildViewController:viewController];

    self.dataArr[index]=viewController;
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
