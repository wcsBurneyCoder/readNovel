//
//  LNConst.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/8.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LNReaderModeDay,  ///<日间模式
    LNReaderModeNight ///<夜间模式
} LNReaderMode;

#pragma mark -
UIKIT_EXTERN NSString * const appThemeKey;
UIKIT_EXTERN NSString * const localStoragePath;
UIKIT_EXTERN NSString * const recentBookKey;
UIKIT_EXTERN NSString * const LNUpdateRecentBookNotification;
UIKIT_EXTERN NSString * const LNShowReadIndicatorKey;
UIKIT_EXTERN NSString * const LNReadModeKey;
UIKIT_EXTERN NSString * const LNReaderSkinKey;
UIKIT_EXTERN NSString * const LNReaderFontKey;
UIKIT_EXTERN NSString * const LNReaderBrightKey;
UIKIT_EXTERN NSString * const LNReaderNotLockKey;
UIKIT_EXTERN NSString * const LNLastAuthTimeKey;

/**沙盒路径*/
NSString * documentFilePathWithCompentPath(NSString *path);
NSString * cacheFilePathWithCompentPath(NSString *path);
UIImage * defaultCoverImage(void);
YYWebImageOptions defaultImageOptions(void);

