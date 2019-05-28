//
//  LNProfileTopView.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/17.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LNProfileTopView : UIView

- (void)setHeadImageView:(UIImage *)image;

@property (nonatomic, copy) void(^clickHeadIcon)(LNProfileTopView *);
@end

NS_ASSUME_NONNULL_END
