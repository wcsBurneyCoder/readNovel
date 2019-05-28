//
//  AppDelegate.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/8.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "LNTabBarController.h"
#import "LNBookrackViewController.h"
#import "LNBookrackViewModel.h"
#import "LNLocalAuthViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    LNTabBarController *tabbarVc = [[LNTabBarController alloc] init];
    self.window.rootViewController = tabbarVc;
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    //不管APP在后台还是进程被杀死，只要通过主屏快捷操作进来的，都会调用这个方法
    UITabBarController *tabbar = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navi = tabbar.selectedViewController;
    if ([navi.childViewControllers.firstObject isKindOfClass:[LNBookrackViewController class]]) {
        [navi popToRootViewControllerAnimated:NO];
    }
    else{
        [navi popToRootViewControllerAnimated:NO];
        tabbar.selectedIndex = 0;
        UINavigationController *firstNavi = tabbar.selectedViewController;
        navi = firstNavi;
    }
    if ([shortcutItem.type isEqualToString:@"search"]) {
        LNBookrackViewController *vc = (LNBookrackViewController *)navi.topViewController;
        [vc.bookrackVM enterSearchBook];
    }
    else if ([shortcutItem.type isEqualToString:@"recentBook"]){
        LNBookrackViewController *vc = (LNBookrackViewController *)navi.topViewController;
        [vc.bookrackVM continueRead:nil];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.window.bounds;
    [self.window addSubview:effectView];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

    [self.window.subviews.lastObject removeFromSuperview];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    NSTimeInterval lastTime = [[NSUserDefaults standardUserDefaults] doubleForKey:LNLastAuthTimeKey];
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    if (nowTime - lastTime >= 2 * 60 * 60) {
        if (self.authVc == nil) {
            LNLocalAuthViewController *authVc = [[LNLocalAuthViewController alloc] init];
            authVc.view.frame = self.window.bounds;
            [self.window addSubview:authVc.view];
            self.authVc = authVc;
        }
    }
    else{
        [[NSUserDefaults standardUserDefaults] setDouble:nowTime forKey:LNLastAuthTimeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.absoluteString.lastPathComponent isEqualToString:@"todayExtension"]) {
        UITabBarController *tabbar = (UITabBarController *)self.window.rootViewController;
        UINavigationController *navi = tabbar.selectedViewController;
        if ([navi.childViewControllers.firstObject isKindOfClass:[LNBookrackViewController class]]) {
            [navi popToRootViewControllerAnimated:NO];
        }
        else{
            [navi popToRootViewControllerAnimated:NO];
            tabbar.selectedIndex = 0;
            UINavigationController *firstNavi = tabbar.selectedViewController;
            navi = firstNavi;
        }
        LNBookrackViewController *vc = (LNBookrackViewController *)navi.topViewController;
        [vc.bookrackVM continueRead:nil];
        return YES;
    }
    return NO;
}


@end
