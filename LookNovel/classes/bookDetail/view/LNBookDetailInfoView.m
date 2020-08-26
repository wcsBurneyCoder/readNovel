//
//  LNBookDetailInfoView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookDetailInfoView.h"

@interface LNBookDetailInfoView ()
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *cateLabel;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;

@end

@implementation LNBookDetailInfoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.coverView addShadowWithColor:nil];
}

- (void)setDetail:(LNBookDetail *)detail
{
    _detail = detail;
    
    [self.coverImageView setImageWithURL:[NSURL URLWithString:detail.cover] placeholder:defaultCoverImage() options:defaultImageOptions() completion:nil];
    
    self.titleLabel.text = detail.title;
    
    self.authorLabel.text = detail.author;
    
    self.cateLabel.text = detail.categoryName;
    
    self.wordLabel.text = detail.word;
}

@end
