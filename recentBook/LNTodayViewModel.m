//
//  LNTodayViewModel.m
//  recentBook
//
//  Created by wangchengshan on 2019/5/24.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTodayViewModel.h"

@implementation LNTodayViewModel

- (void)loadData
{
    LNRecentBook *book = [self getLastRecentBookFromGroup];
    self.currentBook = book;
    [self.todayVc updateData];
}
@end
