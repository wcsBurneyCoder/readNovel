//
//  LNReaderChapterListViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderChapterListViewController.h"
#import "LNReaderChapterListCell.h"

@interface LNReaderChapterListViewController ()

@end

@implementation LNReaderChapterListViewController

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
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.rowHeight = 60;
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView scrollToRow:self.currentIndex inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNBookChapter *chapter = [self.dataArray objectAtIndex:indexPath.row];
    LNReaderChapterListCell *cell = [LNReaderChapterListCell cellForTableView:tableView];
    chapter.isCurrent = indexPath.row == self.currentIndex;
    cell.chapter = chapter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNBookChapter *chapter = [self.dataArray objectAtIndex:indexPath.row];
    if (chapter.isVip) {
        [MBProgressHUD showMessageHUD:@"该章节是Vip章节，请更换小说源再试"];
        return;
    }
    if (self.didSelect) {
        self.didSelect(indexPath.row);
    }
}
@end
