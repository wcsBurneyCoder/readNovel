//
//  LNClassifyBookModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyBookModel : LNBook
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *word;
@end

NS_ASSUME_NONNULL_END
