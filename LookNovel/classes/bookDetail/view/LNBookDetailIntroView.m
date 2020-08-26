//
//  LNBookDetailIntroView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookDetailIntroView.h"
#import "NSDate+LNAdd.h"

@interface LNBookDetailIntroView ()
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastChapterLabel;

@end

@implementation LNBookDetailIntroView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.contentsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContentsView)]];
}

- (void)setDetail:(LNBookDetail *)detail
{
    _detail = detail;
    
    NSString *time = [[NSDate dateWithTimeIntervalSince1970:detail.update.time / 1000] timeIntervalDescription];
    self.updateTimeLabel.text = time;
    self.lastChapterLabel.text = detail.update.chapterName;
    self.introLabel.text = detail.desc;
}

- (void)clickContentsView
{
    if ([self.delegate respondsToSelector:@selector(introViewDidClickChapterList:)]) {
        [self.delegate introViewDidClickChapterList:self];
    }
}
@end
