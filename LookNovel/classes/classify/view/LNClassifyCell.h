//
//  LNClassifyCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseCollectionViewCell.h"
#import "LNClassifyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyCell : LNBaseCollectionViewCell

@property (nonatomic, strong) LNClassifyModel *model;
@end

NS_ASSUME_NONNULL_END
