//
//  LNLocalAuthViewController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/23.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNLocalAuthViewController.h"
#import "LNLocalAuthViewModel.h"
#import "AppDelegate.h"
#import "YZAuthID.h"

@interface LNLocalAuthViewController ()
@property (nonatomic, strong) LNLocalAuthViewModel *authVM;
@end

@implementation LNLocalAuthViewController

- (LNLocalAuthViewModel *)authVM
{
    if (!_authVM) {
        _authVM = [[LNLocalAuthViewModel alloc] init];
        _authVM.authVc = self;
    }
    return _authVM;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self startAuth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:22.0];
    titleLabel.textColor = UIColorHex(@"333333");
    titleLabel.text = @"请验证身份以正常使用";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
        make.top.equalTo(self.view).offset(64 + kIPhoneX_TOP_HEIGHT + 80);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:KIphoneFullScreen?@"auth_face":@"auth_finger"];
    imageView.image = image;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(titleLabel.mas_bottom).offset(50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
    }];
    
    UIButton *authButton = [[UIButton alloc] init];
    [authButton setTitle:@"开始验证" forState:UIControlStateNormal];
    authButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
    authButton.backgroundColor = UIColorHex([LNSkinHelper sharedHelper].currentSkin.appMainColor);
    authButton.layer.cornerRadius = 6;
    [authButton addTarget:self action:@selector(startAuth) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:authButton];
    
    [authButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(self.view.mas_centerY).offset(60);
        make.height.mas_equalTo(50);
    }];
}

- (void)startAuth
{
    YZAuthID *authID = [[YZAuthID alloc] init];
    
    [authID yz_showAuthIDWithDescribe:nil block:^(YZAuthIDState state, NSError *error) {
        if (state == YZAuthIDStateNotSupport) { // 不支持TouchID/FaceID
            [MBProgressHUD showMessageHUD:@"对不起，当前设备不支持指纹/面容ID"];
        } else if(state == YZAuthIDStateFail) { // 认证失败
            NSLog(@"指纹/面容ID不正确，认证失败");
        } else if(state == YZAuthIDStateTouchIDLockout) {   // 多次错误，已被锁定
            [MBProgressHUD showMessageHUD:@"多次错误，指纹/面容ID已被锁定，请到手机解锁界面输入密码"];
        } else if (state == YZAuthIDStateSuccess) { // TouchID/FaceID验证成功
            [self enter];
        }
        
    }];
    
    
}

- (void)enter
{
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    [[NSUserDefaults standardUserDefaults] setDouble:nowTime forKey:LNLastAuthTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [UIView animateWithDuration:0.4 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        app.authVc = nil;
    }];
}

@end
