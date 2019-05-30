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
    UIColor *sourceColor = UIColorHex([LNSkinHelper sharedHelper].currentReaderSkin.sourceColor)?:UIColorHex(@"666666");
    UIColor *chapterColor = UIColorHex([LNSkinHelper sharedHelper].currentReaderSkin.chapterColor)?:UIColorHex(@"666666");
    UIColor *currentColor = UIColorHex([LNSkinHelper sharedHelper].currentReaderSkin.chapterColor)?:UIColorHex(@"666666");
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ (共%ld章节)",source.name,source.chaptersCount] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:sourceColor}];
    NSRange range = [attribute.string rangeOfString:source.name];
    [attribute setColor:sourceColor range:NSMakeRange(range.length, attribute.string.length - range.length)];
    
    if (source.isCurrent) {
        NSAttributedString *current = [[NSAttributedString alloc] initWithString:@"(当前)" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:currentColor}];
        [attribute appendAttributedString:current];
    }
    self.textLabel.attributedText = attribute;
    
    self.detailTextLabel.text = source.lastChapter;
    self.detailTextLabel.textColor = chapterColor;
}

@end
