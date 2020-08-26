//
//  LNBookDetailViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookDetailViewModel.h"
#import "LNAPI.h"
#import "NSDate+LNAdd.h"
#import "LNChapterListViewController.h"

@implementation LNBookDetailViewModel

- (void)loadDetailData
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:self.detailVc.view];
    [LNAPI getBookDetailWithId:self.detailVc.bookId complete:^(id result, BOOL cache, NSError *error) {
        [MBProgressHUD dismissHUDInView:self.detailVc.view];
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
        }
        else{
            LNBookDetail *detail = [LNBookDetail modelWithDictionary:result];
            self.detail = detail;
            [self setupData];
        }
    }];
}

- (void)setupData
{
    self.infoView.detail = self.detail;
    self.introView.detail = self.detail;
    self.scrollView.hidden = NO;
    self.bottomView.hidden = NO;
}

- (void)startReadBook
{
    [self startToReadBook:self.detail];
}

- (UIViewController *)mainVc
{
    return self.detailVc;
}

#pragma mark - LNBookDetailIntroViewDelegate
- (void)introViewDidClickChapterList:(LNBookDetailIntroView *)view
{
//    LNChapterListViewController *listVc = [[LNChapterListViewController alloc] init];
//    [self.detailVc.navigationController pushViewController:listVc animated:YES];
}
@end
