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

@property (nonatomic, strong) LNRecentBook *recentBook;
/**当前的mode*/
@property (nonatomic, assign) LNReaderMode currentMode;

@property (nonatomic, assign) NSInteger pageSize;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) BOOL notLock;
@property (nonatomic, assign) float currentBright;
@property (nonatomic, assign) CGFloat oldBright;

- (void)showIndicatorView;

///获取书籍内容
- (void)loadBookContentComplete:(httpCompleteBlock)completeBlock;
///获取当前源的章节列表 currentSource必须设置
- (void)getAllChapterListComplete:(httpCompleteBlock)completeBlock;
///切换章节
- (void)changeChapter:(NSInteger)index complete:(httpCompleteBlock)complete;
///切换夜间和日间模式
- (void)changeMode;
///设置主题
- (void)setReaderSkin;
@end

