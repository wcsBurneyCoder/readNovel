//
//  LNHistoryViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNHistoryViewController.h"
#import "LNHistoryViewModel.h"
#import "LNHistoryCell.h"

@interface LNHistoryViewController ()
@property (nonatomic, strong) LNHistoryViewModel *historyVM;
@end

@implementation LNHistoryViewController

- (LNHistoryViewModel *)historyVM
{
    if (!_historyVM) {
        _historyVM = [[LNHistoryViewModel alloc] init];
        _historyVM.historyVc = self;
    }
    return _historyVM;
}

- (BOOL)hasRefreshHeader
{
    return NO;
}

- (BOOL)hasRefreshFooter
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated]; 
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 95;
    [self.historyVM loadHistoryData];
    
    @weakify(self)
    [[NSNotificationCenter defaultCenter] addObserverForName:LNUpdateRecentBookNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self)
        [self.historyVM loadHistoryData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNHistoryCell *cell = [LNHistoryCell cellForTableView:tableView];
    LNRecentBook *book = [self.dataArray objectAtIndex:indexPath.row];
    cell.book = book;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNRecentBook *book = [self.dataArray objectAtIndex:indexPath.row];
    [self.historyVM continueReadBook:book];
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UISwipeActionsConfiguration configurationWithActions:@[[UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        LNRecentBook *book = [self.dataArray objectAtIndex:indexPath.row];
        [self.historyVM deleteRecentBook:book];
        [self.dataArray removeObject:book];
        [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationTop];
        [[NSNotificationCenter defaultCenter] postNotificationName:LNUpdateRecentBookNotification object:nil];
        completionHandler(YES);
    }]]];
}


@end
