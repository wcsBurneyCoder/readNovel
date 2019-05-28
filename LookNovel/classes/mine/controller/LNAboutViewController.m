//
//  LNAboutViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNAboutViewController.h"

@interface LNAboutViewController ()

@end

@implementation LNAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"关于我们";
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"logo"];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 10;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(40 + 64 + kIPhoneX_TOP_HEIGHT);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:15.0];
    title.textColor = UIColorHex(@"333333");
    title.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    
    UILabel *descLabel = [[UILabel alloc] init];
    descLabel.font = [UIFont systemFontOfSize:16.0];
    descLabel.textColor = UIColorHex(@"666666");
    descLabel.numberOfLines = 0;
    [self.view addSubview:descLabel];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(title.mas_bottom).offset(20);
    }];
    
    descLabel.text = @"本软件本着分享学习的开源精神，聚合了网络上的资源，提供给有需求的用户使用。所有的内容均来自于网络，如有涉及侵权，请联系：\n\n    主页：https://www.zhuqiming.cn\n\n谢谢使用～";
}

@end
