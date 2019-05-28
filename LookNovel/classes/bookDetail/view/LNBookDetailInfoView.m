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
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;

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
    
    self.cateLabel.text = detail.majorCate;
    
    if (detail.wordCount > 10000){
        self.wordLabel.text = [NSString stringWithFormat:@"%.0f万字",(detail.wordCount / 10000.0)];
    }
    else{
        self.wordLabel.text = [NSString stringWithFormat:@"%ld字",detail.wordCount];
    }
    
    if (detail.rating.count > 10000) {
        self.countLabel.text = [NSString stringWithFormat:@"%.1f万人参与评论",(detail.rating.count / 10000.0)];
    }
    else{
        self.countLabel.text = [NSString stringWithFormat:@"%ld人参与评论",detail.rating.count];
    }
    
    self.rateLabel.text = [NSString stringWithFormat:@"%ld%%",detail.retentionRatio];
    self.scoreLabel.text =[NSString stringWithFormat:@"%.1f",detail.rating.score];
    if (detail.latelyFollower > 10000) {
        self.followLabel.text = [NSString stringWithFormat:@"%.0f万",(detail.latelyFollower / 10000.0)];
    }
    else{
        self.followLabel.text = [NSString stringWithFormat:@"%ld",detail.latelyFollower];
    }
}

@end
