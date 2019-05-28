//
//  UIViewController+NIB.m
//  SlashYouth
//
//  Created by wangchengshan on 16/9/5.
//  Copyright © 2016年 Slash. All rights reserved.
//

#import "UIViewController+NIB.h"

@implementation UIViewController (NIB)

+ (instancetype)viewControllerFromNib
{
    return [[self alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
}

#pragma mark - swizzle
+ (void)load
{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);
    
}

- (void)deallocSwizzle
{
    LNLog(@"%@被销毁了", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self deallocSwizzle];
}
@end
