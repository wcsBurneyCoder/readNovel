//
//  LNClassifyListCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseTableViewCell.h"
#import "LNClassifyBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyListCell : LNBaseTableViewCell

@property (nonatomic, strong) LNClassifyBookModel *model;
@end

NS_ASSUME_NONNULL_END
