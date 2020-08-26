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
    
    self.retentionLabel.text = model.categoryName;
    
    self.introLabel.text = model.desc;
    
    self.autorLabel.text = model.author;
    
    if (model.word.length == 0) {
        self.followBtn.hidden = YES;
    }
    else {
        self.followBtn.hidden = NO;
        CGFloat wordWidth = [model.word widthForFont:self.followBtn.titleLabel.font] + 12;
        self.followWidth.constant = wordWidth;
        [self.followBtn setTitle:model.word forState:UIControlStateNormal];
    }
}

@end
