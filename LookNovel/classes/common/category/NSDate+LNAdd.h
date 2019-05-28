//
//  NSDate+LNAdd.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LNAdd)
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
+ (NSInteger)numberOfHoursWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
@end

NS_ASSUME_NONNULL_END
