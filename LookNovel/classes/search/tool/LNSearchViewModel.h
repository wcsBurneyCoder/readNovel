//
//  LNSearchViewModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBaseViewModel.h"
#import "LNSearchViewController.h"
#import "LNSuggest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNSearchViewModel : LNBaseViewModel<UISearchBarDelegate>

@property (nonatomic, weak) LNSearchViewController *searchVc;
@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, strong) NSArray<LNSuggest *> *tipArray;
@end

NS_ASSUME_NONNULL_END
