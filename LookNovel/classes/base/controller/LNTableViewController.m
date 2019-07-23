//
//  LNTableViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTableViewController.h"

@interface LNTableViewController ()

@end

@implementation LNTableViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableViewStyle style = [self tableViewStyle];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = nil;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat bottomInset = 0;
    if (self.navigationController.childViewControllers.firstObject == self && self.navigationController.tabBarController) {
        bottomInset = CGRectGetHeight(self.navigationController.tabBarController.tabBar.frame);
    }
    _tableView.contentInset = UIEdgeInsetsMake(kNaviHeight, 0, bottomInset, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    if (self.hasRefreshHeader) {
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    }
    if (self.hasRefreshFooter) {
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
}

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

#pragma mark override

- (BOOL)hasRefreshFooter
{
    return YES;
}

- (BOOL)hasRefreshHeader
{
    return YES;
}

- (NSInteger)pageSize
{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

//下拉刷新
- (void)loadData
{
    [self loadDataWithPageIndex:0 pageSize:[self pageSize] complete:^(id result, BOOL cache, NSError *error) {
        [self refreshComplete:result error:error isHeader:YES];
    }];
}
//上提刷新
- (void)loadMoreData
{
    NSInteger pageIndex = self.dataArray.count;
    
    [self loadDataWithPageIndex:pageIndex pageSize:[self pageSize] complete:^(id result, BOOL cache, NSError *error) {
        [self refreshComplete:result error:error isHeader:NO];
        
    }];
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete
{
    
}

- (void)refreshComplete:(id)result error:(NSError *)error isHeader:(BOOL)header
{
    if ([result isKindOfClass:[NSArray class]]) {
        if (header) {
            self.dataArray = [result mutableCopy];
            [self.tableView.mj_header endRefreshing];
            if ([result count] < [self pageSize]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [self.tableView.mj_footer resetNoMoreData];
            }
        }
        else{
            [self.dataArray addObjectsFromArray:result];
            if ([result count] < [self pageSize]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else {
                [self.tableView.mj_footer endRefreshing];
            }
        }
    }
    else if(result){
        LNLog(@"数据错误");
        if (header) {
            [self.tableView.mj_header endRefreshing];
        }
        else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    else if (error){
        LNLog(@"%@",error.domain);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        }
        else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    else{
        if (header) {
            [self.tableView.mj_header endRefreshing];
        }
        else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
    if ([self respondsToSelector:@selector(setDataComplete)]) {
        [self setDataComplete];
    }
    [self.tableView reloadData];
}

@end
