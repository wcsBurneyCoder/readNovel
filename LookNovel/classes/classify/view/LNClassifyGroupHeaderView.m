//
//  LNClassifyGroupHeaderView.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/16.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyGroupHeaderView.h"

@interface  LNClassifyGroupHeaderView ()
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation LNClassifyGroupHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *leftLine =[[UIView alloc] init];
        leftLine.backgroundColor = UIColorHex(@"F8F8F8");
        [self addSubview:leftLine];
        
        UIView *rightLine =[[UIView alloc] init];
        rightLine.backgroundColor = UIColorHex(@"F8F8F8");
        [self addSubview:rightLine];

        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = UIColorHex(@"cccccc");
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.right.equalTo(titleLabel.mas_left).offset(-15);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(1);
        }];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(15);
            make.right.equalTo(self).offset(-12);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setGroupModel:(LNClassifyGroupModel *)groupModel
{
    _groupModel = groupModel;
    
    self.titleLabel.text = groupModel.channelName;
}

@end
