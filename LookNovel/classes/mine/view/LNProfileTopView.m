//
//  LNProfileTopView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/17.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNProfileTopView.h"

@interface LNProfileTopView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *headIcon;

@end

@implementation LNProfileTopView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.headIcon.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headIcon.clipsToBounds = YES;
    self.headIcon.layer.cornerRadius = 35;
    [self.headIcon addTarget:self action:@selector(clickHead) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setHeadImageView:(UIImage *)image
{
    [self.headIcon setImage:image forState:UIControlStateNormal];
    
    self.bgImageView.image = [image imageByBlurRadius:25 tintColor:nil tintMode:0 saturation:1.0 maskImage:nil];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIImageView *mask = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_mine_head_375x200_"]];
    mask.frame = self.bgImageView.frame;
    self.bgImageView.layer.mask = mask.layer;
}

- (void)clickHead
{
    if (self.clickHeadIcon) {
        self.clickHeadIcon(self);
    }
}
@end
