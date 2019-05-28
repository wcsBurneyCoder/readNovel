//
//  LNReaderScourceListViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderScourceListViewController.h"
#import "LNReaderSourceListCell.h"

@interface LNReaderScourceListViewController ()

@end

@implementation LNReaderScourceListViewController

- (BOOL)hasRefreshFooter
{
    return NO;
}

- (BOOL)hasRefreshHeader
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 60;
    
    self.tableView.contentInset = UIEdgeInsetsZero;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNBookLinkSource *source = [self.dataArray objectAtIndex:indexPath.row];
    LNReaderSourceListCell *cell = [LNReaderSourceListCell cellForTableView:tableView];
    source.isCurrent = indexPath.row == self.currentIndex;
    cell.source = source;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNBookLinkSource *source = [self.dataArray objectAtIndex:indexPath.row];
    if (self.didSelect) {
        self.didSelect(source);
    }
}

@end
