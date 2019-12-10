//
//  LNSearchViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNSearchViewController.h"
#import "LNSearchViewModel.h"

@interface LNSearchViewController ()
@property (nonatomic, strong) LNSearchViewModel *searchVM;
@end

@implementation LNSearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (LNSearchViewModel *)searchVM
{
    if (!_searchVM) {
        _searchVM = [[LNSearchViewModel alloc] init];
        _searchVM.searchVc = self;
    }
    return _searchVM;
}

- (void)setupSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.frame = CGRectMake(0, 0, kScreenWidth, 35);
    searchBar.placeholder = @"书名/作者";
    searchBar.delegate = self.searchVM;
    self.searchVM.searchBar = searchBar;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
}

@end
