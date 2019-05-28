//
//  LNReaderBottomControlView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderBottomControlView.h"

@interface LNReaderBottomControlView ()
@property (weak, nonatomic) IBOutlet UIImageView *dayNightImageview;
@property (weak, nonatomic) IBOutlet UILabel *dayNightLabel;
@property (weak, nonatomic) IBOutlet UIView *dayNightItem;
@property (weak, nonatomic) IBOutlet UIView *settingItem;

@end

@implementation LNReaderBottomControlView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.dayNightItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDayNight)]];
    [self.settingItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSetting)]];
}


- (void)clickDayNight
{
    if ([self.delegate respondsToSelector:@selector(bottomViewDidClickDayNightItem:)]) {
        [self.delegate bottomViewDidClickDayNightItem:self];
    }
}

- (void)clickSetting
{
    if ([self.delegate respondsToSelector:@selector(bottomViewDidClickSettingItem:)]) {
        [self.delegate bottomViewDidClickSettingItem:self];
    }
}

- (void)setSkin:(LNReaderSkin *)skin
{
    self.backgroundColor = UIColorHex(skin.controlViewBgColor);
    self.dayNightLabel.text = (skin == [LNSkinHelper sharedHelper].nightModeSkin)?@"日间":@"夜间";
    self.dayNightImageview.image = (skin == [LNSkinHelper sharedHelper].nightModeSkin)?[UIImage imageNamed:@"icon_reader_sun_20x20_"]:[UIImage imageNamed:@"icon_reader_moon_20x20_"];
}

@end
