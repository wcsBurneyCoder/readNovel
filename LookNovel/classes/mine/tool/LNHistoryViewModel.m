//
//  LNHistoryViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNHistoryViewModel.h"


@implementation LNHistoryViewModel

- (UIViewController *)mainVc
{
    return self.historyVc;
}

- (void)loadHistoryData
{
    NSArray<LNRecentBook *> *historyList = [self getRecentBook];
    NSMutableArray *list = [NSMutableArray arrayWithArray:historyList];
    [list reverse];
    self.historyVc.dataArray = list;
}

- (void)continueReadBook:(LNRecentBook *)book
{
    [self startToReadBook:book];
}
@end
