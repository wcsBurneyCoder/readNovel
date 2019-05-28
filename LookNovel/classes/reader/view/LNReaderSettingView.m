//
//  LNReaderSettingView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderSettingView.h"

@interface LNReaderSettingView ()
@property (weak, nonatomic) IBOutlet UISlider *brightSlider;
@property (weak, nonatomic) IBOutlet UIButton *fontMinButton;
@property (weak, nonatomic) IBOutlet UIButton *fontPlusButton;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UISwitch *lockSwitch;

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, weak) UIButton *lastButton;

@end

@implementation LNReaderSettingView

- (NSMutableArray *)viewArray
{
    if (!_viewArray) {
        _viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.brightSlider setMinimumTrackTintColor:UIColorHex([LNSkinHelper sharedHelper].currentSkin.appMainColor)];
    [self.lockSwitch setOnTintColor:UIColorHex([LNSkinHelper sharedHelper].currentSkin.appMainColor)];
    self.backScrollView.contentInset = UIEdgeInsetsZero;
    
    self.fontMinButton.layer.cornerRadius = self.fontPlusButton.layer.cornerRadius = 6;
}

- (void)setSkin:(LNReaderSkin *)skin
{
    self.backgroundColor = UIColorHex(skin.controlViewBgColor);
    self.fontMinButton.backgroundColor = UIColorHex(skin.settingBtnColor);
    self.fontPlusButton.backgroundColor = UIColorHex(skin.settingBtnColor);
    for (UIView *subView in self.subviews.firstObject.subviews) {
        if ([subView isKindOfClass:[UILabel class]]){
            UILabel *label = (UILabel *)subView;
            label.textColor = UIColorHex(skin.settingTextColor);
        }
    }
    [self.brightSlider setThumbImage:[UIImage imageNamed:skin.sliderThumb] forState:UIControlStateNormal];
    self.fontSizeLabel.textColor = UIColorHex(skin.settingTextColor);
    
}

- (void)setSkinList:(NSArray<LNReaderSkin *> *)skinList
{
    _skinList = skinList;
    
    for (int i = 0; i < skinList.count; i ++) {
        LNReaderSkin *skin = [skinList objectAtIndex:i];
        UIButton *button = [self buttonWithImage:skin.normalIcon selectImage:skin.selectIcon];
        button.tag = i;
        button.selected = ([skin.Id isEqualToString:[LNSkinHelper sharedHelper].currentReaderSkin.Id]);
        if (button.selected) {
            self.lastButton = button;
        }
        [self.backScrollView addSubview:button];
        [self.viewArray addObject:button];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int idx = 0;
    for (int i = 0; i < self.viewArray.count; i ++) {
        UIButton *button = [self.viewArray objectAtIndex:i];
        if (button.selected) {
            idx = i;
        }
        button.frame = CGRectMake(i * (30 + 20), 0, 30, 30);
    }
    UIButton *last = self.viewArray.lastObject;
    self.backScrollView.contentSize = CGSizeMake(last.right, 0);
    UIButton *select = self.viewArray[idx];
    [self.backScrollView scrollRectToVisible:select.frame animated:YES];
}

- (UIButton *)buttonWithImage:(NSString *)image selectImage:(NSString *)selImage
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(clickSkin:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)clickSkin:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(settingViewDidClickSkinAtIndex:)]) {
        [self.delegate settingViewDidClickSkinAtIndex:button.tag];
    }
    self.lastButton.selected = NO;
    button.selected = YES;
    self.lastButton = button;
}

- (IBAction)toggleSlider:(UISlider *)sender {
    if ([self.delegate respondsToSelector:@selector(settingViewDidChangeBright:)]) {
        [self.delegate settingViewDidChangeBright:sender.value];
    }
}

- (void)setFontSize:(float)fontSize
{
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f",fontSize];
}

- (float)currentFont
{
    return [self.fontSizeLabel.text floatValue];
}

- (void)cancelAllSelect
{
    self.lastButton.selected = NO;
}

- (void)setSelectAtIndex:(NSInteger)index
{
    UIButton *button = [self.viewArray objectAtIndex:index];
    self.lastButton.selected = NO;
    button.selected = YES;
    self.lastButton = button;
}

- (IBAction)clickMinFontButton {
    if ([self.delegate respondsToSelector:@selector(settingViewDidChangeFontSize:)]) {
        [self.delegate settingViewDidChangeFontSize:[self currentFont] - 1];
    }
}

- (IBAction)clickPlusFontButton {
    if ([self.delegate respondsToSelector:@selector(settingViewDidChangeFontSize:)]) {
        [self.delegate settingViewDidChangeFontSize:[self currentFont] + 1];
    }
}

- (IBAction)clickSwitch:(UISwitch *)sender {
    if ([self.delegate respondsToSelector:@selector(settingViewDidChangeSwitch:)]) {
        [self.delegate settingViewDidChangeSwitch:sender.on];
    }
}

- (void)setBright:(float)bright
{
    [self.brightSlider setValue:bright animated:YES];
}

- (void)setNotLock:(BOOL)lock
{
    self.lockSwitch.on = lock;
}
@end
