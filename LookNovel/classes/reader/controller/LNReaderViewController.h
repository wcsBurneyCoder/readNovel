//
//  LNReaderViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTableViewController.h"
#import "LNRecentBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNReaderViewController : LNTableViewController

@property (nonatomic, strong) LNRecentBook *recentBook;

@end

NS_ASSUME_NONNULL_END
