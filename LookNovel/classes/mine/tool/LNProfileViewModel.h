//
//  LNProfileViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/17.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNProfileViewController.h"
#import "LNRightLabelStaticModel.h"

@interface LNProfileViewModel : LNBaseViewModel

@property (nonatomic, weak) LNProfileViewController *profileVc;
@property (nonatomic, weak) LNRightLabelStaticModel *cacheModel;

- (void)pickImageWithComplete:(void(^)(UIImage *image))completeBlock;

- (UIImage *)getImageFromDisk;

- (NSString *)cacheSize;

- (void)clearCache;

@end

