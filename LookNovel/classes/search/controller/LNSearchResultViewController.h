//
//  LNSearchResultViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNSearchResultViewController : LNTableViewController
/**搜索的文本*/
@property (nonatomic, copy) NSString *searchText;
@end

NS_ASSUME_NONNULL_END
