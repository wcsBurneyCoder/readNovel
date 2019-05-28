//
//  LNClassifyViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNClassifyViewController.h"
#import "LNClassifyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyViewModel : LNBaseViewModel

@property (nonatomic, weak) LNClassifyViewController *classifyVc;
@property (nonatomic, weak) UICollectionView *rightCollectionView;
@property (nonatomic, weak) UITableView *leftTableView;

@property (nonatomic, strong) NSArray *leftDataArray;
@property (nonatomic, strong) NSArray *rightDataArray;
@property (nonatomic, weak) LNClassifyGroupModel *lastGroupModel;

- (void)getAllClassify;

- (void)changeGroupAtIndex:(NSInteger)index needScroll:(BOOL)need;

- (void)clickItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)startSearch;
@end

NS_ASSUME_NONNULL_END
