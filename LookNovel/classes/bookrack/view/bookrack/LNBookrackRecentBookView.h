//
//  LNBookrackRecentBookView.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNRecentBook.h"

NS_ASSUME_NONNULL_BEGIN

@interface LNBookrackRecentBookView : UIView

@property (nonatomic, strong) LNRecentBook *recentBook;

@property (nonatomic, copy) void(^clickContinueBlock)(LNBookrackRecentBookView *);

@end

NS_ASSUME_NONNULL_END
