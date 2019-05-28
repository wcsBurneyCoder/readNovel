//
//  LNBookrackRecommandCell.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseCollectionViewCell.h"
#import "LNBookrackViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookrackRecommandCell : LNBaseCollectionViewCell
/**数据源*/
@property (nonatomic, strong) LNRecommnadBook *bookModel;
@end

NS_ASSUME_NONNULL_END
