//
//  LNClassifyViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyViewModel.h"
#import "LNAPI.h"
#import "LNClassifyListViewController.h"
#import "LNSearchViewController.h"

@implementation LNClassifyViewModel

- (void)getAllClassify
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:nil];
    [LNAPI getAllClassifyListComplete:^(NSArray *result, BOOL cache, NSError *error) {
        NSArray *dataArray = @[];
        NSMutableArray *rightArray = [NSMutableArray array];
        if (result) {
            NSArray *groupArray = [NSArray modelArrayWithClass:[LNClassifyGroupModel class] json:result];
            LNClassifyGroupModel *first = (LNClassifyGroupModel *)groupArray.firstObject;
            first.selected = YES;
            self.lastGroupModel = first;
            dataArray = groupArray;
            for (LNClassifyGroupModel *grop in groupArray) {
                [rightArray addObject:grop.categories];
            }
        }
        
        self.leftDataArray = dataArray;
        self.rightDataArray = rightArray;
        [self reloadData];
        [MBProgressHUD dismissHUD];
    }];
}

- (void)changeGroupAtIndex:(NSInteger)index needScroll:(BOOL)need
{
    LNClassifyGroupModel *groupModel = self.leftDataArray[index];
    if (self.lastGroupModel == groupModel) {
        return;
    }
    groupModel.selected = YES;
    self.lastGroupModel.selected = NO;
    self.lastGroupModel = groupModel;
    [self.leftTableView reloadData];
    
    if (need) {
//        UICollectionReusableView *cell = [self.rightCollectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:1 inSection:index]];
//        CGFloat top = - self.rightCollectionView.contentInset.top;
//        if (cell) {
//            top = CGRectGetMinY(cell.frame) - self.rightCollectionView.contentInset.top + 10;
//        }
//        [self.rightCollectionView setContentOffset:CGPointMake(-self.rightCollectionView.contentInset.left, top) animated:YES];
        [self.rightCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

- (void)clickItemAtIndexPath:(NSIndexPath *)indexPath
{
    LNClassifyModel *model = self.rightDataArray[indexPath.section][indexPath.row];
    LNClassifyListViewController *listVc = [[LNClassifyListViewController alloc] init];
    listVc.categoryId = model.categoryId;
    listVc.itemName = model.categoryName;
    [self.classifyVc.navigationController pushViewController:listVc animated:YES];
}

- (void)reloadData
{
    [self.leftTableView reloadData];
    [self.rightCollectionView reloadData];
}

- (void)startSearch
{
    LNSearchViewController *searchVc = [[LNSearchViewController alloc] init];
    [self.classifyVc.navigationController pushViewController:searchVc animated:YES];
}
@end
