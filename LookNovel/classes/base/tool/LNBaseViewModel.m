//
//  LNBaseViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNReaderViewController.h"

static YYCache *localStorageCache_;

@implementation LNBaseViewModel

- (NSURL *)pathForGroupLocalStorage
{
    NSString *groupID = @"group.com.wcs.lookNovel";
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:groupID];
    containerURL = [containerURL URLByAppendingPathComponent:@"Library/Caches/recentBook"];
    return containerURL;
}

- (YYCache *)localStorageCache
{
    if (!localStorageCache_) {
        localStorageCache_ = [YYCache cacheWithPath:documentFilePathWithCompentPath(localStoragePath)];
    }
    return localStorageCache_;
}

- (NSArray<LNRecentBook *> *)getRecentBook
{
    YYCache *cache = [self localStorageCache];
    NSArray *array = (NSArray *)[cache objectForKey:recentBookKey];
    return array;
}

- (void)saveLastRecentBook:(LNRecentBook *)book
{
    if (book == nil) {
        return;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        YYCache *cache = [self localStorageCache];
        NSMutableArray *arrayM = [NSMutableArray arrayWithArray:[self getRecentBook]];
        if (book != arrayM.lastObject) {
            if ([arrayM containsObject:book]) {
                [arrayM removeObject:book];
                [arrayM addObject:book];
            }
            else {
                [arrayM addObject:book];
            }
        }
        [cache setObject:[arrayM copy] forKey:recentBookKey];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrayM];
        [data writeToURL:[self pathForGroupLocalStorage] atomically:YES];
    });
}

- (LNRecentBook *)getLastRecentBook
{
    return [self getRecentBook].lastObject;
}

- (LNRecentBook *)getLastRecentBookFromGroup
{
    NSData *data = [NSData dataWithContentsOfURL:[self pathForGroupLocalStorage]];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array.lastObject;
}

- (void)deleteRecentBook:(LNRecentBook *)book
{
    NSMutableArray<LNRecentBook *>*books = [NSMutableArray arrayWithArray:[self getRecentBook]];
    if ([books containsObject:book]) {
        [books removeObject:book];
        YYCache *cache = [self localStorageCache];
        [cache setObject:[books copy] forKey:recentBookKey];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:books];
        [data writeToURL:[self pathForGroupLocalStorage] atomically:YES];
    }
}

- (void)startToReadBook:(LNBook *)book
{
    LNRecentBook *recentBook = nil;
    if ([book isKindOfClass:[LNRecentBook class]]) {
        recentBook = (LNRecentBook *)book;
       
    }
    else {
        LNRecentBook *recent = [[LNRecentBook alloc] init];
        recent.title = book.title;
        recent._id = book._id;
        recent.cover = book.cover;
        recent.chapterIndex = 0;
        recent.readRatio = 0;
        recentBook = recent;
    }
    LNReaderViewController *readerVc = [[LNReaderViewController alloc] init];
    readerVc.recentBook = recentBook;
    if (self.mainVc.navigationController) {
        [self.mainVc.navigationController pushViewController:readerVc animated:YES];
    }
    else{
        UINavigationController *navi = (UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController;
        [navi pushViewController:readerVc animated:YES];
    }
}
@end
