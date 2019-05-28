//
//  LNHistoryViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNHistoryViewController.h"

@interface LNHistoryViewModel : LNBaseViewModel

@property (nonatomic, weak) LNHistoryViewController *historyVc;

- (void)loadHistoryData;

- (void)continueReadBook:(LNRecentBook *)book;
@end

