//
//  MySegmentedControl.m
//  商会之家
//
//  Created by apple on 15/8/7.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MySegmentedControl.h"

@interface MySegmentedControl ()
@property(nonatomic,strong)UIView * lineView;
@end
@implementation MySegmentedControl

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
       
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        [self addSubview:_scrollView];
        _scrollView.showsHorizontalScrollIndicator=NO;
        self.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        _scrollView.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        

        _segmentedControl=[[UISegmentedControl alloc]init];
        [_scrollView addSubview:_segmentedControl];
        
        
        [_segmentedControl addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];

        [_segmentedControl setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [_segmentedControl setBackgroundImage:[UIImage imageNamed:@"backLine.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        

        _segmentedControl.selectedSegmentIndex=0;
//        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:mytitleFont]} forState:UIControlStateNormal];
//        [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor selectColor],NSFontAttributeName:[UIFont systemFontOfSize:mytitleFont]} forState:UIControlStateSelected];
        
        _segmentedControl.tintColor=[UIColor clearColor];
    }
    return self;
}
-(void)setNormalColor:(UIColor *)normalColor
{
//    [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:normalColor,NSFontAttributeName:[UIFont systemFontOfSize:mytitleFont]} forState:UIControlStateNormal];
}
-(void)setSelectedColor:(UIColor *)selectedColor
{
//    [_segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:selectedColor,NSFontAttributeName:[UIFont systemFontOfSize:mytitleFont]} forState:UIControlStateSelected];
    _lineView.backgroundColor=selectedColor;

}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr=dataArr;
    
    if (!_dataArr.count) {
        return;
    }
    
    [_segmentedControl removeAllSegments];
    CGFloat sum=0;
    NSString * text=@"";
    
//    NSMutableArray * marr=[NSMutableArray new];
    
    for (int a=0;a<dataArr.count;++a)
    {
        text=[self.delegate mySegmentedControl:self andTextIndex:a];
//        [marr addObject:text];
        
        CGFloat width=[text  boundingRectWithSize:CGSizeMake(300, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width+15;
        sum+=width;
        [_segmentedControl insertSegmentWithTitle:text atIndex:a animated:NO];
        
        [_segmentedControl setWidth:width forSegmentAtIndex:a];
    }
    
   
    _segmentedControl.frame=CGRectMake(10,0, sum, 45);
    _scrollView.contentSize=CGSizeMake(sum+20, 0);
    /*
    if (sum<viewWidth)
    {
        [_segmentedControl removeAllSegments];

        _segmentedControl.frame=CGRectMake(10,0, viewWidth-20, 45);
        _scrollView.contentSize=CGSizeMake(viewWidth-2, 0);
        for (int a=0; a<marr.count; a++)
        {
            [_segmentedControl insertSegmentWithTitle:marr[a] atIndex:a animated:NO];
        }
    }*/

}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    _segmentedControl.selectedSegmentIndex=selectIndex;
}
-(NSInteger)selectIndex
{
    
    return _segmentedControl.selectedSegmentIndex;
}



-(void)valueChanged
{
    [self.delegate mySegmentedControl:self andSelectIndex:_segmentedControl.selectedSegmentIndex];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
