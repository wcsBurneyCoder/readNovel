//
//  LNBook.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/17.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBook.h"

@implementation LNBook
- (void)setCover:(NSString *)cover
{
    _cover = [LNCommonHelper getCoverUrl:cover];
}

@end
