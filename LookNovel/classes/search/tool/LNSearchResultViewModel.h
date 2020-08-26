//
//  LNSearchResultViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNSearchResultViewController.h"
#import "LNClassifyBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNSearchResultViewModel : LNBaseViewModel<UIViewControllerPreviewingDelegate>

@property (nonatomic, weak) LNSearchResultViewController *resultVc;

- (void)startSearchWithText:(NSString *)text page:(NSInteger)page pageSize:(NSInteger)pageSize complete:(httpCompleteBlock)completeBlock;

- (void)enterBookDetailAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
