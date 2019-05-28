//
//  LNConst.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/8.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNConst.h"

#pragma mark -
NSString * const appThemeKey = @"appTheme";
NSString * const localStoragePath = @"system";
NSString * const recentBookKey = @"recentBook";
NSString * const LNUpdateRecentBookNotification = @"LNUpdateRecentBookNotification";
NSString * const LNShowReadIndicatorKey = @"showReadIndicator";
NSString * const LNReadModeKey = @"readMode";
NSString * const LNReaderSkinKey = @"readerSkin";
NSString * const LNReaderFontKey = @"readerFont";
NSString * const LNReaderBrightKey = @"readerBright";
NSString * const LNReaderNotLockKey = @"readerNotLock";
NSString * const LNLastAuthTimeKey = @"lastAuthTime";

NSString * documentFilePathWithCompentPath(NSString *path)
{
    path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:path];
    
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        NSString *pathStr = [path substringToIndex:range.location];
        if (![[NSFileManager defaultManager] fileExistsAtPath:pathStr]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:pathStr withIntermediateDirectories:YES attributes:nil error:NULL];
        }
    }
    return path;
}

NSString * cacheFilePathWithCompentPath(NSString *path)
{
    path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:path];
    
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        NSString *pathStr = [path substringToIndex:range.location];
        if (![[NSFileManager defaultManager] fileExistsAtPath:pathStr]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:pathStr withIntermediateDirectories:YES attributes:nil error:NULL];
        }
    }
    return path;
}

UIImage * defaultCoverImage(void)
{
    return [UIImage imageNamed:@"pic_noCover_88x122_"];
}

YYWebImageOptions defaultImageOptions(void)
{
    return (YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation);
}

