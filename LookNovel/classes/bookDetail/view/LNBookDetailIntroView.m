//
//  LNBookDetailIntroView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookDetailIntroView.h"

@interface LNBookDetailIntroView ()
@property (weak, nonatomic) IBOutlet UIView *tagsView;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastChapterLabel;

@end

@implementation LNBookDetailIntroView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.contentsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContentsView)]];
}

- (void)setDetail:(LNBookDetail *)detail
{
    _detail = detail;
    
    self.updateTimeLabel.text = detail.updated;
    self.lastChapterLabel.text = detail.lastChapter;
    self.introLabel.attributedText = detail.longIntroAttribute;
    [self setupTags];
}

- (void)setupTags
{
    CGFloat btnH = 20;
    CGFloat btnMargin = 10;
    CGFloat maxWidth = kScreenWidth - 60;
    CGFloat remainWidth = maxWidth;
    CGFloat sideMargin = 13;
    for (int i = 0; i < self.detail.tags.count; i ++) {
        NSString *title = self.detail.tags[i];
        UIButton *button = [self buttonWithTitle:title];
        CGFloat btnW = MIN(maxWidth, ([title widthForFont:button.titleLabel.font] + 2 * sideMargin));
        BOOL last = i == (self.detail.tags.count - 1);
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.tagsView);
                make.top.equalTo(self.tagsView);
                make.width.mas_equalTo(btnW);
                make.height.mas_equalTo(btnH);
                if (last) {
                    make.bottom.equalTo(self.tagsView);
                }
            }];
            remainWidth -= btnW + btnMargin;
        }
        else{
            UIButton *prevTag = self.tagsView.subviews[i - 1];
            if (remainWidth >= btnW) {
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(prevTag.mas_right).offset(btnMargin);
                    make.top.equalTo(prevTag.mas_top);
                    make.width.mas_equalTo(btnW);
                    make.height.mas_equalTo(btnH);
                    if (last) {
                        make.bottom.equalTo(self.tagsView);
                    }
                }];
                remainWidth -= btnW + btnMargin;
            }
            else{
                remainWidth = maxWidth;
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.tagsView);
                    make.top.equalTo(prevTag.mas_bottom).offset(btnMargin);
                    make.width.mas_equalTo(btnW);
                    make.height.mas_equalTo(btnH);
                    if (last) {
                        make.bottom.equalTo(self.tagsView);
                    }
                }];
                remainWidth -= btnW + btnMargin;
            }
        }
    }
}

- (void)clickContentsView
{
    if ([self.delegate respondsToSelector:@selector(introViewDidClickChapterList:)]) {
        [self.delegate introViewDidClickChapterList:self];
    }
}

- (UIButton *)buttonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    button.layer.cornerRadius = 10;
    [button setTitleColor:UIColorHex(@"999999") forState:UIControlStateNormal];
    button.backgroundColor = UIColorHex(@"eeeeee");
    [self.tagsView addSubview:button];
    return button;
}
@end
