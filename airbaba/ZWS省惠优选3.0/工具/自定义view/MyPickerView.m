//
//  MyPickerView.m
//  随手生活
//
//  Created by apple on 15/4/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyPickerView.h"
#import "MyData.h"

@interface MyPickerView ()


@end
@implementation MyPickerView
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.pickerView.frame=CGRectMake(0, 0, viewWidth, viewHeight);
}

-(UIPickerView *)pickerView
{
    if (_pickerView==nil) {
        _pickerView=[UIPickerView new];
        _pickerView.delegate=self;
        _pickerView.dataSource=self;
        [self addSubview:_pickerView];
    }
    return _pickerView;
}

-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr=dataArr;
    [_pickerView reloadAllComponents];
}
//指定数据选择器 列数的 代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _dataArr.count;
}

//指定数据选择器 每一列有多少行 代理方法
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_dataArr[component]count];
}
//指定那一列那一行 具体的数据
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  
   return  [self.delegate myPickerView:self  titleForRow:row forComponent:component];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    [self.delegate myPickerView:self didSelectRow:row inComponent:component];
}
-(void)reloadComponent:(NSInteger)component
{
    [_pickerView reloadComponent:component];
}

// scrolls the specified row to center.



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
