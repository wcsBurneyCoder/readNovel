//
//  LNSearchResultViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNSearchResultViewController.h"
#import "LNSearchResultViewModel.h"
#import "LNClassifyListCell.h"

@interface LNSearchResultViewController ()<UISearchBarDelegate>
@property (nonatomic, strong) LNSearchResultViewModel *resultVM;
@end

@implementation LNSearchResultViewController

- (LNSearchResultViewModel *)resultVM
{
    if (!_resultVM) {
        _resultVM = [[LNSearchResultViewModel alloc] init];
        _resultVM.resultVc = self;
    }
    return _resultVM;
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
    
    [self setupSearchBarWithText];
    
    self.tableView.rowHeight = 120;
    UIEdgeInsets inset = self.tableView.contentInset;
    inset.bottom = kIPhoneX_BOTTOM_HEIGHT;
    self.tableView.contentInset = inset;
    self.tableView.mj_footer.ignoredScrollViewContentInsetBottom = inset.bottom;
    [self.tableView.mj_header beginRefreshing];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self.resultVM sourceView:self.tableView];
    }
}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete
{
    [self.resultVM startSearchWithText:self.searchText complete:complete];
}

- (void)setupSearchBarWithText
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.text = self.searchText;
    searchBar.delegate = self;
    searchBar.frame = CGRectMake(0, 0, kScreenWidth, 35);
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"textField_bg"] forState:UIControlStateNormal];
    searchBar.tintColor = UIColorHex([LNSkinHelper sharedHelper].currentSkin.appMainColor);
    self.navigationItem.titleView = searchBar;
    
    //拿到searchBar的输入框
    UITextField *searchTextField = [searchBar valueForKeyPath:@"searchField"];
    //字体大小
    searchTextField.font = [UIFont systemFontOfSize:15];
    searchTextField.textColor = UIColorHex(@"333333");
    UIView *leftView = searchTextField.leftView;
    leftView.contentMode = UIViewContentModeLeft;
    leftView.width += 10;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self.navigationController popViewControllerAnimated:NO];
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNClassifyListCell *cell = [LNClassifyListCell cellForTableView:tableView];
    LNClassifyBookModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.resultVM enterBookDetailAtIndex:indexPath.row];
}

@end
