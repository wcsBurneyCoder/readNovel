//
//  LNHistoryCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNHistoryCell.h"

@interface LNHistoryCell ()
@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;

@end

@implementation LNHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.coverView addShadowWithColor:nil];
}

- (void)setBook:(LNRecentBook *)book
{
    _book = book;
    
    [self.coverImageView setImageWithURL:[NSURL URLWithString:book.cover] placeholder:defaultCoverImage() options:defaultImageOptions() completion:nil];
    
    self.nameLabel.text = book.title;
    
    LNBookChapter *chapter = book.chapters[book.chapterIndex];
    self.chapterLabel.text = [NSString stringWithFormat:@"阅读到:%@",chapter.name];
    
    NSDate *date = [NSDate dateWithString:book.lastReadTime format:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = book.lastReadTime;
    if (date.year == [NSDate date].year) {
        dateStr = [date stringWithFormat:@"MM-dd HH:mm"];
    }
    self.lastTimeLabel.text = [NSString stringWithFormat:@"上次阅读时间:%@",dateStr];
}

@end
