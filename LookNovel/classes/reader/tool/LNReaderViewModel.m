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

@property (nonatomic, weak) LNBookChapter *lastCurrentChapter;
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
        self.pageSize = 1.0;
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
    return (recentBook.chapters == nil);
}

- (void)loadBookContentComplete:(httpCompleteBlock)completeBlock
{
    if (![self isNewBook:self.recentBook]) {
        [self getBookContentComplete:completeBlock];
    }
    else {
        [self getAllChapterListComplete:^(id result, BOOL cache, NSError *error) {
            if (error == nil) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(11 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self getBookContentComplete:completeBlock];
                });
            }
            else {
                if (completeBlock) {
                    completeBlock(nil, cache, error);
                }
            }
        }];
    }
}

- (void)getAllChapterListComplete:(httpCompleteBlock)completeBlock
{
    if (self.recentBook.chapters) {
        if (completeBlock) {
            completeBlock(self.recentBook.chapters, YES, nil);
        }
        return;
    }
    [LNAPI getBookChaptersWithBookId:self.recentBook._id complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
            if (completeBlock) {
                completeBlock(nil, cache, error);
            }
        }
        else {
            NSArray *chapters = [NSArray modelArrayWithClass:[LNBookChapter class] json:result];
            self.recentBook.chapters = chapters;
            [self updateRecentBook];
            if (completeBlock) {
                completeBlock(chapters, cache, error);
            }
        }
    }];
}

- (void)getBookContentComplete:(httpCompleteBlock)completeBlock
{
    LNBookChapter *chapter = [self.recentBook.chapters objectAtIndex:self.recentBook.chapterIndex];
    self.lastCurrentChapter.isCurrent = NO;
    chapter.isCurrent = YES;
    self.lastCurrentChapter = chapter;
    if (chapter.content) {
        if (completeBlock) {
            completeBlock(@[chapter.content], YES, nil);
        }
        return;
    }
    [LNAPI getBookContentWithChapter:chapter.Id bookId:self.recentBook._id complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
            if (completeBlock) {
                completeBlock(nil, cache, error);
            }
        }
        else {
            LNBookContent *content = [LNBookContent modelWithJSON:result];
            chapter.content = content;
            [self handleContent:content];
            if (completeBlock) {
                completeBlock(@[content], cache, error);
            }
        }
    }];
}

- (void)changeChapter:(NSInteger)index complete:(httpCompleteBlock)complete
{
    if (index < 0 || index > self.recentBook.chapters.count - 1) {
        if (complete) {
            complete(nil, NO, nil);
        }
        return;
    }
    NSInteger lastIndex = self.recentBook.chapterIndex;
    self.recentBook.chapterIndex = index;
    [self getBookContentComplete:^(id result, BOOL cache, NSError *error) {
        if (index == 0) {
            [self hideRefreshHeader];
        }
        else if (index >= self.recentBook.chapters.count -1) {
            [self hideRefreshFooter];
        }
        else {
            [self showRefreshHeader];
            [self showRefreshFooter];
        }
        if (error) {
            self.recentBook.chapterIndex = lastIndex;
        }
        else {
            [self updateRecentBook];
        }
        if (complete) {
            complete(result, cache, error);
        }
    }];
}

- (void)handleContent:(LNBookContent *)contentArr
{
    contentArr.cellHeight = nil;
    NSString *body = [contentArr.content stringByReplacingRegex:@"/p&gt;" options:NSRegularExpressionCaseInsensitive withString:@""];
    
    NSAttributedString *chapterAttr = [[NSAttributedString alloc] initWithString:contentArr.name attributes:@{NSFontAttributeName:self.chapterFont,NSForegroundColorAttributeName:self.chapterColor}];
    contentArr.titleAttribute = chapterAttr;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = self.lineSpace;
    style.firstLineHeadIndent = self.font.xHeight * 4;
    NSDictionary *bodyAttribute =
                                @{NSFontAttributeName:self.font,
                                NSForegroundColorAttributeName:self.color,
                                NSParagraphStyleAttributeName:style};
    NSAttributedString *bodyAttr = [[NSAttributedString alloc] initWithString:body attributes:bodyAttribute];
    contentArr.bodyAttribute = bodyAttr;
}

- (void)updateRecentBook
{
    NSInteger idx = self.recentBook.chapterIndex;
    self.recentBook.readRatio = ((idx + 1) / ((float)self.recentBook.chapters.count)) * 100;
    self.recentBook.lastReadTime = [[NSDate date] stringWithFormat:@"yyyy-MM-dd HH:mm"];
    [self saveLastRecentBook:self.recentBook];
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
        for (LNBookContent *content in self.readerVc.dataArray) {
            [self handleContent:content];
            [self.readerVc.tableView reloadData];
            self.settingView.userInteractionEnabled = YES;
        }
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
