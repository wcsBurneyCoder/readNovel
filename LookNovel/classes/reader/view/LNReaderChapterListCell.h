//
//  LNReaderChapterListCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseTableViewCell.h"
#import "LNBookChapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNReaderChapterListCell : LNBaseTableViewCell
@property (nonatomic, strong) LNBookChapter *chapter;
@end

NS_ASSUME_NONNULL_END
