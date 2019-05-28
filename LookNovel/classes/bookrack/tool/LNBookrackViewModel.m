//
//  LNBookrackViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookrackViewModel.h"
#import "LNReaderViewController.h"
#import "LNSearchViewController.h"

@implementation LNBookrackViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRecentBook:) name:LNUpdateRecentBookNotification object:nil];
    }
    return self;
}

- (void)getRecommandListComplete:(httpCompleteBlock)completeBlock
{
    [LNAPI getHomeRecommandListComplete:^(id  _Nullable result, BOOL cache, NSError * _Nullable error) {
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
        }
        else{
            NSMutableArray *modelArray = [NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[LNRecommnadBook class] json:result]];
//            LNRecommnadBook *addBook = [[LNRecommnadBook alloc] init];
//            addBook.cover = @"pic_shelf_import_90x120_";
//            [modelArray addObject:addBook];
            if (completeBlock) {
                completeBlock(modelArray, cache, error);
            }
        }
    }];
}

- (void)setBookView:(LNBookrackRecentBookView *)bookView
{
    _bookView = bookView;
    @weakify(self)
    [bookView setClickContinueBlock:^(LNBookrackRecentBookView * view) {
        @strongify(self)
        [self continueRead:view.recentBook];
    }];
}

- (void)continueRead:(LNRecentBook *)book
{
    if (book) {
        [self startToReadBook:book];
    }
    else{
       LNRecentBook *recentBook = [self getLastRecentBook];
        if (recentBook) {
            [self startToReadBook:recentBook];
        }
    }
}

- (void)loadRecentBook
{
    LNRecentBook *recentBook = [self getLastRecentBook];
    self.bookView.recentBook = recentBook;
    [self.bgImageView setImageWithURL:[NSURL URLWithString:recentBook.cover] placeholder:[UIImage imageNamed:@"pic_recent_default_375x210_"] options:defaultImageOptions() completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        UIImage *blurImage = [image imageByBlurRadius:25 tintColor:nil tintMode:0 saturation:1.0 maskImage:nil];
        self.bgImageView.image = blurImage;
    }];
}

- (void)enterSearchBook
{
    LNSearchViewController *searchVc = [[LNSearchViewController alloc] init];
    [self.bookrackVc.navigationController pushViewController:searchVc animated:YES];
}

- (void)beginReadBook:(LNRecommnadBook *)book
{
    [self startToReadBook:book];
}

- (void)updateRecentBook:(NSNotification *)notice
{
    [self loadRecentBook];
}

- (UIViewController *)mainVc
{
    return self.bookrackVc;
}

@end
