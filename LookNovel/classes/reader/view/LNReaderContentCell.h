//
//  LNReaderContentCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseTableViewCell.h"
#import "LNBookContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNReaderContentCell : LNBaseTableViewCell

@property (nonatomic, strong) LNBookContent *content;

+ (CGFloat)heightWithModel:(LNBookContent *)content;

@end

NS_ASSUME_NONNULL_END
