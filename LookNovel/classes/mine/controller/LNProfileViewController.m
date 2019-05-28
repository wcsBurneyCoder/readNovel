//
//  LNProfileViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNProfileViewController.h"
#import "LNProfileViewModel.h"
#import "LNProfileTopView.h"
#import "LNStaticCell.h"
#import "LNRightLabelCell.h"
#import "LNAboutViewController.h"
#import "LNHistoryViewController.h"

@interface LNProfileViewController ()
@property (nonatomic, strong) LNProfileViewModel *profileVM;

@property (nonatomic, weak) LNProfileTopView *topView;

@end

@implementation LNProfileViewController

- (LNProfileViewModel *)profileVM
{
    if (!_profileVM) {
        _profileVM = [[LNProfileViewModel alloc] init];
        _profileVM.profileVc = self;
    }
    return _profileVM;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)hasRefreshHeader
{
    return NO;
}

- (BOOL)hasRefreshFooter
{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    LNProfileTopView *topView = [LNProfileTopView viewFromNib];
    topView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 200 / 375.0);
    [self.view addSubview:topView];
    self.topView = topView;
    @weakify(self)
    [topView setClickHeadIcon:^(LNProfileTopView * view) {
        [weak_self pickPicture];
    }];
    
    self.tableView.contentInset = UIEdgeInsetsMake(topView.height + 15, 0, 0, 0);
    self.tableView.rowHeight = 70;
    
    UIImage *headImage = [self.profileVM getImageFromDisk];
    if (headImage) {
        [topView setHeadImageView:headImage];
    }
    
    [self setupData];
}

- (void)setupData
{
    {
        LNStaticModel *model = [[LNStaticModel alloc] init];
        model.title = @"浏览历史";
        model.icon = @"personal_center_history_22x22_";
        model.destClass = [LNHistoryViewController class];
        [self.dataArray addObject:model];
    }
    {
        LNRightLabelStaticModel *model = [[LNRightLabelStaticModel alloc] init];
        model.title = @"清理缓存";
        model.icon = @"personal_center_cleancache_22x22_";
        model.text = [self.profileVM cacheSize];
        model.cellClass = [LNRightLabelCell class];
        @weakify(self)
        [model setOperationBlock:^{
            [weak_self clearCache];
        }];
        self.profileVM.cacheModel = model;
        [self.dataArray addObject:model];
    }
    {
        LNRightLabelStaticModel *model = [[LNRightLabelStaticModel alloc] init];
        model.title = [NSString stringWithFormat:@"关于%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
        model.icon = @"personal_center_about_22x22_";
        model.text = [NSString stringWithFormat:@"v%@",[UIApplication sharedApplication].appVersion];
        model.cellClass = [LNRightLabelCell class];
        model.destClass = [LNAboutViewController class];
        [self.dataArray addObject:model];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNStaticModel *model = self.dataArray[indexPath.row];
    Class cellClass = model.cellClass?:[LNStaticCell class];
    LNStaticCell *cell = [cellClass performSelector:@selector(cellForTableView:) withObject:tableView];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LNStaticModel *model = self.dataArray[indexPath.row];
    if (model.destClass) {
        UIViewController *vc = [[model.destClass alloc] init];
        vc.title = model.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (model.operationBlock) {
        model.operationBlock();
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY  = scrollView.contentOffset.y + ABS(scrollView.contentInset.top);
    CGFloat imageHeight = kScreenWidth * 200 / 375.0;
    CGFloat imageTop = offsetY;
    CGFloat newHeight = imageHeight - offsetY;
    if (offsetY <= 0) {
        imageTop = 0;
    }
    else{
        imageTop = -offsetY;
        newHeight = imageHeight;
    }

    CGRect rect = CGRectMake(0, imageTop, kScreenWidth, newHeight);
    self.topView.frame = rect;
}

- (void)pickPicture
{
    @weakify(self)
    [self.profileVM pickImageWithComplete:^(UIImage *image) {
        [weak_self.topView setHeadImageView:image];
    }];
}

- (void)clearCache
{
    [self.profileVM clearCache];
}
@end
