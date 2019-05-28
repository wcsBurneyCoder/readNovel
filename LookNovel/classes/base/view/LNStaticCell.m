//
//  LNStaticCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNStaticCell.h"

@interface LNStaticCell ()
/**底部分割线*/
@property (nonatomic, weak) UIView *dividerView;
/**右侧箭头*/
@property (nonatomic, weak) UIImageView *indicatorView;
@end

@implementation LNStaticCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *dividerView = [[UIView alloc] init];
        dividerView.backgroundColor = UIColorHex(@"eeeeee");
        [self.contentView addSubview:dividerView];
        self.dividerView = dividerView;
        
        UIImageView *indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jiantou"]];
        self.accessoryView = indicatorView;
        self.indicatorView = indicatorView;
        
        self.textLabel.font = [UIFont systemFontOfSize:15.0];
        self.textLabel.textColor = UIColorHex(@"333333");
    }
    return self;
}

- (void)removeDivider
{
    [self.dividerView removeFromSuperview];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.left += 5;
    
    self.indicatorView.size = self.indicatorView.image.size;
    
    self.dividerView.frame = CGRectMake(20, self.height - 1, self.width - 40, 0.5);
}

- (void)setModel:(LNStaticModel *)model
{
    _model = model;
    
    if (model.icon) {
        self.imageView.image = [UIImage imageNamed:model.icon];
    }
    if (model.title) {
        self.textLabel.text = model.title;
    }
}

@end
