//
//  NSDate+WQCalendarLogic.h
//  menchuang
//
//  Created by apple on 15/12/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WQCalendarLogic)
//0. 首先需要知道这个月有多少天：
- (NSUInteger)numberOfDaysInCurrentMonth;
//1. 确定这个月的第一天是星期几。这样就能知道给定月份的第一周有几天：
- (NSDate *)firstDayOfCurrentMonth;
//2. 减去第一周的天数，剩余天数除以7，得到倍数和余数：
- (NSUInteger)weeklyOrdinality;

//3。当天  星期几
- (NSUInteger)numberOfWeeksInCurrentMonth;
/**星期几 （注意，周日是“1”，周一是“2”。。。。）@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"] */
-(NSUInteger)weekDay;

-(NSString *)weekDayText;

#pragma mark 日期
//yyyy-MM-dd
-(NSString*)tomorrow:(CGFloat)date;
/** yyyy-MM-dd */
-(NSString*)dateToString;
//yyyy-MM-dd HH:mm:ss
-(NSString*)dateToStringAll;

/**"yyyy-mm-dd hh:mm:ss"*/
+(NSDate*)dateText:(NSString*)text;


@end
