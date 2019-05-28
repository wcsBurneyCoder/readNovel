//
//  LNTabBarController.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTabBarController.h"
#import "LNBookrackViewController.h"
#import "LNClassifyViewController.h"
#import "LNProfileViewController.h"
#import "LNNavigationViewController.h"

@interface LNTabBarController ()

@end

@implementation LNTabBarController

+ (void)initialize
{
    [self setupTabBar];
}

+ (void)setupTabBar
{
    LNSkin *skin = [LNSkinHelper sharedHelper].currentSkin;
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorHex(skin.tabBarTitleNormalColor)} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorHex(skin.tabBarTitleSelectColor)} forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupChildVC];
}

- (void)setupChildVC
{
    LNSkin *skin = [LNSkinHelper sharedHelper].currentSkin;
    //书架
    [self setupChildVC:[LNBookrackViewController class] title:@"书架" image:skin.tabBarOneNormalImage selectImage:skin.tabBarOneSelectImage];
    //分类
    [self setupChildVC:[LNClassifyViewController class] title:@"分类" image:skin.tabBarTwoNormalImage selectImage:skin.tabBarTwoSelectImage];
    //我的
    [self setupChildVC:[LNProfileViewController class] title:@"我的" image:skin.tabBarThreeNormalImage selectImage:skin.tabBarThreeSelectImage];
}

- (void)setupChildVC:(Class)child title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    UIViewController *childVC = [[child alloc] init];
    
    childVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    LNNavigationViewController *navi = [[LNNavigationViewController alloc] initWithRootViewController:childVC];
    navi.title = title;
    [self addChildViewController:navi];
}
@end
