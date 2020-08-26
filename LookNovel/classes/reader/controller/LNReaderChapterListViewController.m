//
//  LNReaderChapterListViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderChapterListViewController.h"
#import "LNReaderChapterListCell.h"
#import "LNAPI.h"
#import "LNChapterListViewModel.h"

@interface LNReaderChapterListViewController ()
@property (nonatomic, strong) LNChapterListViewModel *chapterVM;
@end

@implementation LNReaderChapterListViewController

- (LNChapterListViewModel *)chapterVM
{
    if (!_chapterVM) {
        _chapterVM = [[LNChapterListViewModel alloc] init];
        _chapterVM.readerVc = self;
    }
    return _chapterVM;;
}

//- (BOOL)hasRefreshFooter
//{
//    return NO;
//}

- (BOOL)hasRefreshHeader
{
    return NO;
}

- (void)setRecentBook:(LNRecentBook *)recentBook
{
    self.chapterVM.recentBook = recentBook;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.rowHeight = 60;
    
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView scrollToRow:self.chapterVM.recentBook.chapterIndex inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
    });
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete
{
    [self.chapterVM updateChapterListComplete:complete];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNBookChapter *chapter = [self.dataArray objectAtIndex:indexPath.row];
    LNReaderChapterListCell *cell = [LNReaderChapterListCell cellForTableView:tableView];
    chapter.isCurrent = indexPath.row == self.chapterVM.recentBook.chapterIndex;
    cell.chapter = chapter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelect) {
        self.didSelect(indexPath.row);
    }
}
@end
