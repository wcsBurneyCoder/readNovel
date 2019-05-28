//
//  TodayViewController.m
//  recentBook
//
//  Created by wangchengshan on 2019/5/24.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "LNTodayViewModel.h"
#import "YYKit.h"

@interface TodayViewController () <NCWidgetProviding>
@property (weak, nonatomic) IBOutlet UIView *recentView;
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratioLabel;
@property (weak, nonatomic) IBOutlet UIView *continueView;

@property (nonatomic, strong) LNTodayViewModel *todayVM;
@end

@implementation TodayViewController

- (LNTodayViewModel *)todayVM
{
    if (!_todayVM) {
        _todayVM = [[LNTodayViewModel alloc] init];
        _todayVM.todayVc = self;
    }
    return _todayVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (@available(iOS 10.0, *))
    {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeCompact;
    }
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 115);
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContinue)]];
    
    [self.todayVM loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.todayVM loadData];
}

- (void)clickContinue
{
    [self.extensionContext openURL:[NSURL URLWithString:@"comwcsLookNovel://todayExtension"] completionHandler:^(BOOL success) {
        
    }];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    
    [self updateData];

    completionHandler(NCUpdateResultNewData);
}

- (void)updateData
{
    LNRecentBook *recentBook = self.todayVM.currentBook;
    self.recentView.hidden = (recentBook == nil);
    self.noDataLabel.hidden = !self.recentView.hidden;
    if (recentBook) {
        [self.coverImageView setImageWithURL:[NSURL URLWithString:recentBook.cover] placeholder:defaultCoverImage() options:defaultImageOptions() completion:nil];
        
        self.nameLabel.text = recentBook.title;
        self.chapterLabel.text = recentBook.chapter.title;
        self.ratioLabel.text = [NSString stringWithFormat:@"读至%.1f%%",recentBook.readRatio];
    }
}
@end
