//
//  NSDate+WQCalendarLogic.m
//  menchuang
//
//  Created by apple on 15/12/18.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "NSDate+WQCalendarLogic.h"

@implementation NSDate (WQCalendarLogic)

//0. 首先需要知道这个月有多少天：
- (NSUInteger)numberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}
//1. 确定这个月的第一天是星期几。这样就能知道给定月份的第一周有几天：
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}
//2. 减去第一周的天数，剩余天数除以7，得到倍数和余数：
- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
}
//3。当天  星期几
- (NSUInteger)numberOfWeeksInCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfCurrentMonth] weeklyOrdinality];
    
    NSUInteger days = [self numberOfDaysInCurrentMonth];
    NSUInteger weeks = 0;
    
    if (weekday > 1) {
        weeks += 1, days -= (7 - weekday + 1);
    }
    
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    return weeks;
}


-(NSUInteger)weekDay
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDate *now = [NSDate date];
    NSDateComponents *comps;
    comps = [calendar components:unitFlags fromDate:self];
    //NSInteger week = [comps week]; // 今年的第几周
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSLog(@"%d",weekday);
    return weekday;
}

-(NSString *)weekDayText
{
    
    return @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"][self.weekDay-1];
}

#pragma mark 日期
-(NSString*)tomorrow:(CGFloat)date
{
    NSTimeInterval  interval =24*60*60*date; //1:天数
    NSDate*date1 = [self initWithTimeIntervalSinceNow:+interval];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date1]];
}

-(NSString*)dateToString
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    return [dateformatter stringFromDate:self];
}
//yyyy-MM-dd HH:mm:ss
-(NSString*)dateToStringAll
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateformatter stringFromDate:self];
}

/**"yyyy-mm-dd hh:mm:ss"*/
+(NSDate*)dateText:(NSString*)text
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];//创建一个日期格式化器
    
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";//指定转date得日期格式化形式
    
    return [dateFormatter dateFromString:text];
}

@end
