//
//  SelectDateView.h
//  yixiuge
//
//  Created by apple on 2018/10/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectDateView;
@protocol SelectDateViewDelegate <NSObject>

-(void)selectDateView:(SelectDateView*)selectDateView;

@end

#import "NSDate+WQCalendarLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectDateView : UIView
{
    NSDate * _minDate;
    NSDate * _maxDate;
}
@property(nonatomic,weak)id<SelectDateViewDelegate>delegate;

//按 0年月日 / 1 年月筛选
@property(nonatomic,assign)NSInteger selectIndex;

/**最小选择日期 默认1971-1-1*/
@property(nonatomic,strong)NSDate * minDate;

/**最大选择日期 默认当前时间+100年*/
@property(nonatomic,copy)NSDate * maxDate;

/**当前选择时间 默认当前时间*/
@property(nonatomic,copy)NSDate * date;

@end

NS_ASSUME_NONNULL_END
