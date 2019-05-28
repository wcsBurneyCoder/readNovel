//
//  LNTableViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewController.h"
#import <MJRefresh/MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNTableViewController : LNBaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
/**数据源*/
@property (nonatomic,strong) NSMutableArray *dataArray;

#pragma mark override
- (UITableViewStyle)tableViewStyle;

- (BOOL)hasRefreshHeader;

- (BOOL)hasRefreshFooter;

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete; 

- (void)setDataComplete;

- (float)pageSize;

#pragma mark -
//下拉刷新
- (void)loadData;
//上提刷新
- (void)loadMoreData;
@end

NS_ASSUME_NONNULL_END
