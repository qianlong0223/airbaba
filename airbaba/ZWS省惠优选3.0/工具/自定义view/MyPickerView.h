//
//  MyPickerView.h
//  随手生活
//
//  Created by apple on 15/4/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyPickerView;

@protocol MyPickerViewDelegate <NSObject>


-(NSString *)myPickerView:(MyPickerView*)myPickerView   titleForRow:(NSInteger)row forComponent:(NSInteger)component;

-(void)myPickerView:(MyPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface MyPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic,weak)id<MyPickerViewDelegate>delegate;

@property(nonatomic,strong)UIPickerView * pickerView;
@property(nonatomic,copy)NSArray * dataArr;

@end
