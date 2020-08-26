//
//  LNReaderViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderViewController.h"
#import "LNReaderViewModel.h"
#import "LNReaderContentCell.h"
#import "LNReaderTopControlView.h"
#import "LNReaderScourceListViewController.h"
#import "LNReaderChapterListViewController.h"
#import "LNReaderBottomControlView.h"
#import "LNReaderSettingView.h"

@interface LNReaderViewController ()<UITextViewDelegate,LNReaderTopControlViewDelegate,LNReaderBottomControlViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) LNReaderViewModel *readerVM;
/**是否正在显示菜单*/
@property (nonatomic, assign) BOOL menuIsShowing;
/**是否正在显示源菜单*/
@property (nonatomic, assign) BOOL sourceListIsShowing;
/**是否正在显示章节菜单*/
@property (nonatomic, assign) BOOL chapterListIsShowing;
/**是否正在显示设置*/
@property (nonatomic, assign) BOOL settingViewIsShowing;
/**遮罩*/
@property (nonatomic, weak) UIControl *coverView;
@property (nonatomic, weak) UIViewController *dispalyListVc;

@property (nonatomic, assign) BOOL statusBarHide;

@end

@implementation LNReaderViewController

- (LNReaderViewModel *)readerVM
{
    if (!_readerVM) {
        _readerVM = [[LNReaderViewModel alloc] init];
        _readerVM.readerVc = self;
    }
    return _readerVM;
}

- (void)setRecentBook:(LNRecentBook *)recentBook
{
    _recentBook = recentBook;
    self.readerVM.recentBook = recentBook;
}

- (UIControl *)coverView
{
    if (_coverView) {
        return _coverView;
    }
    UIControl *coverView = [[UIControl alloc] init];
    coverView.backgroundColor = [UIColorHex(@"000000") colorWithAlphaComponent:0.3];
    [coverView addTarget:self action:@selector(dismissRightView) forControlEvents:UIControlEventTouchUpInside];
    coverView.frame = CGRectMake(0, 64 + kIPhoneX_TOP_HEIGHT, self.view.width, self.view.height);
    coverView.alpha = 0;
    [self.view addSubview:coverView];
    _coverView = coverView;
    return _coverView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.statusBarHide = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [UIScreen mainScreen].brightness = self.readerVM.currentBright;
    [UIApplication sharedApplication].idleTimerDisabled = self.readerVM.notLock;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIScreen mainScreen].brightness = self.readerVM.oldBright;
    [UIApplication sharedApplication].idleTimerDisabled = NO;
}

- (BOOL)hasRefreshHeader
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuIsShowing = NO;
    self.settingViewIsShowing = NO;
    
    UIImageView *bgImageView = [[UIImageView alloc] init];
    bgImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgImageView];
    self.readerVM.bgImageView = bgImageView;
    bgImageView.frame = self.view.bounds;
    [self.view sendSubviewToBack:bgImageView];

    self.tableView.contentInset = UIEdgeInsetsMake(kIPhoneX_TOP_HEIGHT + 30, 0, 0, 0);
    
    [self setupTopView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header setIgnoredScrollViewContentInsetTop:kIPhoneX_TOP_HEIGHT];
    [self.readerVM showIndicatorView];
    
    [self setupControlView];
    
    [self setupRightContentView];
    
    [self.readerVM setReaderSkin];
    
    [self getBookData];
    
}

- (void)getBookData
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:self.view];
    [self.readerVM loadBookContentComplete:^(id result, BOOL cache, NSError *error) {
        [MBProgressHUD dismissHUDInView:self.view];
        if (error) {
            [MBProgressHUD showMessageHUD:error.domain];
            [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)]];
        }
        else{
            self.dataArray = [NSMutableArray arrayWithArray:result];
            [self.tableView reloadData];
        }
    }];
}

- (void)setupTopView
{
    UIImageView *baseView = [[UIImageView alloc] init];
    baseView.clipsToBounds = YES;
    baseView.frame = CGRectMake(0, 0, kScreenWidth, kIPhoneX_TOP_HEIGHT + 30);
    [self.view addSubview:baseView];
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.textColor = UIColorHex(@"333333");
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:tipLabel];
    tipLabel.frame = CGRectMake(0, kIPhoneX_TOP_HEIGHT, kScreenWidth, 30);
    
    self.readerVM.topView = baseView;
    self.readerVM.topTitleLabel = tipLabel;
}

- (void)loadData
{
    CGSize contentSize = self.tableView.contentSize;
    [self.readerVM changeChapter:self.readerVM.recentBook.chapterIndex - 1 complete:^(id result, BOOL cache, NSError *error) {
        if (!error) {
            [self.dataArray insertObjects:result atIndex:0];
            [self.tableView reloadData];
            CGSize currentContentSize = self.tableView.contentSize;
            CGFloat deltaH = currentContentSize.height - contentSize.height;
            [self.tableView setContentOffset:CGPointMake(0, deltaH - 150)];
        }
        else{
            [MBProgressHUD showMessageHUD:error.domain];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData
{
    [self.readerVM changeChapter:self.readerVM.recentBook.chapterIndex + 1 complete:^(id result, BOOL cache, NSError *error) {
        if (!error) {
            [self.dataArray addObjectsFromArray:result];
            [self.tableView reloadData];
        }
        else{
            [MBProgressHUD showMessageHUD:error.domain];
        }
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setupControlView
{
    LNReaderTopControlView *topControlView = [LNReaderTopControlView viewFromNib];
    topControlView.delegate = self;
    [topControlView setTitle:self.recentBook.title];
    topControlView.frame = CGRectMake(0, - (64 + kIPhoneX_TOP_HEIGHT), kScreenWidth, (64 + kIPhoneX_TOP_HEIGHT));
    [self.view addSubview:topControlView];
    self.readerVM.topControlView = topControlView;
    
    LNReaderBottomControlView *bottomControlView = [LNReaderBottomControlView viewFromNib];
    bottomControlView.delegate = self;
    bottomControlView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49 + kIPhoneX_BOTTOM_HEIGHT);
    [self.view addSubview:bottomControlView];
    self.readerVM.bottomControlView = bottomControlView;
    
    LNReaderSettingView *settingView = [LNReaderSettingView viewFromNib];
    settingView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 230 + kIPhoneX_BOTTOM_HEIGHT);
    settingView.skinList = [LNSkinHelper sharedHelper].readerSkinList;
    settingView.fontSize = self.readerVM.font.pointSize;
    settingView.delegate = self.readerVM;
    [settingView setNotLock:self.readerVM.notLock];
    [settingView setBright:self.readerVM.currentBright];
    [self.view addSubview:settingView];
    self.readerVM.settingView = settingView;
}

- (void)setupRightContentView
{
    UIView *rightContentView = [[UIView alloc] init];
    rightContentView.backgroundColor = [UIColor whiteColor];
    rightContentView.frame = CGRectMake(kScreenWidth, 64 + kIPhoneX_TOP_HEIGHT, kScreenWidth * 0.8, kScreenHeight - (64 + kIPhoneX_TOP_HEIGHT));
    [self.view addSubview:rightContentView];
    self.readerVM.rightContentView = rightContentView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNReaderContentCell *cell = [LNReaderContentCell cellForTableView:tableView];
    LNBookContent *content = [self.dataArray objectAtIndex:indexPath.row];
    cell.content = content;
    return cell;
}

//如果tableView.estimatedRowHeight = 0,就执行这个方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightWithIndex:indexPath.row];
}

//如果没设置tableView.estimatedRowHeight,就执行这个方法
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellHeightWithIndex:indexPath.row];
}

- (CGFloat)cellHeightWithIndex:(NSInteger)index
{
    LNBookContent *content = [self.dataArray objectAtIndex:index];
    if (content.cellHeight) {
        return [content.cellHeight floatValue];
    }
    return [LNReaderContentCell heightWithModel:content];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xOffset = scrollView.contentOffset.x;
    CGFloat yOffset = scrollView.contentOffset.y + 150 + kIPhoneX_TOP_HEIGHT;
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:CGPointMake(xOffset, yOffset)];
    if (path.row < self.dataArray.count) {
        LNBookContent *content = [self.dataArray objectAtIndex:path.row];
        self.readerVM.topTitleLabel.text = content.name;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.menuIsShowing) {
        [self hideMenu];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.settingViewIsShowing) {
        return;
    }
    self.menuIsShowing?[self hideMenu]:[self showMenu];
}

- (void)showMenu
{
    if (self.menuIsShowing) {
        return;
    }
    self.statusBarHide = NO;
    [self setNeedsStatusBarAppearanceUpdate];
    self.menuIsShowing = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.readerVM.topControlView.top = 0;
        self.readerVM.bottomControlView.bottom = kScreenHeight;
    }];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideMenu) withObject:nil afterDelay:3];
}

- (void)hideMenu
{
    if (self.menuIsShowing == NO) {
        return;
    }
    self.menuIsShowing = NO;
    self.statusBarHide = YES;
    [self setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:0.25 animations:^{
        self.readerVM.topControlView.top = -self.readerVM.topControlView.height;
        self.readerVM.bottomControlView.top = kScreenHeight;
    }];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)showRightView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.coverView.alpha = 0;
    [self.view bringSubviewToFront:self.readerVM.rightContentView];
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 1;
        self.readerVM.rightContentView.left -= self.readerVM.rightContentView.width;
    }];
}

- (void)dismissRightView
{
    [self dismissRightViewFinished:nil];
    self.sourceListIsShowing = NO;
    self.chapterListIsShowing = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideMenu) withObject:nil afterDelay:3];
}

- (void)dismissRightViewFinished:(void(^)(void))finishedBlock
{
    [UIView animateWithDuration:0.25 animations:^{
        self.coverView.alpha = 0;
        self.readerVM.rightContentView.left = kScreenWidth;
    } completion:^(BOOL finished) {
        [self.readerVM.rightContentView removeAllSubviews];
        if (self.dataArray.count == 0) {
            [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu)]];
        }
        if (finishedBlock) {
            finishedBlock();
        }
    }];
}

#pragma mark - LNReaderTopControlViewDelegate
- (void)topControlViewDidClickShowContents:(LNReaderTopControlView *)topView
{
    if (self.view.gestureRecognizers.count) {
        [self.view removeGestureRecognizer:self.view.gestureRecognizers.firstObject];
    }
    
    if (self.sourceListIsShowing) {
        self.sourceListIsShowing = NO;
        self.chapterListIsShowing = YES;
        [self dismissRightViewFinished:^{
            [self.dispalyListVc removeFromParentViewController];
            [self showChapterListView];
        }];
    }
    else{
        if (self.chapterListIsShowing) {
            return;
        }
        self.chapterListIsShowing = YES;
        [self showChapterListView];
    }
}

- (void)topControlViewDidClickBack:(LNReaderTopControlView *)topView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showChapterListView
{
    LNReaderChapterListViewController *listVc = [[LNReaderChapterListViewController alloc] init];
    listVc.recentBook = self.readerVM.recentBook;
    [self.readerVM.rightContentView addSubview:listVc.view];
    listVc.view.frame = self.readerVM.rightContentView.bounds;
    @weakify(self)
    [listVc setDidSelect:^(NSInteger index) {
        [weak_self changeChapter:index];
        [weak_self dismissRightView];
    }];
    [self addChildViewController:listVc];
    self.dispalyListVc = listVc;
    [self showRightView];
}

- (void)changeChapter:(NSInteger)index
{
    [MBProgressHUD showWaitingViewText:nil detailText:nil inView:self.view];
    [self.readerVM changeChapter:index complete:^(id result, BOOL cache, NSError *error) {
        if (error) {
            [MBProgressHUD dismissHUDInView:self.view];
            [MBProgressHUD showMessageHUD:error.domain];
        }
        else{
            self.dataArray = [NSMutableArray arrayWithArray:result];
            [self.tableView reloadData];
            [MBProgressHUD dismissHUDInView:self.view];
            [self.tableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
    }];
}

#pragma mark - LNReaderBottomControlViewDelegate
- (void)bottomViewDidClickSettingItem:(LNReaderBottomControlView *)bottomView
{
    [self hideMenu];
    self.settingViewIsShowing = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSettingView)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    [UIView animateWithDuration:0.25 animations:^{
        self.readerVM.settingView.bottom = kScreenHeight;
    }];
}

- (void)bottomViewDidClickDayNightItem:(LNReaderBottomControlView *)bottomView
{
    [self hideMenu];
    [self.readerVM changeMode];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)hideSettingView
{
    self.settingViewIsShowing = NO;
    [self.view removeGestureRecognizer:self.view.gestureRecognizers.firstObject];
    [UIView animateWithDuration:0.25 animations:^{
        self.readerVM.settingView.top = kScreenHeight;
    }];
}

#pragma mark -
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.readerVM.settingView];
    return !CGRectContainsPoint(self.readerVM.settingView.bounds, point);
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.readerVM.currentMode == LNReaderModeDay) {
        return UIStatusBarStyleDefault;
    }
    else{
        return UIStatusBarStyleLightContent;
    }
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusBarHide;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation
{
    return UIStatusBarAnimationFade;
}
@end

