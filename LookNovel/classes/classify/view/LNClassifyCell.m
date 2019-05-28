//
//  LNClassifyCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyCell.h"

@interface LNClassifyCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lastImageView;
@property (weak, nonatomic) IBOutlet UIImageView *middleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIView *imageContentView;

@end

@implementation LNClassifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 3;
    self.imageContentView.layer.shadowOffset = CGSizeMake(0, 1);
    self.imageContentView.layer.shadowRadius = 3;
    self.imageContentView.layer.shadowColor = [UIColorHex(@"000000") colorWithAlphaComponent:0.4].CGColor;
}


- (void)setModel:(LNClassifyModel *)model
{
    _model = model;
    
    self.nameLabel.text = model.name;
    self.bookNumLabel.text = [NSString stringWithFormat:@"%ld本",model.bookCount];
    
    [self.firstImageView setImageURL:[NSURL URLWithString:model.bookCover.firstObject]];
    [self.middleImageView setImageURL:[NSURL URLWithString:model.bookCover[1]]];
    [self.lastImageView setImageURL:[NSURL URLWithString:model.bookCover.lastObject]];
}
@end
