//
//  LNBookChapter.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LNBookContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookChapter : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *chapterCover;
@property (nonatomic, assign) NSInteger totalpage;
@property (nonatomic, assign) NSInteger partsize;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) NSInteger currency;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) BOOL unreadble;
@property (nonatomic, assign) BOOL isVip;
/**章节的内容*/
@property (nonatomic, strong) LNBookContent *content;
/**序号*/
@property (nonatomic, strong) NSNumber *sort;

@property (nonatomic, assign) BOOL isCurrent;
@end

NS_ASSUME_NONNULL_END
