//
//  LNBookrackViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookrackViewController.h"
#import "LNBookrackRecommandCell.h"
#import "LNBookrackRecentBookView.h"
#import "LNBookrackViewModel.h"

@interface LNBookrackViewController ()

@end

@implementation LNBookrackViewController

- (LNBookrackViewModel *)bookrackVM
{
    if (!_bookrackVM) {
        _bookrackVM = [[LNBookrackViewModel alloc] init];
        _bookrackVM.bookrackVc = self;
    }
    return _bookrackVM;
}

- (UICollectionViewLayout *)viewLayout
{
    UICollectionViewFlowLayout *flowlayout = (UICollectionViewFlowLayout *)[super viewLayout];
    flowlayout.itemSize = CGSizeMake((kScreenWidth - 2 * 15) / 3, 175);
    flowlayout.minimumLineSpacing = 8;
    flowlayout.minimumInteritemSpacing = 0;
    
    return flowlayout;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (BOOL)hasRefreshFooter
{
    return NO;
}

- (BOOL)hasRefreshHeader
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.top = 235;
    contentInset.left = 15;
    contentInset.right = 15;
    self.collectionView.contentInset = contentInset;
    [self loadData];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    header.arrowView.tintColor = [UIColor whiteColor];
    if (KIphoneFullScreen) {
        header.ignoredScrollViewContentInsetTop = contentInset.top - CGRectGetHeight([UIApplication sharedApplication].statusBarFrame) + 20;
    }
    else{
        header.ignoredScrollViewContentInsetTop = contentInset.top;
    }
    self.collectionView.mj_header = header;
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    bgImageView.frame = CGRectMake(0, 0, kScreenWidth, contentInset.top);
    [self.view addSubview:bgImageView];
    self.bookrackVM.bgImageView = bgImageView;
    [self.view sendSubviewToBack:bgImageView];
    
    LNBookrackRecentBookView *bookView = [LNBookrackRecentBookView viewFromNib];
    [self.view addSubview:bookView];
    bookView.frame = CGRectMake(0, 0, kScreenWidth, contentInset.top);
    self.bookrackVM.bookView = bookView;
//    [self.view sendSubviewToBack:bookView];
    
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setImage:[UIImage imageNamed:@"icon_search_16x16_"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-25);
        make.top.equalTo(self.view).offset(20 + kIPhoneX_TOP_HEIGHT);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    //获取最新的书籍
    [self.bookrackVM loadRecentBook];

}

- (void)loadDataWithPageIndex:(NSInteger)pageIndex pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)complete
{
    [self.bookrackVM getRecommandListComplete:complete];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LNBookrackRecommandCell *cell = [LNBookrackRecommandCell cellForCollectionView:collectionView indexPath:indexPath];
    LNRecommnadBook *book = [self.dataArray objectAtIndex:indexPath.item];
    cell.bookModel = book;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LNRecommnadBook *book = [self.dataArray objectAtIndex:indexPath.item];
    if (book._id) {
        [self.bookrackVM beginReadBook:book];
    }
    else{
        [self clickSearch];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY  = scrollView.contentOffset.y;
    CGFloat imageHeight = scrollView.contentInset.top;
    offsetY = offsetY + imageHeight;
    if (offsetY >= 0) {
        self.bookrackVM.bgImageView.top = -offsetY;
        self.bookrackVM.bookView.top = -offsetY;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)clickSearch
{
    [self.bookrackVM enterSearchBook];
}
@end
