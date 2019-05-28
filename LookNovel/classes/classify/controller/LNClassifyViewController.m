//
//  LNClassifyViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyViewController.h"
#import "LNClassifyViewModel.h"
#import "LNClassifyGroupCell.h"
#import "LNClassifyGroupHeaderView.h"
#import "LNClassifyCell.h"

@interface LNClassifyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) LNClassifyViewModel *classifyVM;

@property (nonatomic, assign) BOOL autoScroll;

@end

@implementation LNClassifyViewController

- (LNClassifyViewModel *)classifyVM
{
    if (!_classifyVM) {
        _classifyVM = [[LNClassifyViewModel alloc] init];
        _classifyVM.classifyVc = self;
    }
    return _classifyVM;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"分类";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _autoScroll = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_search_gray_16x16_"] style:UIBarButtonItemStylePlain target:self action:@selector(startSearch)];
    
    self.classifyVM.leftTableView = [self setupTableView];
    self.classifyVM.leftTableView.frame = CGRectMake(0, 0, kScreenWidth * 0.2, self.view.height);
    self.classifyVM.rightCollectionView = [self setupCollectionView];
    self.classifyVM.rightCollectionView.frame = CGRectMake(kScreenWidth * 0.2, 0, kScreenWidth * 0.8, self.view.height);
    
    UIView *verDivider = [UIView new];
    verDivider.backgroundColor = UIColorHex(@"F8F8F8");
    [self.view addSubview:verDivider];
    verDivider.frame = CGRectMake(kScreenWidth * 0.2, 64 + kIPhoneX_TOP_HEIGHT, 1, self.view.height - (64 + kIPhoneX_TOP_HEIGHT));
    
    [self.classifyVM getAllClassify];
}

- (UITableView *)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.rowHeight = 60;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat bottomInset = 0;
    if (self.navigationController.childViewControllers.firstObject == self && self.navigationController.tabBarController) {
        bottomInset = CGRectGetHeight(self.navigationController.tabBarController.tabBar.frame);
    }
    tableView.contentInset = UIEdgeInsetsMake(kNaviHeight + 10, 0, bottomInset, 0);
    return tableView;
}

- (UICollectionView *)setupCollectionView
{
    CGFloat maxWidth = kScreenWidth * 0.8;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.headerReferenceSize = CGSizeMake(maxWidth, 50);
    layout.itemSize = CGSizeMake((maxWidth - 6 - 16) * 0.5, 60);
    layout.minimumLineSpacing = 12;
    layout.minimumInteritemSpacing = 6;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.backgroundView = nil;
    collectionView.showsVerticalScrollIndicator = NO;
    [collectionView registerClass:[LNClassifyGroupHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([LNClassifyGroupHeaderView class])];
    [self.view addSubview:collectionView];
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat bottomInset = 0;
    if (self.navigationController.childViewControllers.firstObject == self && self.navigationController.tabBarController) {
        bottomInset = CGRectGetHeight(self.navigationController.tabBarController.tabBar.frame);
    }
    collectionView.contentInset = UIEdgeInsetsMake(kNaviHeight, 8, bottomInset + kScreenHeight * 0.5, 8);
    collectionView.scrollIndicatorInsets = collectionView.contentInset;
    return collectionView;
}

- (void)startSearch
{
    [self.classifyVM startSearch];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classifyVM.leftDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNClassifyGroupModel *groupModel = [self.classifyVM.leftDataArray objectAtIndex:indexPath.row];
    LNClassifyGroupCell *cell = [LNClassifyGroupCell cellForTableView:tableView];
    cell.groupModel = groupModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _autoScroll = YES;
    [self.classifyVM changeGroupAtIndex:indexPath.row needScroll:YES];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.classifyVM.rightDataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = self.classifyVM.rightDataArray[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LNClassifyCell *cell = [LNClassifyCell cellForCollectionView:collectionView indexPath:indexPath];
    LNClassifyModel *model = self.classifyVM.rightDataArray[indexPath.section][indexPath.row];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LNClassifyGroupHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([LNClassifyGroupHeaderView class]) forIndexPath:indexPath];
        LNClassifyGroupModel *group = self.classifyVM.leftDataArray[indexPath.section];
        headerView.groupModel = group;
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.classifyVM clickItemAtIndexPath:indexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.classifyVM.rightCollectionView && _autoScroll == NO) {
        CGFloat xOffset = scrollView.width * 0.4;
        CGFloat yOffset = ABS(self.classifyVM.rightCollectionView.contentOffset.y) + kScreenHeight * 0.5;
        CGPoint orignP = CGPointMake(xOffset, yOffset);
        NSIndexPath *path = [self.classifyVM.rightCollectionView indexPathForItemAtPoint:orignP];
        if (path == nil) {
            return;
        }
        if (path.section < self.classifyVM.leftDataArray.count) {
            [self.classifyVM changeGroupAtIndex:path.section needScroll:NO];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.classifyVM.rightCollectionView) {
        _autoScroll = NO;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == self.classifyVM.rightCollectionView) {
        _autoScroll = NO;
    }
}
@end
