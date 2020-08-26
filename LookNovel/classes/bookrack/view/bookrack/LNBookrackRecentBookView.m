//
//  LNBookrackRecentBookView.m
//  
//
//  Created by wangchengshan on 2019/5/9.
//

#import "LNBookrackRecentBookView.h"
#import "ZHWave.h"

@interface LNBookrackRecentBookView ()
@property (weak, nonatomic) IBOutlet UILabel *noDataLabel;
@property (weak, nonatomic) IBOutlet UIView *recentView;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chapterLabel;
@property (weak, nonatomic) IBOutlet UIView *continueView;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIView *waveContentView;
@property (nonatomic, weak) ZHWave *WaveView;

@end

@implementation LNBookrackRecentBookView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.coverImageView addShadowWithColor:nil];
    
    [self.continueView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContinue)]];
    
    self.coverImageView.userInteractionEnabled = YES;
    [self.coverImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickContinue)]];
    
    ZHWave *WaveView =[[ZHWave alloc]init];
    WaveView.waveHeight = 13;
    WaveView.waveSpeed = .4;
    WaveView.wavecolor = [UIColor whiteColor];
    [WaveView startWaveAnimation];
    [self.waveContentView addSubview:WaveView];
    self.WaveView = WaveView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.WaveView.frame = self.waveContentView.bounds;
}

- (void)setRecentBook:(LNRecentBook *)recentBook
{
    _recentBook = recentBook;
    self.recentView.hidden = (recentBook == nil);
    self.noDataLabel.hidden = !self.recentView.hidden;
    if (recentBook) {
        [self.coverImageView setImageWithURL:[NSURL URLWithString:recentBook.cover] placeholder:defaultCoverImage() options:defaultImageOptions() completion:nil];
        
        self.nameLabel.text = recentBook.title;
        LNBookChapter *chapter = recentBook.chapters[recentBook.chapterIndex];
        self.chapterLabel.text = chapter.name;
        self.percentLabel.text = [NSString stringWithFormat:@"读至%.1f%%",recentBook.readRatio];
        
    }
}

- (void)clickContinue
{
    if (self.clickContinueBlock) {
        self.clickContinueBlock(self);
    }
}
@end
