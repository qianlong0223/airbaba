//
//  TextCollectionViewCell2.m
//  商会之家
//
//  Created by apple on 15/8/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "TextCollectionViewCell.h"

@implementation TextCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
// Initialization code
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, viewWidth-10, viewHeight-10)];
       
        _textLabel.autoresizingMask=UIViewAutoresizingFlexibleWidth;
        [self addSubview:_textLabel];
    }
    return self;
}

@end
