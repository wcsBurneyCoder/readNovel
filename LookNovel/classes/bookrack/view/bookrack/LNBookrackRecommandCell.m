//
//  LNBookrackRecommandCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookrackRecommandCell.h"

@interface LNBookrackRecommandCell ()
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;

@end

@implementation LNBookrackRecommandCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.coverImageView.layer.cornerRadius = 4;
    self.coverView.layer.cornerRadius = 4;
    [self.coverView addShadowWithColor:nil];
}

- (void)setBookModel:(LNRecommnadBook *)bookModel
{
    _bookModel = bookModel;
    
    if ([bookModel.cover hasPrefix:@"http"]) {
        [self.coverImageView setImageWithURL:[NSURL URLWithString:bookModel.cover] placeholder:defaultCoverImage() options:defaultImageOptions() completion:nil];
    }
    else
        self.coverImageView.image = [UIImage imageNamed:bookModel.cover];
    
    self.nameLabel.text = bookModel.title;
}

@end
