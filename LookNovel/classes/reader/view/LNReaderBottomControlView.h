//
//  LNReaderBottomControlView.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNReaderBottomControlView;

NS_ASSUME_NONNULL_BEGIN

@protocol LNReaderBottomControlViewDelegate <NSObject>

- (void)bottomViewDidClickDayNightItem:(LNReaderBottomControlView *)bottomView;
- (void)bottomViewDidClickSettingItem:(LNReaderBottomControlView *)bottomView;

@end

@interface LNReaderBottomControlView : UIView
/**代理*/
@property (nonatomic, weak) id<LNReaderBottomControlViewDelegate> delegate;
/**模式，默认日间*/
@property (nonatomic, strong) LNReaderSkin *skin;
@end

NS_ASSUME_NONNULL_END
