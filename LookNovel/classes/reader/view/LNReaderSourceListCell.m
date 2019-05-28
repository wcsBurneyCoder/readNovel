//
//  LNReaderSourceListCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderSourceListCell.h"

@implementation LNReaderSourceListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = UIColorHex(@"cccccc");
        [self.contentView addSubview:divider];
        [divider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.and.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

- (void)setSource:(LNBookLinkSource *)source
{
    _source = source;
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (共%ld章节)",source.name,source.chaptersCount] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:UIColorHex(@"333333")}];
    NSRange range = [attribute.string rangeOfString:source.name];
    [attribute setColor:UIColorHex(@"999999") range:NSMakeRange(range.length, attribute.string.length - range.length)];
    
    if (source.isCurrent) {
        NSAttributedString *current = [[NSAttributedString alloc] initWithString:@"(当前)" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:UIColorHex(@"999999")}];
        [attribute appendAttributedString:current];
    }
    self.textLabel.attributedText = attribute;
    
    self.detailTextLabel.text = source.lastChapter;
    self.detailTextLabel.textColor = UIColorHex(@"666666");
}

@end
