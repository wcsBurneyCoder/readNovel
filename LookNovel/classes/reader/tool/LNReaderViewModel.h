//
//  LNReaderViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNBookLinkSource.h"
#import "LNBookChapter.h"
#import "LNBookContent.h"
#import "LNReaderViewController.h"
#import "LNReaderTopControlView.h"
#import "LNReaderBottomControlView.h"
#import "LNReaderSettingView.h"

@interface LNReaderViewModel : LNBaseViewModel<LNReaderSettingViewDelegate>

@property (nonatomic, weak) LNReaderViewController *readerVc;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UIImageView *topView;
@property (nonatomic, weak) UILabel *topTitleLabel;
@property (nonatomic, weak) UIImageView *showImageView;
@property (nonatomic, weak) LNReaderTopControlView *topControlView;
@property (nonatomic, weak) UIView *rightContentView;
@property (nonatomic, weak) LNReaderBottomControlView *bottomControlView;
@property (nonatomic, weak) LNReaderSettingView *settingView;

/**当前的mode*/
@property (nonatomic, assign) LNReaderMode currentMode;

@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger chapterIndex;

@property (nonatomic, strong) LNBookLinkSource *currentSource;
@property (nonatomic, strong) LNBookChapter *currentChapter;

@property (nonatomic, strong) NSArray<LNBookLinkSource *> *sourceList;
/**当前源中是否含有vip章节*/
@property (nonatomic, assign, readonly) BOOL hasVipChapter;
@property (nonatomic, assign, readonly) NSInteger vipChapterIndex;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) BOOL notLock;
@property (nonatomic, assign) float currentBright;
@property (nonatomic, assign) CGFloat oldBright;

- (void)showIndicatorView;

- (BOOL)isNewBook:(LNRecentBook *)recentBook;

///获取书籍内容
- (void)loadBookContentWithBook:(LNRecentBook *)recentBook complete:(httpCompleteBlock)completeBlock;
///根据书Id获取第一章的内容
- (void)getBookFirstContentWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
///根据书Id获取所有的源列表
- (void)getAllSourceWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock;
///获取当前源的章节列表 currentSource必须设置
- (void)getAllChapterListComplete:(httpCompleteBlock)completeBlock;
///获取当前章节的文章 currentChapter必须设置
- (void)getBookContentpageIndex:(NSInteger)pageIndex complete:(httpCompleteBlock)completeBlock;
///切换源
- (void)changeSource:(LNBookLinkSource *)source complete:(httpCompleteBlock)complete;
///切换章节
- (void)changeChapter:(NSInteger)index complete:(httpCompleteBlock)complete;
///切换夜间和日间模式
- (void)changeMode;
///设置主题
- (void)setReaderSkin;
@end

