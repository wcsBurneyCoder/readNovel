//
//  LNBookLinkSource.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBookChapter.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookLinkSource : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lastChapter;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) BOOL isCharge;
@property (nonatomic, assign) NSInteger chaptersCount;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, copy) NSString *updatedTime;
@property (nonatomic, assign) BOOL starting;
@property (nonatomic, copy) NSString *host;
/**章节目录*/
@property (nonatomic, strong) NSArray<LNBookChapter *> *chapterList;

@property (nonatomic, assign) BOOL isCurrent;
@end

NS_ASSUME_NONNULL_END
