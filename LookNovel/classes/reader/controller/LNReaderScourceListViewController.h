//
//  LNReaderScourceListViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTableViewController.h"
@class LNBookLinkSource;

NS_ASSUME_NONNULL_BEGIN

@interface LNReaderScourceListViewController : LNTableViewController

@property (nonatomic, copy) void(^didSelect)(LNBookLinkSource *source);
/**当前的源的索引*/
@property (nonatomic, assign) NSInteger currentIndex;
@end

NS_ASSUME_NONNULL_END
