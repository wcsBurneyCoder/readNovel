//
//  LNClassifyListViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyListViewModel.h"
#import "LNAPI.h"
#import "LNBookDetailViewController.h"
#import "LNReaderViewController.h"

@implementation LNClassifyListViewModel

- (NSInteger)pageSize
{
    return 20;
}

- (void)getBooksWithGroupId:(NSString *)groupId page:(NSInteger)page complete:(nonnull httpCompleteBlock)completeBlock
{
    [LNAPI getClassifyBooksWithGroupKey:groupId pageIndex:page pageSize:self.pageSize complete:^(NSArray *result, BOOL cache, NSError *error) {
        if (!error) {
            NSArray *modelArray = [NSArray modelArrayWithClass:[LNClassifyBookModel class] json:result];
            completeBlock(modelArray, cache, error);
        }
        else
            completeBlock(result, cache, error);
    }];
}

- (UIViewController *)mainVc
{
    return self.listVc;
}

- (void)enterBookDetailAtIndex:(NSInteger)index
{
    LNClassifyBookModel *model = [self.listVc.dataArray objectAtIndex:index];
    LNBookDetailViewController *detailVc = [[LNBookDetailViewController alloc] init];
    detailVc.bookId = model._id;
    [self.listVc.navigationController pushViewController:detailVc animated:YES];
//    [self startToReadBook:model];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    NSIndexPath *indexPath = [self.listVc.tableView indexPathForRowAtPoint:location];
    LNClassifyBookModel *model = [self.listVc.dataArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [self.listVc.tableView cellForRowAtIndexPath:indexPath];
    LNBookDetailViewController *detailVc = [[LNBookDetailViewController alloc] init];
    detailVc.bookId = model._id;
    CGRect rect = cell.frame;
    previewingContext.sourceRect = rect;
    return detailVc;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self.listVc.navigationController pushViewController:viewControllerToCommit animated:YES];
}
@end
