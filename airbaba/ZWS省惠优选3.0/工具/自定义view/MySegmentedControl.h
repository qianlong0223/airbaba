//
//  MySegmentedControl.h
//  商会之家
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MySegmentedControl;

@protocol MySegmentedControlDelegate <NSObject>

//返回文字
-(NSString*)mySegmentedControl:(MySegmentedControl*)mySegmentedControl andTextIndex:(NSInteger)index;

//点击
-(void)mySegmentedControl:(MySegmentedControl*)mySegmentedControl andSelectIndex:(NSInteger)index;


@end

#define segHeight 45

@interface MySegmentedControl : UIView

@property(nonatomic,weak)id<MySegmentedControlDelegate>delegate;

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UISegmentedControl * segmentedControl;

@property(nonatomic,copy)NSArray * dataArr;

@property(nonatomic)NSInteger selectIndex;

@end
