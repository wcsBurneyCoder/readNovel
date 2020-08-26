//
//  LNAPI.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNAPI.h"

@implementation LNAPI

+ (void)getHomeRecommandListComplete:(httpCompleteBlock)completeBlock
{
    [LNRequest GET:@"category/discoveryAll?pageNum=1&pageSize=9&type=RECENT_UPDATE" params:nil cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(nil, cache, error);
            }
        }
        else{
            NSArray *books = [[result objectForKey:@"data"] objectForKey:@"list"];
            if (completeBlock) {
                completeBlock(books, cache, error);
            }
        }
    }];
}

+ (void)getBookChaptersWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock
{
    [LNRequest GET:@"chapter/getByBookId" params:@{@"bookId": bookId} cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(nil,cache,error);
            }
        }
        else {
            NSArray *chapters = result[@"data"][@"chapters"];
            if (completeBlock) {
                completeBlock(chapters,cache,error);
            }
        }
    }];
}

+ (void)updateBookChaptersWithBookId:(NSString *)bookId chapterId:(NSString *)chapterId complete:(httpCompleteBlock)completeBlock
{
    [LNRequest GET:@"chapter/getByBookId" params:@{@"bookId": bookId, @"chapterId": chapterId} cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(nil,cache,error);
            }
        }
        else {
            NSArray *chapters = result[@"data"][@"chapters"];
            if (completeBlock) {
                completeBlock(chapters,cache,error);
            }
        }
    }];
}

+ (void)getBookContentWithChapter:(NSString *)chapterId bookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock
{
    [LNRequest POST:@"chapter/get" params:@{@"bookId": bookId, @"chapterIdList": @[chapterId]} cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(nil,cache,error);
            }
        }
        else {
            NSArray *contents = result[@"data"][@"list"];
            if (completeBlock) {
                completeBlock(contents.firstObject,cache,error);
            }
        }
    }];
}

+ (void)getAllClassifyListComplete:(httpCompleteBlock)completeBlock
{
    [LNRequest GET:@"category/getCategoryChannel" params:nil cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(nil,cache,error);
            }
        }
        if (completeBlock) {
            completeBlock([result objectForKey:@"data"][@"channels"],cache,error);
        }
    }];
}

+ (void)getClassifyBooksWithGroupKey:(NSString *)key pageIndex:(NSInteger)index pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock
{
    NSDictionary *param = @{
                            @"categoryId":key,
                            @"orderBy":@"HOT",
                            @"pageNum":@(index),
                            @"pageSize":@(pageSize)
                            };
    [LNRequest GET:@"book/getCategoryId" params:param cache:NO complete:^(NSDictionary *result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(result,cache,error);
            }
        }
        else{
            NSArray *books = [result objectForKey:@"data"][@"list"];
            if (completeBlock) {
                completeBlock(books,cache,error);
            }
        }
    }];
}

+ (void)getBookDetailWithId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock
{
    [LNRequest GET:@"book/getDetail" params:@{@"bookId": bookId} cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(result,cache,error);
            }
        }
        else{
            NSDictionary *book = [result objectForKey:@"data"];
            if (completeBlock) {
                completeBlock(book,cache,error);
            }
        }
    }];
}

+ (void)getSearchTipsWithKeyword:(NSString *)keyword complete:(httpCompleteBlock)completeBlock
{
    if (keyword.length == 0) {
        if (completeBlock) {
            completeBlock(nil, NO, nil);
        }
        return;
    }
    [LNRequest GET:@"http://api.zhuishushenqi.com/book/auto-suggest" params:@{@"query":keyword} cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(result,cache,error);
            }
        }
        else{
            NSArray *books = [result objectForKey:@"keywords"];
            if (completeBlock) {
                completeBlock(books,cache,error);
            }
        }
    }];
}

+ (void)getSearchBooksWithKeyword:(NSString *)keyword page:(NSInteger)page pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock
{
    if (keyword.length == 0) {
        if (completeBlock) {
            completeBlock(nil, NO, nil);
        }
        return;
    }
    [LNRequest GET:@"book/search" params:@{@"keyWord":keyword, @"pageNum": @(page), @"pageSize": @(pageSize)} cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(result,cache,error);
            }
        }
        else{
            NSArray *books = [[result objectForKey:@"data"] objectForKey:@"list"];
            if (completeBlock) {
                completeBlock(books,cache,error);
            }
        }
    }];
}
@end
