//
//  LNAPI.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNAPI : NSObject
///获取首页的推荐列表
+ (void)getHomeRecommandListComplete:(httpCompleteBlock)completeBlock;
///获取所有可用源
//+ (void)getSourcesWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
///获取章节目录
+ (void)getBookChaptersWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
+ (void)updateBookChaptersWithBookId:(NSString *)bookId chapterId:(NSString *)chapterId complete:(httpCompleteBlock)completeBlock;
///获取章节文章
+ (void)getBookContentWithChapter:(NSString *)chapterId bookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
///获取所有分类
+ (void)getAllClassifyListComplete:(httpCompleteBlock)completeBlock;
///获取对应分类的相关书籍列表
+ (void)getClassifyBooksWithGroupKey:(NSString *)key pageIndex:(NSInteger)index pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock;
///获取书籍详情
+ (void)getBookDetailWithId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
///搜索提示
+ (void)getSearchTipsWithKeyword:(NSString *)keyword complete:(httpCompleteBlock)completeBlock;
///搜索书籍
+ (void)getSearchBooksWithKeyword:(NSString *)keyword page:(NSInteger)page pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock;
@end

