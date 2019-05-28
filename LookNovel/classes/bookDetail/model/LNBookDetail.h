//
//  LNBookDetail.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookDetailRating : NSObject
/**评论人数*/
@property (nonatomic, assign) NSInteger count;
/**评分*/
@property (nonatomic, assign) float score;
@property (nonatomic, assign) BOOL isEffect;
@end

@interface LNBookDetail : LNBook
@property (nonatomic, copy) NSString *longIntro;
@property (nonatomic, copy) NSAttributedString *longIntroAttribute;
/**一级分类*/
@property (nonatomic, copy) NSString *majorCate;
/**创建的设备*/
@property (nonatomic, copy) NSString *creater;
/**二级分类*/
@property (nonatomic, copy) NSString *minorCate;
/**作者*/
@property (nonatomic, copy) NSString *author;
@property (nonatomic, assign) BOOL isMakeMoneyLimit;
@property (nonatomic, assign) BOOL isFineBook;
@property (nonatomic, assign) NSInteger safelevel;
@property (nonatomic, assign) BOOL allowFree;
@property (nonatomic, assign) BOOL hasCopyright;
/**作者描述*/
@property (nonatomic, copy) NSString *authorDesc;

@property (nonatomic, assign) NSInteger postCount;
/**人气*/
@property (nonatomic, assign) NSUInteger latelyFollower;
@property (nonatomic, assign) NSUInteger wordCount;
/**留存率*/
@property (nonatomic, assign) NSInteger retentionRatio;
/**更新日期*/
@property (nonatomic, copy) NSString *updated;
/**章节总数*/
@property (nonatomic, assign) NSInteger chaptersCount;
/**最新章节*/
@property (nonatomic, copy) NSString *lastChapter;
/**标签*/
@property (nonatomic, strong) NSArray *tags;
/**评价*/
@property (nonatomic, strong) LNBookDetailRating *rating;
@end

NS_ASSUME_NONNULL_END
