//
//  LNTodayViewModel.h
//  recentBook
//
//  Created by wangchengshan on 2019/5/24.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "TodayViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNTodayViewModel : LNBaseViewModel
/***/
@property (nonatomic, weak) TodayViewController *todayVc;

@property (nonatomic, strong) LNRecentBook *currentBook;

- (void)loadData;
@end

NS_ASSUME_NONNULL_END
