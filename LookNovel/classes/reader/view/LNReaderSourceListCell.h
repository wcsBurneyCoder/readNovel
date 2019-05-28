//
//  LNReaderSourceListCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseTableViewCell.h"
#import "LNBookLinkSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNReaderSourceListCell : LNBaseTableViewCell

@property (nonatomic, strong) LNBookLinkSource *source;
@end

NS_ASSUME_NONNULL_END
