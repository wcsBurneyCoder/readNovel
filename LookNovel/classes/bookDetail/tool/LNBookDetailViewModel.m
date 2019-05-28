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
            [self handleData];
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

- (void)handleData
{
    NSDate *date = [NSDate dateWithString:self.detail.updated format:@"yyyy-MM-dd'T'HH:mm:ss.SSSX"];
    NSInteger hours = [NSDate numberOfHoursWithFromDate:date toDate:[NSDate date]];
    if (hours > 24) {
        hours = hours / 24;
        self.detail.updated = [NSString stringWithFormat:@"%ld天前更新",hours];
    }
    else
        self.detail.updated = [NSString stringWithFormat:@"%ld小时前更新",hours];
    
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.detail.longIntro attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorHex(@"666666")}];
    self.detail.longIntroAttribute = attribute;
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
