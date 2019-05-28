//
//  LNClassifyListViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNClassifyListViewController.h"
#import "LNClassifyBookModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyListViewModel : LNBaseViewModel<UIViewControllerPreviewingDelegate>

@property (nonatomic, weak) LNClassifyListViewController *listVc;

@property (nonatomic, assign, readonly) NSInteger pageSize;

- (void)getBooksWithGroupName:(NSString *)group itemName:(NSString *)item page:(NSInteger)page complete:(httpCompleteBlock)completeBlock;

- (void)enterBookDetailAtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
