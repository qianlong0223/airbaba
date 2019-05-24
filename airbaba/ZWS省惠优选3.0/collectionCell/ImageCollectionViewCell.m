//
//  ImageCollectionViewCell.m
//  商会之家
//
//  Created by apple on 15/8/10.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        _imageView=[[UIImageView alloc]initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [self addSubview:_imageView];
        _imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return self;
}
@end
