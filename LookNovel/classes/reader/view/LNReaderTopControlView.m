//
//  LNReaderTopControlView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderTopControlView.h"

@interface LNReaderTopControlView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation LNReaderTopControlView

- (IBAction)clickBackBtn {
    if ([self.delegate respondsToSelector:@selector(topControlViewDidClickBack:)]) {
        [self.delegate topControlViewDidClickBack:self];
    }
}
- (IBAction)clickChangeSource {
    if ([self.delegate respondsToSelector:@selector(topControlViewDidClickChangeSource:)]) {
        [self.delegate topControlViewDidClickChangeSource:self];
    }
}
- (IBAction)clickContents {
    if ([self.delegate respondsToSelector:@selector(topControlViewDidClickShowContents:)]) {
        [self.delegate topControlViewDidClickShowContents:self];
    }
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setSkin:(LNReaderSkin *)skin
{
    self.backgroundColor = UIColorHex(skin.controlViewBgColor);
    self.titleLabel.textColor = UIColorHex(skin.textColor);
}

@end
