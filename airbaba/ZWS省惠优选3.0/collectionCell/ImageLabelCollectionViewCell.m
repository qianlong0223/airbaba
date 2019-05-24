//
//  ImageLabelCollectionViewCell.m
//  商会之家
//
//  Created by apple on 15/7/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ImageLabelCollectionViewCell.h"

@implementation ImageLabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   // Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, viewWidth-20,  viewWidth-20)];
        [self addSubview:_imageView];
        _imageView.layer.masksToBounds=YES;
        _imageView.layer.cornerRadius=myHeight(_imageView)/2;
        
        CGFloat y=_imageView.frame.origin.x+_imageView.frame.size.height;
        _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,y, viewWidth, viewHeight-y)];
        [self addSubview:_textLabel];
        _textLabel.textAlignment=NSTextAlignmentCenter;
        _textLabel.font=[UIFont systemFontOfSize:mytextFont];
    }
    return self;
}


@end
