//
//  MyScrollView.h
//  商会之家
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyScrollView;
@protocol MyScrollViewDelegate <NSObject>

@optional
/**设置图片 */
-(void)myScrollView:(MyScrollView*)myScrollView andIndex:(NSInteger)index setImage:(UIImageView*)imageView;
/**选中图片*/
-(void)myScrollView:(MyScrollView*)myScrollView didSelectItemAtIndexPath:(NSIndexPath *)indexPath andIndex:(NSInteger)index;
/** 结束滑动 当前图片*/
-(void)myScrollViewDidEndDecelerating:(MyScrollView*)myScrollView andIndex:(NSInteger)index;

@end

#define scrollHeight myDeviceScreenHeight*0.3


@interface MyScrollView : UIView

@property(nonatomic,weak)id<MyScrollViewDelegate>delegate;

@property(nonatomic,strong)UIPageControl * pageControl;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic)CGSize itemSize;

@property(nonatomic,copy)NSArray * dataArr;


#pragma mark 跳到指定区
-(void)scrollToRowAtIndexPath:(NSInteger)row andAnimated:(BOOL)animated;
@end
