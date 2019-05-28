//
//  LNClassifyModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyModel.h"

@implementation LNClassifyModel
- (void)setBookCover:(NSArray<NSString *> *)bookCover
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSString *url in bookCover) {
        NSString *str = [LNCommonHelper getCoverUrl:url];
        [array addObject:str];
    }
    _bookCover = [array copy];
}
@end

@implementation LNClassifyGroupModel


@end
