//
//  LNBaseViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNRecentBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBaseViewModel : NSObject
/**依赖的主vc*/
@property (nonatomic, weak) UIViewController *mainVc;

///获取浏览记录
- (NSArray <LNRecentBook *> *)getRecentBook;
///保存最新浏览记录
- (void)saveLastRecentBook:(LNRecentBook *)book;
///获取最新浏览记录
- (LNRecentBook *)getLastRecentBook;
///获取最新浏览记录
- (LNRecentBook *)getLastRecentBookFromGroup;
///开始阅读
- (void)startToReadBook:(LNBook *)book;

- (void)deleteRecentBook:(LNRecentBook *)book;

@end

NS_ASSUME_NONNULL_END
