//
//  MBProgressHUD+LNHUD.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "MBProgressHUD+LNHUD.h"

@implementation MBProgressHUD (LNHUD)

+ (MBProgressHUD *)setupHUDWithMode:(MBProgressHUDMode)mode view:(UIView *)view
{
    UIView *displayView = nil;
    if (view) {
        displayView = view;
    }
    else{
        displayView = [[[UIApplication sharedApplication] delegate] window];
    }
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:displayView];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:displayView animated:YES];
    }
    hud.mode = mode;
    return hud;
}

+ (void)showText:(NSString *)text detail:(NSString *)detail icon:(NSString *)icon positon:(MessageHUDPositon)position dismiss:(BOOL)dismiss
{
    MBProgressHUD *hud = [self setupHUDWithMode:MBProgressHUDModeCustomView view:nil];
    UIImage *image  = nil;
    if (icon.length > 0) {
        image = [UIImage imageNamed:icon];
    }
    if (image) {
        hud.customView = [[UIImageView alloc] initWithImage:image];
        hud.mode = MBProgressHUDModeCustomView;
        hud.square = YES;
    }
    else{
        hud.mode = MBProgressHUDModeText;
    }
    CGFloat yOffset = 0.0;
    switch (position) {
        case MessageHUDPositonTop:
            yOffset = -MBProgressMaxOffset;
            break;
        case MessageHUDPositonCenter:
            yOffset = 0.0;
            break;
        case MessageHUDPositonBottom:
            yOffset = MBProgressMaxOffset;
            break;
            
        default:
            break;
    }
    hud.offset = CGPointMake(0, yOffset);
    if (text.length) {
        hud.label.text = text;
    }
    if (detail.length) {
        hud.detailsLabel.text = detail;
    }
    hud.label.numberOfLines = 0;
    hud.detailsLabel.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    if (dismiss) {
        [hud hideAnimated:YES afterDelay:2.0f];
    }
}

+ (void)showSuccess:(NSString *)success successIcon:(NSString *)successIcon
{
    [self showText:successIcon detail:nil icon:successIcon positon:MessageHUDPositonCenter dismiss:YES];
}

+ (void) showError:(NSString *)error errorIcon:(NSString *)errorIcon
{
    [self showText:error detail:nil icon:errorIcon positon:MessageHUDPositonCenter dismiss:YES];
}

#pragma mark -
+ (void)showWaitingViewText:(NSString *)text detailText:(NSString *)detailText inView:(UIView *)view
{
    MBProgressHUD *hud = [self setupHUDWithMode:MBProgressHUDModeIndeterminate view:view];
    if (view) {
        if(view.viewController.navigationController){
            CGFloat naviBarHeight = view.viewController.navigationController.navigationBar.height;
            hud.offset = CGPointMake(0, -naviBarHeight);
        }
    }
    if (text.length > 0) {
        hud.label.text =text;
    }
    if (detailText.length > 0) {
        hud.detailsLabel.text = detailText;
    }
}

#pragma mark -
+ (void)showProgressHUDType:(ProgressHUDType)type text:(NSString *)text inView:(UIView *)view progress:(float (^)())progress
{
    MBProgressHUDMode mode;
    switch (type) {
        case ProgressHUDTypeCircle:
            mode = MBProgressHUDModeDeterminate;
            break;
        case ProgressHUDTypeCircleLine:
            mode = MBProgressHUDModeAnnularDeterminate;
            break;
        case ProgressHUDTypeBar:
            mode = MBProgressHUDModeDeterminateHorizontalBar;
            break;
        default:
            break;
    }
    
    MBProgressHUD *progressHud = [self setupHUDWithMode:mode view:view];
    progressHud.mode = mode;
    if (text.length > 0) {
        progressHud.label.text = text;
    }
    if (progress) {
        progressHud.progress = progress();
    }
}

#pragma mark -
+ (void)showMessageHUD:(NSString *)message
{
    [self showText:message detail:nil icon:nil positon:MessageHUDPositonCenter dismiss:YES];
    
}

+ (void)showNODismissMessageHUD:(NSString *)message
{
    [self showText:message detail:nil icon:nil positon:MessageHUDPositonCenter dismiss:NO];
    
}

+ (void)showNODismissMessageHUD:(NSString *)message detailMessage:(NSString *)detailMessage
{
    [self showText:message detail:detailMessage icon:nil positon:MessageHUDPositonCenter dismiss:NO];
    
}

+ (void)showCancelButtonMessageHUD:(NSString *)message
{
    MBProgressHUD *hud = [self setupHUDWithMode:MBProgressHUDModeCustomView view:nil];
    hud.mode = MBProgressHUDModeText;
    hud.label.numberOfLines = 0;
    hud.detailsLabel.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    if (message.length) {
        hud.label.text = message;
    }
    [hud.button setTitle:@"确定" forState:UIControlStateNormal];
    [hud.button addTarget:self action:@selector(dismissHUD) forControlEvents:UIControlEventTouchUpInside];
}

+ (void)showMessageHUDMessage:(NSString *)message detailMessage:(NSString *)detail position:(MessageHUDPositon)positon
{
    [self showText:message detail:detail icon:nil positon:positon dismiss:YES];
}

#pragma mark -
+ (void)dismissHUD
{
    UIView *window = [[[UIApplication sharedApplication] delegate] window];
    [MBProgressHUD hideHUDForView:window animated:YES];
}

+ (void)dismissHUDInView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
    
}

@end
