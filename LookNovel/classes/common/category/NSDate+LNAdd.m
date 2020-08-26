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

- (NSString *)timeIntervalDescription
{
    NSTimeInterval timeInterval = -[self timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    } else if (timeInterval < 86400) {
        return [NSString stringWithFormat:@"%.f小时前", timeInterval / 3600];
    } else if (timeInterval < 2592000) {//30天内
        return [NSString stringWithFormat:@"%.f天前", timeInterval / 86400];
    } else if (timeInterval < 31536000) {//30天至1年内
        return [self stringWithFormat:@"M月d日"];
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000];
    }
}
@end
