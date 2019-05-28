//
//  LNBookDetailViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNBookDetailViewController.h"
#import "LNBookDetail.h"
#import "LNBookDetailInfoView.h"
#import "LNBookDetailIntroView.h"
#import "LNBookDetailBottomView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookDetailViewModel : LNBaseViewModel<LNBookDetailIntroViewDelegate>

@property (nonatomic, weak) LNBookDetailViewController *detailVc;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) LNBookDetailInfoView *infoView;
@property (nonatomic, weak) LNBookDetailIntroView *introView;
@property (nonatomic, weak) LNBookDetailBottomView *bottomView;

@property (nonatomic, strong) LNBookDetail *detail;

- (void)loadDetailData;

- (void)startReadBook;
@end

NS_ASSUME_NONNULL_END
