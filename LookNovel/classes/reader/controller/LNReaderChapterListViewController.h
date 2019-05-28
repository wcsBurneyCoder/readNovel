//
//  LNReaderChapterListViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNReaderChapterListViewController : LNTableViewController
/**当前的章节的索引*/
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) void(^didSelect)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
