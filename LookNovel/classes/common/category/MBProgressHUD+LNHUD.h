//
//  MBProgressHUD+LNHUD.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef enum : NSUInteger {
    ProgressHUDTypeCircle,
    ProgressHUDTypeCircleLine,
    ProgressHUDTypeBar
} ProgressHUDType;

typedef enum : NSUInteger {
    MessageHUDPositonTop,
    MessageHUDPositonCenter,
    MessageHUDPositonBottom
} MessageHUDPositon;


@interface MBProgressHUD (LNHUD)
#pragma mark - 显示成功失败信息
/**
 *  显示成功信息
 *  显示在窗口上 1秒后消失
 *  @param success     成功信息
 *  @param successIcon 成功显示的图片
 */
+ (void)showSuccess:(NSString *)success successIcon:(NSString *)successIcon;
/**
 *  显示失败信息
 *  显示在窗口上 1秒后消失
 *  @param error     失败信息
 *  @param errorIcon 失败显示的图片
 */
+ (void)showError:(NSString *)error errorIcon:(NSString *)errorIcon;
#pragma mark - 显示等待信息
/**
 *  显示等待信息
 *  显示在窗口上
 *  @param text     信息
 *  @param detailText 详细信息
 *  @param view 需要显示在view上
 */
+ (void)showWaitingViewText:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view;

#pragma mark - 显示进度条
/**
 *  显示进度信息
 *  显示在自己view上
 *  @param type     等待框的样式类型
 *  @param text     信息
 *  @param view     展示的view
 *  @param progress 进度block
 */
+ (void)showProgressHUDType:(ProgressHUDType)type text:(NSString *)text inView:(UIView *)view progress:(float(^)())progress;

#pragma mark - 显示提示信息
/**
 *  显示信息
 *  显示在窗口上 1秒后消失
 *  @param message 信息
 *  @param detail  详细信息
 *  @param positon 显示位置
 */
+ (void)showMessageHUDMessage:(NSString *)message detailMessage:(NSString *)detail position:(MessageHUDPositon)positon;
+ (void)showMessageHUD:(NSString *)message;
+ (void)showNODismissMessageHUD:(NSString *)message;
+ (void)showNODismissMessageHUD:(NSString *)message detailMessage:(NSString *)detailMessage;
+ (void)showCancelButtonMessageHUD:(NSString *)message;

#pragma mark - 隐藏提示框
+ (void)dismissHUD;
+ (void)dismissHUDInView:(UIView *)view;
@end

