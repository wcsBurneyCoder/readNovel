//
//  LNClassifyListViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNClassifyListViewController : LNTableViewController
/**组key*/
@property (nonatomic, copy) NSString *groupKey;
/**分类名*/
@property (nonatomic, copy) NSString *itemName;
@end

NS_ASSUME_NONNULL_END
