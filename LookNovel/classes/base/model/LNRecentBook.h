//
//  LNRecentBook.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBook.h"
#import "LNBookChapter.h"
#import "LNBookLinkSource.h"

@interface LNRecentBook : LNBook
///当前章节
@property (nonatomic, assign) NSInteger chapterIndex;
///章节列表
@property (nonatomic, strong) NSArray<LNBookChapter *> *chapters;
///已读比例
@property (nonatomic, assign) float readRatio;
///最后阅读时间
@property (nonatomic, copy) NSString *lastReadTime;
@end

