//
//  LNChapterListViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2020/8/17.
//  Copyright © 2020 wcs Co.,ltd. All rights reserved.
//

#import "LNChapterListViewModel.h"
#import "LNReaderChapterListViewController.h"
#import "LNAPI.h"

@implementation LNChapterListViewModel

- (void)setRecentBook:(LNRecentBook *)recentBook
{
    _recentBook = recentBook;
    
    self.readerVc.dataArray = [NSMutableArray arrayWithArray:recentBook.chapters];
}

- (void)updateChapterListComplete:(httpCompleteBlock)completeBlock
{
    NSString *chapterId = self.recentBook.chapters.lastObject.Id;
    [LNAPI updateBookChaptersWithBookId:self.recentBook._id chapterId:chapterId complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            completeBlock(result, cache, error);
        }
        else {
            NSArray *modelArray = [NSArray modelArrayWithClass:[LNBookChapter class] json:result];
            modelArray = [modelArray subarrayWithRange:NSMakeRange(1, modelArray.count - 1)];
            NSMutableArray *chapters = [NSMutableArray arrayWithArray:self.readerVc.dataArray];
            [chapters addObjectsFromArray:modelArray];
            self.recentBook.chapters = [chapters copy];
            [self saveLastRecentBook:self.recentBook];
            completeBlock(modelArray, cache, error);
        }
    }];
}

@end
