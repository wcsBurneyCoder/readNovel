//
//  LNClassifyGroupCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyGroupCell.h"

@interface LNClassifyGroupCell ()
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation LNClassifyGroupCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.indicatorView.layer.cornerRadius = 1;
}

- (void)setGroupModel:(LNClassifyGroupModel *)groupModel
{
    _groupModel = groupModel;
    
    self.titleLabel.text = groupModel.channelName;
    
    if (groupModel.selected) {
        self.backgroundColor = UIColorHex(@"F9F9FB");
        self.indicatorView.hidden = NO;
    }
    else{
        self.backgroundColor = UIColorHex(@"ffffff");
        self.indicatorView.hidden = YES;
    }
}

@end
