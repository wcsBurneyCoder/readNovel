//
//  LNBookDetailIntroView.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNBookDetail.h"

@class LNBookDetailIntroView;

NS_ASSUME_NONNULL_BEGIN

@protocol LNBookDetailIntroViewDelegate <NSObject>

- (void)introViewDidClickChapterList:(LNBookDetailIntroView *)view;

@end

@interface LNBookDetailIntroView : UIView

@property (nonatomic, strong) LNBookDetail *detail;
/**代理*/
@property (nonatomic, weak) id<LNBookDetailIntroViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
