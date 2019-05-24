//
//  PlaceholderTextView.m
//  yixiuge
//
//  Created by apple on 2018/9/7.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "PlaceholderTextView.h"

@implementation PlaceholderTextView
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];

    [self setFrame:frame];
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.placeholderLabel.frame=CGRectMake(10, 0, frame.size.width-10, 30);
}
-(UILabel *)placeholderLabel
{
    if (_placeholderLabel==nil) {
        UILabel * textLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width-10, 30)];
        [self addSubview:textLabel];
        textLabel.textColor=[UIColor lightGrayColor];
        textLabel.font=self.font;
        _placeholderLabel=textLabel;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlaceholder) name:UITextViewTextDidChangeNotification object:self];
        
    }

    return _placeholderLabel;
}

-(void)refreshPlaceholder
{
    self.placeholderLabel.alpha=![[self text]length];
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self refreshPlaceholder];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
