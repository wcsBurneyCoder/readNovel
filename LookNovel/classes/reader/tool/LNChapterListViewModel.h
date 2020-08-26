//
//  LNChapterListViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2020/8/17.
//  Copyright © 2020 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
@class LNReaderChapterListViewController;

NS_ASSUME_NONNULL_BEGIN

@interface LNChapterListViewModel : LNBaseViewModel
@property (nonatomic, weak) LNReaderChapterListViewController *readerVc;
@property (nonatomic, strong) LNRecentBook *recentBook;

///更新章节
- (void)updateChapterListComplete:(httpCompleteBlock)completeBlock;
@end

NS_ASSUME_NONNULL_END
