//
//  TextCollectionReusableView.m
//  dongfeng
//
//  Created by apple on 16/8/31.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TextCollectionReusableView.h"

@implementation TextCollectionReusableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        [self addSubview:_textLabel];
        
    }
    return self;
}

@end
