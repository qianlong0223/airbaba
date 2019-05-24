//
//  SelectDateView.m
//  yixiuge
//
//  Created by apple on 2018/10/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SelectDateView.h"

@interface SelectDateView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,weak)UIPickerView * pickerView;

//年
@property(nonatomic,copy)NSArray * yearArr;
//月
@property(nonatomic,copy)NSArray * monthArr;
//日
@property(nonatomic,copy)NSArray * dayArr;

@end


@implementation SelectDateView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pickerView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
    }
    return self;
}
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.pickerView.frame=CGRectMake(0, 0,frame.size.width, frame.size.height);
}
-(UIPickerView *)pickerView
{
    if (_pickerView==nil)
    {
        UIPickerView * datePicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:datePicker];
        datePicker.dataSource=self;
        datePicker.delegate=self;
        
        _pickerView=datePicker;
        
        _date=([[NSDate date] compare:self.maxDate]==1||[[NSDate date] compare:self.minDate]==-1)?self.maxDate:[NSDate date];

        [self reloadData];
    }
    return _pickerView;
}
-(void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex=selectIndex;
    [self.pickerView reloadAllComponents];
}
-(void)setDate:(NSDate *)date
{
    _date=date;
    if (self.yearArr.count)
    [self.pickerView selectRow:[self.yearArr indexOfObject:@(date.year)] inComponent:0 animated:NO];
    if (self.monthArr.count)
    [self.pickerView selectRow:[self.monthArr indexOfObject:@(date.month)] inComponent:1 animated:NO];
    if (self.selectIndex==0)
        if (self.dayArr.count)
    [self.pickerView selectRow:[self.dayArr indexOfObject:@(date.day)] inComponent:2 animated:NO];
}

-(void)setYearArr
{
    NSMutableArray * marr=[NSMutableArray new];
    for (NSInteger a=self.minDate.year; a<=self.maxDate.year ; a++)
    {
        [marr addObject:@(a)];
    }
    self.yearArr=marr.copy;
}

-(void)setMonthArr
{
    NSMutableArray * marr=[NSMutableArray new];
    NSInteger min=1;
    NSInteger max=12;
    if (self.date.year==self.minDate.year)
    {
        min=self.minDate.month;
    }
    if (self.date.year==self.maxDate.year)
    {
        max=self.maxDate.month;
    }
    
    for (NSInteger a=min; a<=max ; a++)
    {
        [marr addObject:@(a)];
    }
    self.monthArr=marr.copy;
}

-(void)setDayArr
{
    NSMutableArray * marr=[NSMutableArray new];
    NSInteger min=1;
    NSInteger max=[self.date numberOfDaysInCurrentMonth];
    if (self.date.year==self.minDate.year&&self.date.month==self.minDate.month)
    {
        min=self.minDate.day;
    }
    if (self.date.year==self.maxDate.year&&self.date.month==self.maxDate.month)
    {
        max=self.maxDate.day;
    }
    
    for (NSInteger a=min; a<=max ; a++)
    {
        [marr addObject:@(a)];
    }
    self.dayArr=marr.copy;
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3-self.selectIndex;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return component?component==1?self.monthArr.count:self.dayArr.count:self.yearArr.count;
}
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *arr=component?component==1?self.monthArr:self.dayArr:self.yearArr;
    
    NSString * text=[NSString stringWithFormat:@"%@%@",arr[row],@[@"年",@"月",@"日"][component]];
    
    return [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}
#pragma mark 选择时间
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * text=nil;
   
    if (self.selectIndex)
    {
        text=[NSString stringWithFormat:@"%@-%@-1 00:00:00",self.yearArr[[self.pickerView selectedRowInComponent:0]],self.monthArr[[self.pickerView selectedRowInComponent:1]]];
    }else
        text=[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",self.yearArr[[self.pickerView selectedRowInComponent:0]],self.monthArr[[self.pickerView selectedRowInComponent:1]],self.dayArr[[self.pickerView selectedRowInComponent:2]]];
    
    self.date=[NSDate dateText:text];
    
    switch (component) {
        case 0:
            //            选择年更新月份
            [self setMonthArr];
        case 1:
            //            选择月份更新日
            if (self.selectIndex==0)
            [self setDayArr];
            
            [self.pickerView reloadAllComponents];

            break;
        default:
            break;
    }
    
    if (self.selectIndex)
    {
        text=[NSString stringWithFormat:@"%@-%@-1 00:00:00",self.yearArr[[self.pickerView selectedRowInComponent:0]],self.monthArr[[self.pickerView selectedRowInComponent:1]]];
    }else
        text=[NSString stringWithFormat:@"%@-%@-%@ 00:00:00",self.yearArr[[self.pickerView selectedRowInComponent:0]],self.monthArr[[self.pickerView selectedRowInComponent:1]],self.dayArr[[self.pickerView selectedRowInComponent:2]]];
    
    self.date=[NSDate dateText:text];
    
    if (self.delegate) {
        [self.delegate selectDateView:self];
    }
}

-(void)setMinDate:(NSDate *)minDate
{
    _minDate=minDate;
    [self reloadData];
}

-(void)setMaxDate:(NSDate *)maxDate
{
    _maxDate=maxDate;
    [self reloadData];
}

-(NSDate *)minDate
{
    if (_minDate==nil) {
        _minDate=[NSDate dateText:@"1971-1-1 00:00:00"];
    }
    return _minDate;
}

-(NSDate *)maxDate
{
    if (_maxDate==nil) {
        NSString * text=[NSString stringWithFormat:@"%ld-1-1 00:00:00",[NSDate date].year+100];
        _maxDate=[NSDate dateText:text];
    }
    return _maxDate;
}

-(void)reloadData
{
    [self setYearArr];
    [self setMonthArr];
    [self setDayArr];
    [self.pickerView reloadAllComponents];
}

-(void)drawRect:(CGRect)rect
{
    [self reloadData];

    NSDate * date=self.date;
    self.date=date;
    
}

//-(NSDate *)date
//{
//    if (_date==nil)
//    {
//        _date=([[NSDate date] compare:self.maxDate]==1)?self.maxDate:[NSDate date];
//    }
//    return _date;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
