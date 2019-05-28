//
//  LNClassifyListCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyListCell.h"

@interface LNClassifyListCell ()
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *retentionLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *autorLabel;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (weak, nonatomic) IBOutlet UIButton *subClassifyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subClassifyWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *followWidth;

@end

@implementation LNClassifyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.coverView.layer.shadowColor = [UIColorHex(@"000000") colorWithAlphaComponent:0.1].CGColor;
    self.coverView.layer.shadowRadius = 3;
    self.coverView.layer.shadowOffset = CGSizeMake(2, 0);
    self.coverView.layer.shadowOpacity = 1;
    
    self.subClassifyBtn.layer.cornerRadius = 9;
    self.followBtn.layer.cornerRadius = 9;
}

- (void)setModel:(LNClassifyBookModel *)model
{
    _model = model;
    
    [self.coverImageView setImageWithURL:[NSURL URLWithString:model.cover] placeholder:defaultCoverImage() options:defaultImageOptions() completion:nil];
    
    self.nameLabel.text = model.title;
    
    self.retentionLabel.text = [NSString stringWithFormat:@"关注度:%.0f%%",model.retentionRatio];
    
    self.introLabel.text = model.shortIntro;
    
    self.autorLabel.text = model.author;
    
    if (model.minorCate.length) {
        self.subClassifyBtn.hidden = NO;
        CGFloat cateWidth = [model.minorCate widthForFont:self.subClassifyBtn.titleLabel.font] + 12;
        [self.subClassifyBtn setTitle:model.minorCate forState:UIControlStateNormal];
        self.subClassifyWidth.constant = cateWidth;
    }
    else{
        self.subClassifyBtn.hidden = YES;
    }
    
    CGFloat follow = 0;
    NSString *followStr = [NSString stringWithFormat:@"%ld人气",model.latelyFollower];
    if (model.latelyFollower > 10000){
        follow = model.latelyFollower / 10000.0;
        followStr = [NSString stringWithFormat:@"%.1f万人气",follow];
    }
    CGFloat followWidth = [followStr widthForFont:self.followBtn.titleLabel.font] + 12;
    self.followWidth.constant = followWidth;
    [self.followBtn setTitle:followStr forState:UIControlStateNormal];
    
}

@end
