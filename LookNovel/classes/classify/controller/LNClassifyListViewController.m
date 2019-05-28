//
//  LNClassifyListViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyListViewController.h"
#import "LNClassifyListViewModel.h"
#import "LNClassifyListCell.h"

@interface LNClassifyListViewController ()
@property (nonatomic, strong) LNClassifyListViewModel *listVM;
@end

@implementation LNClassifyListViewController

- (LNClassifyListViewModel *)listVM
{
    if (!_listVM) {
        _listVM = [[LNClassifyListViewModel alloc] init];
        _listVM.listVc = self;
    }
    return _listVM;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.itemName;
    self.tableView.rowHeight = 120;
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = kIPhoneX_BOTTOM_HEIGHT;
    self.tableView.contentInset = inset;
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = inset.bottom;
    [self.tableView.mj_header beginRefreshing];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self.listVM sourceView:self.tableView];
    }
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete
{
    [self.listVM getBooksWithGroupName:self.groupKey itemName:self.itemName page:(pageIndex - 1) complete:complete];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNClassifyListCell *cell = [LNClassifyListCell cellForTableView:tableView];
    LNClassifyBookModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.listVM enterBookDetailAtIndex:indexPath.row];
}
@end
