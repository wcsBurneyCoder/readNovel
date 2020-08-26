//
//  LNSearchResultViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNSearchResultViewModel.h"
#import "LNAPI.h"
#import "LNBookDetailViewController.h"

@implementation LNSearchResultViewModel

- (void)startSearchWithText:(NSString *)text page:(NSInteger)page pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock
{
    [LNAPI getSearchBooksWithKeyword:text page:page pageSize:pageSize complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
            completeBlock(result,cache,error);
        }
        else{
            NSArray *modelArray = [NSArray modelArrayWithClass:[LNClassifyBookModel class] json:result];
            completeBlock(modelArray,cache, error);
        }
    }];
}

- (void)enterBookDetailAtIndex:(NSInteger)index
{
    LNClassifyBookModel *model = [self.resultVc.dataArray objectAtIndex:index];
    LNBookDetailViewController *detailVc = [[LNBookDetailViewController alloc] init];
    detailVc.bookId = model._id;
    [self.resultVc.navigationController pushViewController:detailVc animated:YES];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *indexPath = [self.resultVc.tableView indexPathForRowAtPoint:location];
    LNClassifyBookModel *model = [self.resultVc.dataArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.resultVc.tableView cellForRowAtIndexPath:indexPath];
    LNBookDetailViewController *detailVc = [[LNBookDetailViewController alloc] init];
    detailVc.bookId = model._id;
    CGRect rect = cell.frame;
    previewingContext.sourceRect = rect;
    return detailVc;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self.resultVc.navigationController pushViewController:viewControllerToCommit animated:YES];
}
@end
