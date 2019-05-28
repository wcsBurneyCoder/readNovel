//
//  LNBookrackViewController.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNCollectionViewController.h"
@class LNBookrackViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface LNBookrackViewController : LNCollectionViewController
@property (nonatomic, strong) LNBookrackViewModel *bookrackVM;
@end

NS_ASSUME_NONNULL_END
