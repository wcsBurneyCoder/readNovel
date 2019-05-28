//
//  LNProfileViewModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/17.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNProfileViewModel.h"
#import "TZImagePickerController.h"
#import "LNRequest.h"

@interface LNProfileViewModel ()<TZImagePickerControllerDelegate>
@property (nonatomic, copy) void(^pickImageBlock)(UIImage *);
@end

@implementation LNProfileViewModel

- (void)pickImageWithComplete:(void (^)(UIImage *))completeBlock
{
    self.pickImageBlock = completeBlock;
    
    TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self];
    picker.allowTakeVideo = NO;
    picker.allowPickingVideo = NO;
    picker.sortAscendingByModificationDate = NO;
    picker.allowPickingOriginalPhoto = NO;
    picker.allowTakePicture = YES;
    picker.showSelectedIndex = YES;
    picker.allowCrop = YES;
    picker.barItemTextColor = UIColorHex(@"999999");
    picker.naviTitleColor = UIColorHex(@"999999");
    picker.statusBarStyle = UIStatusBarStyleDefault;
    [self.profileVc presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [self saveImageToDisk:photos.firstObject];
    if (self.pickImageBlock) {
        self.pickImageBlock(photos.firstObject);
    }
}

- (void)saveImageToDisk:(UIImage *)image
{
    YYImageCache *cache = [YYImageCache sharedCache];
    [cache setImage:image forKey:@"headerImage"];
}

- (UIImage *)getImageFromDisk
{
    YYImageCache *cache = [YYImageCache sharedCache];
    return [cache getImageForKey:@"headerImage"];
}

- (NSString *)cacheSize
{
   return [NSString stringWithFormat:@"%.02fM",[LNRequest cacheSize]];
}

- (void)clearCache
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"是否要清除缓存？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clearCacheWithBlock:^{
            self.cacheModel.text = @"0.00M";
            [self.profileVc.tableView reloadData];
        }];
    }];
    [alert addAction:cancel];
    [alert addAction:sure];
    [self.profileVc presentViewController:alert animated:YES completion:nil];
}

- (void)clearCacheWithBlock:(void (^)(void))block
{
    [MBProgressHUD showWaitingViewText:@"正在清理.." detailText:nil inView:nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [LNRequest clearCache];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD dismissHUD];
            if (block) {
                block();
            }
        });
    });
}
@end
