//
//  LNReaderTopControlView.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LNReaderTopControlView;

NS_ASSUME_NONNULL_BEGIN

@protocol LNReaderTopControlViewDelegate <NSObject>

- (void)topControlViewDidClickBack:(LNReaderTopControlView *)topView;
- (void)topControlViewDidClickShowContents:(LNReaderTopControlView *)topView;

@end

@interface LNReaderTopControlView : UIView

@property (nonatomic, weak) id<LNReaderTopControlViewDelegate> delegate;
/**模式，默认日间*/
@property (nonatomic, strong) LNReaderSkin *skin;

- (void)setTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
