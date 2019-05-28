//
//  LNCollectionViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewController.h"
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNCollectionViewController : LNBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
/**数据源*/
@property (nonatomic,strong) NSMutableArray *dataArray;

#pragma mark override
/**布局*/
- (UICollectionViewLayout *)viewLayout;

- (BOOL)hasRefreshHeader;

- (BOOL)hasRefreshFooter;

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete;

- (void)setDataComplete;

#pragma mark -
//下拉刷新
- (void)loadData;
//上提刷新
- (void)loadMoreData;

- (NSInteger)pageSize;
@end

NS_ASSUME_NONNULL_END
