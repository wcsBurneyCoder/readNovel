//
//  LNSearchSuggestCell.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/21.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNSearchSuggestCell.h"

@interface LNSearchSuggestCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation LNSearchSuggestCell

- (void)setSuggest:(LNSuggest *)suggest
{
    self.icon.image = [UIImage imageNamed:suggest.iconName];
    self.nameLabel.text = suggest.text;
}

@end
