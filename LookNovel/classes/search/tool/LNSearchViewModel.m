//
//  LNSearchViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNSearchViewModel.h"
#import "LNAPI.h"
#import "LNSearchSuggestCell.h"
#import "LNSearchResultViewController.h"
#import "LNBookDetailViewController.h"

@interface LNSearchViewModel ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UIControl *maskView;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation LNSearchViewModel

- (UIControl *)maskView
{
    if (_maskView) {
        return _maskView;
    }
    UIControl *control = [[UIControl alloc] init];
    control.backgroundColor = [UIColorHex(@"000000") colorWithAlphaComponent:0.3];
    control.frame = CGRectMake(0, 64 + kIPhoneX_TOP_HEIGHT, kScreenWidth, kScreenHeight - (64 + kIPhoneX_TOP_HEIGHT));
    control.alpha = 0;
    [control addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.searchVc.view addSubview:control];
    _maskView = control;
    return _maskView;
}

- (UITableView *)tableView
{
    if (_tableView) {
        return _tableView;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + kIPhoneX_TOP_HEIGHT, kScreenWidth, kScreenHeight - (64 + kIPhoneX_TOP_HEIGHT)) style:UITableViewStylePlain];
    tableView.hidden = YES;
    tableView.rowHeight = 50;
    tableView.tableFooterView = [UIView new];
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
        self.searchVc.automaticallyAdjustsScrollViewInsets = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.searchVc.view addSubview:tableView];
    _tableView = tableView;
    return _tableView;
}

- (void)cancelSearch
{
    [self.searchBar resignFirstResponder];
}

- (void)startSearch:(NSString *)text
{
    [self cancelSearch];
    LNSearchResultViewController *resultVc = [[LNSearchResultViewController alloc] init];
    resultVc.searchText = text;
    [self.searchVc.navigationController pushViewController:resultVc animated:NO];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    self.maskView.alpha = 0;
    self.tableView.hidden = self.tipArray.count == 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 1;
    }];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    self.tableView.hidden = self.tipArray.count == 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 0;
    }];
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self getSuggestListWithKeyword:searchText complete:^(id result, BOOL cache, NSError *error) {
        self.tipArray = result;
        self.tableView.hidden = self.tipArray.count == 0;
        [self.tableView reloadData];
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self cancelSearch];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self startSearch:searchBar.text];
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tipArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNSearchSuggestCell *cell = [LNSearchSuggestCell cellForTableView:tableView];
    LNSuggest *suggest = self.tipArray[indexPath.row];
    cell.suggest = suggest;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNSuggest *suggest = self.tipArray[indexPath.row];
    if (suggest.type == LNSuggestTypeNormal || suggest.type == LNSuggestTypeAuthor) {
        [self startSearch:suggest.text];
    }
    else if (suggest.type == LNSuggestTypeBook) {
        LNBookDetailViewController *detailVc = [[LNBookDetailViewController alloc] init];
        detailVc.bookId = suggest.Id;
        [self.searchVc.navigationController pushViewController:detailVc animated:YES];
    }
}

#pragma mark -
- (void)getSuggestListWithKeyword:(NSString *)keyword complete:(httpCompleteBlock)completeBlock
{
    [LNAPI getSearchTipsWithKeyword:keyword complete:^(NSArray *result, BOOL cache, NSError *error) {
        if (error) {
            completeBlock(nil, cache, error);
        }
        else{
            NSArray *modelArray = [NSArray modelArrayWithClass:[LNSuggest class] json:result];
            for (LNSuggest *suggest in modelArray) {
                if ([suggest.tag isEqualToString:@"tag"]) {
                    suggest.type = LNSuggestTypeNormal;
                    suggest.iconName = @"search_icon_label_16_16_16x16_";
                }
                else if ([suggest.tag isEqualToString:@"bookauthor"]){
                    suggest.type = LNSuggestTypeAuthor;
                    suggest.iconName = @"search_icon_author_16_16_16x16_";
                }
                else if ([suggest.tag isEqualToString:@"bookname"]){
                    suggest.type = LNSuggestTypeBook;
                    suggest.iconName = @"search_icon_book_16_16_16x16_";
                }
            }
            completeBlock(modelArray, cache, error);
        }
    }];
}
@end
