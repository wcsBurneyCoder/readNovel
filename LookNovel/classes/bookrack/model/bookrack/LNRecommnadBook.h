//
//  LNRecommnadBook.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNRecommnadBook : LNBook
///作者
@property (nonatomic, copy) NSString *author;
///内容介绍
@property (nonatomic, copy) NSString *desc;
///字数
@property (nonatomic, copy) NSString *word;

@end

NS_ASSUME_NONNULL_END
