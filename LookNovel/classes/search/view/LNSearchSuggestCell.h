//
//  LNSearchSuggestCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseTableViewCell.h"
#import "LNSuggest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNSearchSuggestCell : LNBaseTableViewCell

@property (nonatomic, strong) LNSuggest *suggest;
@end

NS_ASSUME_NONNULL_END
