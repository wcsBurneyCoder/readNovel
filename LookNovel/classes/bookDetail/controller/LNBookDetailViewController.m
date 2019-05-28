//
//  LNBookDetailViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/17.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookDetailViewController.h"
#import "LNBookDetailViewModel.h"
#import "LNBookDetailInfoView.h"
#import "LNBookDetailIntroView.h"
#import "LNBookDetailBottomView.h"

@interface LNBookDetailViewController ()
@property (nonatomic, strong) LNBookDetailViewModel *detailVM;

@end

@implementation LNBookDetailViewController

- (LNBookDetailViewModel *)detailVM
{
    if (!_detailVM) {
        _detailVM = [[LNBookDetailViewModel alloc] init];
        _detailVM.detailVc = self;
    }
    return _detailVM;
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
    LNBookDetailBottomView *bottomView = [LNBookDetailBottomView viewFromNib];
    bottomView.hidden = YES;
    [self.view addSubview:bottomView];
    self.detailVM.bottomView = bottomView;
    @weakify(self)
    [bottomView setClickActionBlock:^{
        [weak_self.detailVM startReadBook];
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.height.mas_equalTo(50 + kIPhoneX_BOTTOM_HEIGHT);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.hidden = YES;
    if (@available(iOS 11, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    self.detailVM.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(64 + kIPhoneX_TOP_HEIGHT);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
    LNBookDetailInfoView *infoView = [LNBookDetailInfoView viewFromNib];
    [scrollView addSubview:infoView];
    self.detailVM.infoView = infoView;
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.left.and.right.equalTo(scrollView);
        make.top.equalTo(scrollView);
        make.height.mas_equalTo(210);
    }];
    
    LNBookDetailIntroView *introView = [LNBookDetailIntroView viewFromNib];
    introView.delegate = self.detailVM;
    [scrollView addSubview:introView];
    self.detailVM.introView = introView;
    [introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.left.and.right.equalTo(scrollView);
        make.top.equalTo(infoView.mas_bottom);
        make.bottom.equalTo(scrollView).offset(-10);
    }];

    
    [self.detailVM loadDetailData];
}


- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"开始阅读" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self.detailVM startReadBook];
    }];

    return  @[action];
}

@end
