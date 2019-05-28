//
//  LNHistoryCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseTableViewCell.h"
#import "LNRecentBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNHistoryCell : LNBaseTableViewCell
@property (nonatomic, strong) LNRecentBook *book;
@end

NS_ASSUME_NONNULL_END
