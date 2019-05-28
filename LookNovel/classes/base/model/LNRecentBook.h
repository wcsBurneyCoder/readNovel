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
///章节标题
@property (nonatomic, strong) LNBookChapter *chapter;
///章节标题
@property (nonatomic, strong) LNBookLinkSource *source;
///已读比例
@property (nonatomic, assign) float readRatio;
///最后阅读时间
@property (nonatomic, copy) NSString *lastReadTime;
@end

