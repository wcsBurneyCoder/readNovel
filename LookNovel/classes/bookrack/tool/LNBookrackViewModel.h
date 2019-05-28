//
//  LNBookrackViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNAPI.h"
#import "LNBookrackViewController.h"
#import "LNRecommnadBook.h"
#import "LNBookrackRecentBookView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookrackViewModel : LNBaseViewModel

@property (nonatomic, weak) LNBookrackViewController *bookrackVc;
@property (nonatomic, weak) LNBookrackRecentBookView *bookView;
@property (nonatomic, weak) UIImageView *bgImageView;

- (void)getRecommandListComplete:(httpCompleteBlock)completeBlock;

- (void)loadRecentBook;

- (void)enterSearchBook;

- (void)beginReadBook:(LNRecommnadBook *)book;

- (void)continueRead:(LNRecentBook  * _Nullable )book;
@end

NS_ASSUME_NONNULL_END
