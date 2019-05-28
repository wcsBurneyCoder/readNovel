//
//  LNRightLabelCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNRightLabelCell.h"

@interface LNRightLabelCell ()
@property (nonatomic, strong) UILabel *rightLabel;
@end

@implementation LNRightLabelCell

- (UILabel *)rightLabel
{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _rightLabel.textColor = UIColorHex(@"999999");
    }
    return _rightLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = MIN(self.contentView.width * 0.5, [self.rightLabel.text widthForFont:self.rightLabel.font]);
    
    self.rightLabel.frame = CGRectMake(self.contentView.width - 25 - width, 0, width, self.contentView.height);
    
}

- (void)setModel:(LNStaticModel *)model
{
    [super setModel:model];
    
    if ([model isKindOfClass:[LNRightLabelStaticModel class]]) {
        LNRightLabelStaticModel *setModel = (LNRightLabelStaticModel *)model;
        self.rightLabel.text = setModel.text;
        if (setModel.textColor) {
            self.rightLabel.textColor = setModel.textColor;
        }
        if (setModel.textFont) {
            self.rightLabel.font = setModel.textFont;
        }
        self.accessoryView = nil;
    }
}

@end
