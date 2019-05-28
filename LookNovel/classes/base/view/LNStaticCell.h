//
//  LNStaticCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseTableViewCell.h"
#import "LNStaticModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNStaticCell : LNBaseTableViewCell
/**设置模型*/
@property (nonatomic, strong) LNStaticModel *model;
@end

NS_ASSUME_NONNULL_END
