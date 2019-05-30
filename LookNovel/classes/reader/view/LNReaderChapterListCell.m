//
//  LNReaderChapterListCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNReaderChapterListCell.h"

@interface LNReaderChapterListCell ()
@property (nonatomic, weak) UIImageView *lockView;
@end

@implementation LNReaderChapterListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor clearColor];
        UIView *divider = [[UIView alloc] init];
        divider.backgroundColor = UIColorHex(@"cccccc");
        [self.contentView addSubview:divider];
        [divider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.and.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
        
        UIImageView *lockView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forum_lock_9x11_"]];
        [self.contentView addSubview:lockView];
        self.lockView = lockView;
        [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.mas_equalTo(9);
            make.height.mas_equalTo(11);
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.width -= 15;
}

- (void)setChapter:(LNBookChapter *)chapter
{
    _chapter = chapter;
    
    self.textLabel.text = chapter.isCurrent?[chapter.title stringByAppendingString:@"(当前)"]:chapter.title;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.lockView.hidden = !chapter.isVip;
    self.textLabel.textColor = UIColorHex([LNSkinHelper sharedHelper].currentReaderSkin.chapterColor)?:UIColorHex(@"666666");
}

@end
