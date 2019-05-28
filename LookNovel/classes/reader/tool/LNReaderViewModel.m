//
//  LNReaderViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderViewModel.h"
#import "LNAPI.h"

@interface LNReaderViewModel ()

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) NSInteger lineSpace;
@property (nonatomic, strong) UIFont *chapterFont;
@property (nonatomic, strong) UIColor *chapterColor;

@property (nonatomic, strong) LNReaderSkin *pervSkin;
@end

@implementation LNReaderViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.font = [[NSUserDefaults standardUserDefaults] floatForKey:LNReaderFontKey] == 0?[UIFont systemFontOfSize:20.0]:[UIFont systemFontOfSize:[[NSUserDefaults standardUserDefaults] floatForKey:LNReaderFontKey]];
        self.color = UIColorHex(@"333333");
        self.chapterFont = [UIFont systemFontOfSize:self.font.pointSize + 4];
        self.chapterColor = self.color;
        self.lineSpace = 15;
        self.pageSize = 1;
        self.chapterIndex = 0;
        self.pervSkin = [LNSkinHelper sharedHelper].currentReaderSkin;
        self.currentMode = [self.pervSkin.Id isEqualToString:[LNSkinHelper sharedHelper].nightModeSkin.Id]?LNReaderModeNight:LNReaderModeDay;
        self.notLock = [[NSUserDefaults standardUserDefaults] boolForKey:LNReaderNotLockKey];
        self.oldBright = [UIScreen mainScreen].brightness;
        self.currentBright = [[NSUserDefaults standardUserDefaults] floatForKey:LNReaderBrightKey];
        if (self.currentBright == 0) {
            self.currentBright = [UIScreen mainScreen].brightness;
        }
       
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScreenBright:) name:UIScreenBrightnessDidChangeNotification object:nil];
    }
    return self;
}

- (void)showIndicatorView
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:LNShowReadIndicatorKey]){
        UIImageView *showImageView = [[UIImageView alloc] init];
        showImageView.contentMode = UIViewContentModeScaleAspectFill;
        showImageView.image = [UIImage imageNamed:@"pic_reader_guidance_750x1334_"];
        showImageView.frame = self.readerVc.view.bounds;
        [self.readerVc.view addSubview:showImageView];
        self.showImageView = showImageView;
        [self.readerVc.view bringSubviewToFront:showImageView];
        showImageView.userInteractionEnabled = YES;
        [showImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideIndicator)]];
    }
}

- (void)hideIndicator
{
    [self.showImageView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LNShowReadIndicatorKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isNewBook:(LNRecentBook *)recentBook
{
    return (recentBook.source == nil || recentBook.chapter == nil);
}

- (void)loadBookContentWithBook:(LNRecentBook *)recentBook complete:(httpCompleteBlock)completeBlock
{
    self.chapterIndex = 0;
    if ([self isNewBook:recentBook]) {
        //新书
        [self getBookFirstContentWithBookId:recentBook._id complete:completeBlock];
    }
    else{
        self.currentSource = recentBook.source;
        self.currentChapter = recentBook.chapter;
        __block BOOL hasVip = NO;
        __block NSInteger index = 0;
        [self.currentSource.chapterList enumerateObjectsUsingBlock:^(LNBookChapter * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.sort integerValue] == [self.currentChapter.sort integerValue]) {
                self.chapterIndex = idx;
            }
            if (obj.isVip) {
                hasVip = YES;
                index = idx + 1;
            }
            if (self.chapterIndex > 0 && obj.isVip) {
                *stop = YES;
            }
        }];
        self ->_hasVipChapter = hasVip;
        self ->_vipChapterIndex = index;
        [self changeSource:recentBook.source complete:^(NSArray<LNBookContent *>* result, BOOL cache, NSError *error) {
            if (self.currentChapter) {
                if ([self.currentChapter.sort integerValue] == 0) {
                    [self hideRefreshHeader];
                }
                else if(self.currentChapter.order == self.currentSource.chapterList.count){
                    [self hideRefreshFooter];
                }
                else{
                    [self showRefreshHeader];
                    [self showRefreshFooter];
                }
            }
            else{
                [self hideRefreshHeader];
                [self hideRefreshFooter];
            }
            completeBlock(result, cache, error);
        }];
    }
}

- (void)getBookFirstContentWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock
{
    @weakify(self)
    [self getAllSourceWithBookId:bookId complete:^(NSArray<LNBookLinkSource *>* sourceArr, BOOL cache, NSError *error) {
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
            if (completeBlock) {
                completeBlock(nil, cache, error);
            }
        }
        else{
            @strongify(self)
            self.currentSource = sourceArr.firstObject;
            @weakify(self)
            [self getAllChapterListComplete:^(NSArray<LNBookChapter *>* chapterArr, BOOL cache, NSError *error) {
                if (error) {
                    [MBProgressHUD showMessageHUD:error.domain];
                    if (completeBlock) {
                        completeBlock(nil, cache, error);
                    }
                }
                else{
                    @strongify(self)
                    self.currentChapter = chapterArr.firstObject;
                    [self updateRecentBook];
                    [self getBookContentpageIndex:0  complete:^(NSArray<LNBookContent *> *contentArr, BOOL cache, NSError *error) {
                        if (error) {
                            if (completeBlock) {
                                completeBlock(nil, cache, error);
                            }
                        }
                        else{
                            if (completeBlock) {
                                completeBlock(contentArr, cache, nil);
                            }
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)getAllSourceWithBookId:(NSString *)bookId complete:(httpCompleteBlock)completeBlock
{
    if (self.sourceList) {
        if (completeBlock) {
            completeBlock(self.sourceList, YES, nil);
        }
    }
    else{
        @weakify(self)
        [LNAPI getSourcesWithBookId:bookId complete:^(NSArray *result, BOOL cache, NSError *error) {
            if (error) {
                [MBProgressHUD showMessageHUD:error.domain];
                if (completeBlock) {
                    completeBlock(nil, cache, error);
                }
            }
            else{
                @strongify(self)
                NSArray *modelArray = [NSArray modelArrayWithClass:[LNBookLinkSource class] json:result];
                self.sourceList = modelArray;
                if (completeBlock) {
                    completeBlock(modelArray, cache, nil);
                }
            }
        }];
    }
}

- (void)getAllChapterListComplete:(httpCompleteBlock)completeBlock
{
    if (self.currentSource.chapterList) {
        if (completeBlock) {
            completeBlock(self.currentSource.chapterList, YES, nil);
        }
    }
    else{
        @weakify(self)
        [LNAPI getBookChaptersWithsourceId:self.currentSource._id complete:^(id result, BOOL cache, NSError *error) {
            if (error) {
                [MBProgressHUD showMessageHUD:error.domain];
                if (completeBlock) {
                    completeBlock(nil, cache, error);
                }
            }
            else{
                @strongify(self)
                NSArray *array = [result objectForKey:@"chapters"];
                NSArray *modelArray = [NSArray modelArrayWithClass:[LNBookChapter class] json:array];
                self.currentSource.chapterList = modelArray;
                BOOL hasVip = NO;
                NSInteger idx = 1;
                for (LNBookChapter *chapter in modelArray) {
                    if (chapter.isVip) {
                        hasVip = YES;
                        break;
                    }
                    idx ++;
                }
                self ->_hasVipChapter = hasVip;
                self ->_vipChapterIndex = idx;
                if (completeBlock) {
                    completeBlock(modelArray, cache, nil);
                }
            }
        }];
    }
}

- (void)getBookContentpageIndex:(NSInteger)pageIndex complete:(httpCompleteBlock)completeBlock
{
    NSMutableArray *chapterArr = [NSMutableArray arrayWithCapacity:self.pageSize];
    NSInteger max = MIN(self.pageSize, self.currentSource.chapterList.count - pageIndex);
    BOOL allCache = YES;
    for (NSInteger i = pageIndex; i < (pageIndex + max); i ++) {
        LNBookChapter *chapter = self.currentSource.chapterList[i];
        chapter.sort = @(i);
        if (chapter.content) {
            [chapterArr addObject:chapter];
        }
        else{
            allCache = NO;
            @weakify(self)
            @weakify(chapter)
            [LNAPI getBookContentWithChapter:chapter.link complete:^(id result, BOOL cache, NSError *error) {
                if (error) {
                    [MBProgressHUD showMessageHUD:error.domain];
                    if (completeBlock) {
                        completeBlock(nil, cache, error);
                    }
                }
                else{
                    @strongify(self)
                    @strongify(chapter)
                    NSDictionary *chapterDict = [result objectForKey:@"chapter"];
                    LNBookContent *content = [LNBookContent modelWithDictionary:chapterDict];
                    content.title = chapter.title;
                    content.chapterOrder = [chapter.sort integerValue];
                    chapter.content = content;
                    [chapterArr addObject:chapter];
                    if (chapterArr.count == self.pageSize) {
                        [chapterArr sortUsingComparator:^NSComparisonResult(LNBookChapter *obj1, LNBookChapter *obj2) {
                            return [obj1.sort integerValue] > [obj2.sort integerValue];
                        }];
                        NSMutableArray *contentArr = [NSMutableArray arrayWithCapacity:self.pageSize];
                        for (LNBookChapter *cha in chapterArr) {
                            [contentArr addObject:cha.content];
                        }
                        [self handleContent:contentArr complete:^(NSArray<LNBookContent *> *resultArr) {
                            if (completeBlock) {
                                completeBlock(contentArr, NO, nil);
                            }
                        }];
                    }
                }
            }];
        }
    }
    if (allCache) {
        [chapterArr sortUsingComparator:^NSComparisonResult(LNBookChapter *obj1, LNBookChapter *obj2) {
            return [obj1.sort integerValue] > [obj2.sort integerValue];
        }];
        NSMutableArray *contentArr = [NSMutableArray arrayWithCapacity:self.pageSize];
        for (LNBookChapter *cha in chapterArr) {
            [contentArr addObject:cha.content];
        }
        [self handleContent:contentArr complete:^(NSArray<LNBookContent *> *resultArr) {
            if (completeBlock) {
                completeBlock(contentArr, NO, nil);
            }
        }];
    }
}

- (void)changeSource:(LNBookLinkSource *)source complete:(httpCompleteBlock)complete
{
    if (self.sourceList) {
        //内部切换
        if ([source._id isEqualToString:self.currentSource._id]) {
            if (complete) {
                complete(self.readerVc.dataArray, YES, nil);
            }
            return;
        }
    }
    NSInteger currentChapterIndex = [self.currentSource.chapterList indexOfObject:self.currentChapter];
    self.currentChapter = nil;
    self.currentSource = source;
    @weakify(self)
    [self getAllChapterListComplete:^(NSArray<LNBookChapter *> *result, BOOL cache, NSError *error) {
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
        }
        else{
            @strongify(self)
            NSInteger pageIndex = 0;
            if (currentChapterIndex <= (result.count - 1)) {
                self.currentChapter = [result objectAtIndex:currentChapterIndex];
                pageIndex = currentChapterIndex;
            }
            else{
                self.currentChapter = result.lastObject;
                pageIndex = result.count - 1;
            }
            [self updateRecentBook];
            self.chapterIndex = pageIndex;
            [self getBookContentpageIndex:pageIndex  complete:^(NSArray<LNBookContent *>*resultArr, BOOL cache, NSError *error) {
                if (complete) {
                    complete(resultArr, cache, error);
                }
            }];
        }
    }];
}

- (void)changeChapter:(NSInteger)index complete:(httpCompleteBlock)complete
{
    LNBookChapter *chapter = [self.currentSource.chapterList objectAtIndex:index];
    if (chapter.isVip) {
        if (complete) {
            complete(nil,NO,[NSError errorWithDomain:@"下一章节为付费章节，请切换小说源再试" code:-1 userInfo:nil]);
        }
        return;
    }
    self.currentChapter = chapter;
    self.chapterIndex = index;
    [self updateRecentBook];
    [self getBookContentpageIndex:index complete :^(NSArray< LNBookContent *> *resultArr, BOOL cache, NSError *error) {
        if (self.currentChapter) {
            if (self.currentChapter.order == 1) {
                [self hideRefreshHeader];
            }
            else if(self.currentChapter.order == self.currentSource.chapterList.count){
                [self hideRefreshFooter];
            }
            else{
                [self showRefreshHeader];
                [self showRefreshFooter];
            }
        }
        else{
            [self hideRefreshHeader];
            [self hideRefreshFooter];
        }
        if (complete) {
            complete(resultArr, cache, nil);
        }
    }];
}

- (void)handleContent:(NSArray<LNBookContent *> *)contentArr complete:(void(^)(NSArray< LNBookContent *> *resultArr))complete
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (LNBookContent *content in contentArr) {
            content.cellHeight = nil;
            NSString *body = [content.body stringByReplacingRegex:@"\\n\\n" options:NSRegularExpressionCaseInsensitive withString:@"\n"];
            body = [body stringByReplacingRegex:@"\\t" options:NSRegularExpressionCaseInsensitive withString:@""];
            
            NSAttributedString *chapterAttr = [[NSAttributedString alloc] initWithString:content.title attributes:@{NSFontAttributeName:self.chapterFont,NSForegroundColorAttributeName:self.chapterColor}];
            content.titleAttribute = chapterAttr;
            
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = self.lineSpace;
            style.firstLineHeadIndent = self.font.xHeight * 4;
            NSDictionary *bodyAttribute =
                                        @{NSFontAttributeName:self.font,
                                        NSForegroundColorAttributeName:self.color,
                                        NSParagraphStyleAttributeName:style};
            NSAttributedString *bodyAttr = [[NSAttributedString alloc] initWithString:body attributes:bodyAttribute];
            content.bodyAttribute = bodyAttr;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(contentArr);
            }
        });
    });
}

- (void)updateRecentBook
{
    LNRecentBook *recentBook = [self getLastRecentBook];
    recentBook.chapter = self.currentChapter;
    recentBook.source = self.currentSource;
    NSInteger idx = [self.currentSource.chapterList indexOfObject:self.currentChapter];
    recentBook.readRatio = ((idx + 1) / (float)self.currentSource.chapterList.count) * 100;
    recentBook.lastReadTime = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"];
    [self saveLastRecentBook:recentBook];
    [[NSNotificationCenter defaultCenter] postNotificationName:LNUpdateRecentBookNotification object:nil];
}

- (void)hideRefreshHeader
{
    self.readerVc.tableView.mj_header.hidden = YES;
}

- (void)showRefreshHeader
{
    self.readerVc.tableView.mj_header.hidden = NO;
}

- (void)hideRefreshFooter
{
    self.readerVc.tableView.mj_footer.hidden = YES;
}

- (void)showRefreshFooter
{
    self.readerVc.tableView.mj_footer.hidden = NO;
}

- (void)changeMode
{
    LNReaderSkin *skin = nil;
    if (self.currentMode == LNReaderModeDay) {
        self.currentMode = LNReaderModeNight;
        skin = [LNSkinHelper sharedHelper].nightModeSkin;
        [self.settingView cancelAllSelect];
    }
    else{
        self.currentMode = LNReaderModeDay;
        skin = self.pervSkin;
    }
    [LNSkinHelper sharedHelper].currentReaderSkin = skin;
    [[LNSkinHelper sharedHelper] saveCurrentReaderSkin];
    [self setReaderSkin];
}

- (void)setReaderSkin
{
    LNReaderSkin *skin = [LNSkinHelper sharedHelper].currentReaderSkin;
    if (skin.bgImage.length) {
        self.bgImageView.image = [UIImage imageNamed:skin.bgImage];
        UIImage *topImage =  [[UIImage imageNamed:skin.bgImage] imageByResizeToSize:self.topView.size contentMode:UIViewContentModeTop];
        self.topView.image = topImage;
    }
    else{
        self.bgImageView.image = [UIImage imageWithColor:UIColorHex(skin.color)];
        self.topView.image = nil;
        self.topView.backgroundColor = UIColorHex(skin.color);
    }
    self.topTitleLabel.textColor = UIColorHex(skin.textColor);
    self.rightContentView.backgroundColor = UIColorHex(skin.controlViewBgColor);
    self.settingView.skin = skin;
    self.bottomControlView.skin = skin;
    self.topControlView.skin = skin;
    
    self.color = UIColorHex(skin.textColor);
    self.chapterColor = self.color;
    
    if (self.readerVc.dataArray.count) {
        [self handleContent:self.readerVc.dataArray complete:^(NSArray<LNBookContent *> *resultArr) {
            self.readerVc.dataArray = [NSMutableArray arrayWithArray:resultArr];
            [self.readerVc.tableView reloadData];
            self.settingView.userInteractionEnabled = YES;
        }];
    }
}

#pragma mark - LNReaderSettingViewDelegate
- (void)settingViewDidClickSkinAtIndex:(NSInteger)index
{
    self.settingView.userInteractionEnabled = NO;
    LNReaderSkin *skin = [[LNSkinHelper sharedHelper].readerSkinList objectOrNilAtIndex:index];
    [LNSkinHelper sharedHelper].currentReaderSkin = skin;
    self.pervSkin = skin;
    [[LNSkinHelper sharedHelper] saveCurrentReaderSkin];
    self.currentMode = LNReaderModeDay;
    [self setReaderSkin];
}

- (void)settingViewDidChangeFontSize:(float)size
{
    self.settingView.userInteractionEnabled = NO;
    if (size <= 12) {
        size = 12;
    }
    else if (size >= 42)
        size = 42;
    self.settingView.fontSize = size;
    self.font = [UIFont systemFontOfSize:size];
    self.chapterFont = [UIFont systemFontOfSize:self.font.pointSize + 4];
    [self setReaderSkin];
    [[NSUserDefaults standardUserDefaults] setFloat:size forKey:LNReaderFontKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)settingViewDidChangeBright:(float)bright
{
    self.currentBright = bright;
    [UIScreen mainScreen].brightness = bright;
    [[NSUserDefaults standardUserDefaults] setFloat:bright forKey:LNReaderBrightKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)settingViewDidChangeSwitch:(BOOL)on
{
    [UIApplication sharedApplication].idleTimerDisabled = on;
    [[NSUserDefaults standardUserDefaults] setBool:on forKey:LNReaderNotLockKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)changeScreenBright:(NSNotification *)notice
{
    self.oldBright = [UIScreen mainScreen].brightness;
    [self settingViewDidChangeBright:self.oldBright];
    [self.settingView setBright:self.currentBright];
}
@end
