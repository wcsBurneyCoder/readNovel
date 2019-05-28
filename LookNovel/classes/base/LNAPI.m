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
    NSMutableArray *arrayM = [NSMutableArray array];
    [LNRequest GET:@"http://api.zhuishushenqi.com/ranking/5a684515fc84c2b8efaa9875" params:nil cache:YES complete:^(id  _Nullable firstResult, BOOL cache, NSError * _Nullable error) {
        [arrayM removeAllObjects];
        if (error) {
            if (completeBlock) {
                completeBlock(arrayM, cache, error);
            }
        }
        else{
            NSDictionary *firstDict = [firstResult objectForKey:@"ranking"];
            NSArray *firstArr = [firstDict objectForKey:@"books"];
            [arrayM addObjectsFromArray:[firstArr subarrayWithRange:NSMakeRange(0, 5)]];
            [LNRequest GET:@"http://api.zhuishushenqi.com/ranking/5a6844f8fc84c2b8efaa8bc5" params:nil cache:YES complete:^(id  _Nullable secondResult, BOOL cache, NSError * _Nullable error) {
                if (error) {
                    if (completeBlock) {
                        completeBlock(secondResult, cache, error);
                    }
                }
                else{
                    NSDictionary *secondDict = [secondResult objectForKey:@"ranking"];
                    NSArray *secondArr = [secondDict objectForKey:@"books"];
                    [arrayM addObjectsFromArray:[secondArr subarrayWithRange:NSMakeRange(0, 4)]];
                    [arrayM shuffle];
                    if (completeBlock) {
                        completeBlock(arrayM, cache, nil);
                    }
                }
            }];
        }
    }];
}

+ (void)getSourcesWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock
{
    NSString *url =[NSString stringWithFormat:@"http://api.zhuishushenqi.com/atoc?view=summary&book=%@",bookId];
    [LNRequest GET:url params:nil cache:YES complete:^(id result, BOOL cache, NSError *error) {
        if (completeBlock) {
            completeBlock(result,cache,error);
        }
    }];
}

+ (void)getBookChaptersWithsourceId:(NSString *)sourceId complete:(httpCompleteBlock)completeBlock
{
    NSString *url =[NSString stringWithFormat:@"http://api.zhuishushenqi.com/atoc/%@?view=chapters",sourceId];
    [LNRequest GET:url params:nil cache:YES complete:^(id result, BOOL cache, NSError *error) {
        if (completeBlock) {
            completeBlock(result,cache,error);
        }
    }];
}

+ (void)getBookContentWithChapter:(NSString *)chapterLink complete:(httpCompleteBlock)completeBlock
{
    NSString *link = [chapterLink stringByURLEncode];
    NSString *url =[NSString stringWithFormat:@"http://chapterup.zhuishushenqi.com/chapter/%@",link];
    [LNRequest GET:url params:nil cache:YES complete:^(id result, BOOL cache, NSError *error) {
        if (completeBlock) {
            completeBlock(result,cache,error);
        }
    }];
}

+ (void)getAllClassifyListComplete:(httpCompleteBlock)completeBlock
{
    [LNRequest GET:@"http://api.zhuishushenqi.com/cats/lv2/statistics" params:nil cache:YES complete:^(id result, BOOL cache, NSError *error) {
        if (completeBlock) {
            completeBlock(result,cache,error);
        }
    }];
}

+ (void)getClassifyBooksWithGroupKey:(NSString *)key major:(NSString *)major pageIndex:(NSInteger)index pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock
{
    NSDictionary *param = @{
                            @"gender":key,
                            @"type":@"hot",
                            @"major":major,
                            @"minor":@"",
                            @"start":@(index),
                            @"limit":@(pageSize)
                            };
    [LNRequest GET:@"https://api.zhuishushenqi.com/book/by-categories" params:param cache:YES complete:^(NSDictionary *result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(result,cache,error);
            }
        }
        else{
            NSArray *books = [result objectForKey:@"books"];
            if (completeBlock) {
                completeBlock(books,cache,error);
            }
        }
    }];
}

+ (void)getBookDetailWithId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock
{
    NSString *url = [NSString stringWithFormat:@"http://api.zhuishushenqi.com/book/%@",bookId];
    [LNRequest GET:url params:nil cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (completeBlock) {
            completeBlock(result,cache,error);
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

+ (void)getSearchBooksWithKeyword:(NSString *)keyword complete:(httpCompleteBlock)completeBlock
{
    if (keyword.length == 0) {
        if (completeBlock) {
            completeBlock(nil, NO, nil);
        }
        return;
    }
    [LNRequest GET:@"http://api.zhuishushenqi.com/book/fuzzy-search" params:@{@"query":keyword} cache:NO complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            if (completeBlock) {
                completeBlock(result,cache,error);
            }
        }
        else{
            NSArray *books = [result objectForKey:@"books"];
            if (completeBlock) {
                completeBlock(books,cache,error);
            }
        }
    }];
}
@end
