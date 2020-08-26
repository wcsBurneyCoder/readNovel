//
//  LNBookDetail.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNUpdate: NSObject
@property (nonatomic, assign) NSInteger chapterId;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, copy) NSString *chapterName;
@property (nonatomic, copy) NSString *chapterStatus;
@end

@interface LNRecommend: NSObject
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger bookId;
@property (nonatomic, copy) NSString *coverImg;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *chapterStatus;
@end

@interface LNBookDetail: LNBook
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, strong) LNUpdate *update;
@property (nonatomic, strong) NSArray<LNRecommend *> *recommend;
@property (nonatomic, copy) NSString *word;
@property (nonatomic, assign) NSInteger chapterNum;
@property (nonatomic, copy) NSString *desc;
@end




NS_ASSUME_NONNULL_END
