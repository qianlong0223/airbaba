//
//  AddChildViewController.h
//  dongfeng
//
//  Created by apple on 16/11/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZWSViewController.h"

@interface AddChildViewController : ZWSViewController<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UISegmentedControl *segmentedControl;

//加入 scrollView
-(void)scrollViewAddChildViewController:(UIViewController *)childController andFrame:(CGRect )frame;
//点击区域
-(void)valueChanged:(UISegmentedControl*)seg;

//滑动 结束
-(void)addViewController:(NSInteger)index;

@end
