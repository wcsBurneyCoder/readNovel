//
//  LNRightLabelStaticModel.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/20.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNStaticModel.h"

@interface LNRightLabelStaticModel : LNStaticModel
/**内容*/
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@end
