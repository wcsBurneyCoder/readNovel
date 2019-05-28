//
//  LNReaderContentCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderContentCell.h"

@interface LNReaderContentCell ()
@property (nonatomic, weak) UILabel *capterLabel;
@property (nonatomic, weak) UILabel *contentTextView;
@end

@implementation LNReaderContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *capterLabel = [[UILabel alloc] init];
        capterLabel.numberOfLines = 0;
        [self.contentView addSubview:capterLabel];
        self.capterLabel = capterLabel;
        
        UILabel *contentTextView = [[UILabel alloc] init];
        contentTextView.numberOfLines = 0;
        [self.contentView addSubview:contentTextView];
        self.contentTextView = contentTextView;
        
        [capterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(capterLabel.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        
    }
    return self;
}

+ (CGFloat)heightWithModel:(LNBookContent *)content
{
    //单例的离屏cell
    static LNReaderContentCell *offscreenCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        offscreenCell = [[LNReaderContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifer"];
    });
    
    //向cell中填充数据
    offscreenCell.content = content;
    //更新约束，防止在填充数据时更新了约束条件
    [offscreenCell setNeedsUpdateConstraints];
    [offscreenCell updateConstraintsIfNeeded];
    //设置屏幕的bounds，注意这里的cellWidth并非一定是屏幕宽度，需要结合实际情况
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    offscreenCell.bounds = CGRectMake(0, 0, cellWidth, CGRectGetHeight(offscreenCell.bounds));
    [offscreenCell setNeedsLayout];
    [offscreenCell layoutIfNeeded];
    
    //自动计算layout的size
    CGSize size = [offscreenCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGFloat height = size.height;
    content.cellHeight = @(height);
    return height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
    self.contentTextView.preferredMaxLayoutWidth = CGRectGetWidth(self.contentTextView.bounds);
    self.capterLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.capterLabel.bounds);
}

- (void)setContent:(LNBookContent *)content
{
    _content = content;
    
    self.capterLabel.attributedText = content.titleAttribute;
    self.contentTextView.attributedText = content.bodyAttribute;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (point.x > kScreenWidth * 0.2 && point.x < kScreenWidth * 0.8) {
        return self;
    }
    return nil;
}
@end
