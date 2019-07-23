//
//  LNCollectionViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNCollectionViewController.h"

@interface LNCollectionViewController ()

@end

@implementation LNCollectionViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (BOOL)hasRefreshFooter
{
    return YES;
}

- (BOOL)hasRefreshHeader
{
    return YES;
}

- (UICollectionViewLayout *)viewLayout
{
    return [[UICollectionViewFlowLayout alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self viewLayout]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.backgroundView = nil;
    collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat bottomInset = 0;
    if (self.navigationController.childViewControllers.firstObject == self && self.navigationController.tabBarController) {
        bottomInset = CGRectGetHeight(self.navigationController.tabBarController.tabBar.frame);
    }
    _collectionView.contentInset = UIEdgeInsetsMake(kNaviHeight, 0, bottomInset, 0);
    _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
    
    _collectionView.alwaysBounceVertical = YES;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (self.hasRefreshHeader) {
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    if (self.hasRefreshFooter) {
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
}

- (NSInteger)pageSize
{
    return 10;
}

#pragma mark - UICollectionDelegate
#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

//下拉刷新
- (void)loadData
{
    [self loadDataWithPageIndex:0 pageSize:[self pageSize] complete:^(id  _Nullable result, BOOL cache, NSError * _Nullable error){
        [self refreshComplete:result error:error isHeader:YES];
    }];
}
//上提刷新
- (void)loadMoreData
{
    NSInteger pageIndex = [self.dataArray count];
    
    [self loadDataWithPageIndex:pageIndex pageSize:[self pageSize] complete:^(id  _Nullable result, BOOL cache, NSError * _Nullable error) {
        [self refreshComplete:result error:error isHeader:NO];
    }];
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete{}

- (void)refreshComplete:(id)result error:(NSError *)error isHeader:(BOOL)header
{
    if ([result isKindOfClass:[NSArray class]]) {
        if (header) {
            self.dataArray = [result mutableCopy];
            [self.collectionView.mj_header endRefreshing];
            if ([result count] < [self pageSize]) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [self.collectionView.mj_footer resetNoMoreData];
            }
        }
        else{
            [self.dataArray addObjectsFromArray:result];
            if ([result count] < [self pageSize]) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            else {
                [self.collectionView.mj_footer endRefreshing];
            }
        }
    }
    else if(result){
        LNLog(@"数据错误");
        if (header) {
            [self.collectionView.mj_header endRefreshing];
        }
        else{
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    else if (error){
        LNLog(@"%@",error.domain);
        if (header) {
            [self.collectionView.mj_header endRefreshing];
        }
        else{
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    else{
        if (header) {
            [self.collectionView.mj_header endRefreshing];
        }
        else{
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    if ([self respondsToSelector:@selector(setDataComplete)]) {
        [self setDataComplete];
    }
    [self.collectionView reloadData];
}

- (void)setDataComplete{}

@end
