//
//  LNBookDetailBottomView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookDetailBottomView.h"

@interface LNBookDetailBottomView ()
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end

@implementation LNBookDetailBottomView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.actionButton.backgroundColor = UIColorHex([LNSkinHelper sharedHelper].currentSkin.appMainColor);
    self.actionButton.layer.cornerRadius = 6;
}

- (IBAction)clickAction {
    if (self.clickActionBlock) {
        self.clickActionBlock();
    }
}

@end
