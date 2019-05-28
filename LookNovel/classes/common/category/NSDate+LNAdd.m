//
//  NSDate+LNAdd.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "NSDate+LNAdd.h"

@implementation NSDate (LNAdd)

/**
 2  * @method
 3  *
 4  * @brief 获取两个日期之间的天数
 5  * @param fromDate       起始日期
 6  * @param toDate         终止日期
 7  * @return    总天数
 8  */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay
                                         fromDate:fromDate
                                           toDate:toDate
                                          options:NSCalendarWrapComponents];
    return comp.day;
}

+ (NSInteger)numberOfHoursWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitHour
                                         fromDate:fromDate
                                           toDate:toDate
                                          options:NSCalendarWrapComponents];
    return comp.hour;
}

@end
