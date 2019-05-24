//
//  MyScrollView.m
//  商会之家
//
//  Created by apple on 15/8/13.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyScrollView.h"

#import "ImageCollectionViewCell.h"

#define myCount 1000
#import "MyData.h"
@interface MyScrollView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    NSTimer *timer;
}
@end

@implementation MyScrollView
/*
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _collectionView.frame=CGRectMake(0, 0, viewWidth, viewHeight);
    [_collectionView reloadData];
}*/

-(UICollectionView *)collectionView
{
    if (_collectionView==nil)
    {
        UICollectionViewFlowLayout *flowLayout=[UICollectionViewFlowLayout new];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing=0;
        flowLayout.minimumInteritemSpacing=0;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        [self addSubview:_collectionView];
        _collectionView.pagingEnabled=YES;
        _collectionView.backgroundColor=[UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator=_collectionView.showsHorizontalScrollIndicator=NO;
        
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        
        [_collectionView  registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
        _collectionView.bounces=NO;
        
        self.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        _collectionView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        
        
        _pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(0, viewHeight-30, viewWidth, 20)];
        [self addSubview:_pageControl];
        [self bringSubviewToFront:_pageControl];
        
//        _pageControl.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        
        _pageControl.currentPage=0;
        _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        _pageControl.pageIndicatorTintColor=[UIColor blackColor];
    }
    return _collectionView;
}
-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr=dataArr;
    
    [self.collectionView reloadData];
    
    _pageControl.numberOfPages=_dataArr.count;
    if (timer==nil&&_dataArr.count)
    {
        timer= [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    }else
    {
        [timer invalidate];
        timer=nil;
    }
    
   
}
-(void)setItemSize:(CGSize)itemSize
{
    _itemSize=itemSize;
    //     [_collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count*myCount;
}

#pragma mark 返回单元格
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    cell.imageView.contentMode=UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds=YES;

    [self.delegate myScrollView:self andIndex:indexPath.row%_dataArr.count setImage:cell.imageView];
    
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    return CGSizeMake(viewWidth, viewHeight);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     NSInteger index=_collectionView.contentOffset.x/viewWidth;
    if (index==_dataArr.count*myCount)
    {
        _collectionView.contentOffset=CGPointMake((_dataArr.count)*viewWidth, 0);
    }
    
    if ([self.delegate respondsToSelector:@selector(myScrollViewDidEndDecelerating:andIndex:)])
    [self.delegate myScrollViewDidEndDecelerating:self andIndex:index%_dataArr.count];
    
    _pageControl.currentPage=index%_dataArr.count;
    
    
}
-(void)nextImage
{
    if (_dataArr.count)
    {
        NSInteger index=_collectionView.contentOffset.x/viewWidth+1;
        
        if (index==_dataArr.count*myCount-1)
        {
            index=_dataArr.count;
            
            
            [self scrollToRowAtIndexPath:index andAnimated:NO];
            _collectionView.contentOffset=CGPointMake((_dataArr.count)*viewWidth, 0);
        }else
            [self scrollToRowAtIndexPath:index andAnimated:YES];
        
        
        _pageControl.currentPage=index%_dataArr.count;
    }
    
}

#pragma mark 跳到指定区
-(void)scrollToRowAtIndexPath:(NSInteger)row andAnimated:(BOOL)animated
{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(myScrollView:didSelectItemAtIndexPath:andIndex:)])
    [self.delegate myScrollView:self didSelectItemAtIndexPath:indexPath andIndex:indexPath.row%_dataArr.count];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
