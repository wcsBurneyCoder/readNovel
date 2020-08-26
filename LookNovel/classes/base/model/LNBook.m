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

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"_id": @"bookId", @"cover": @"coverImg"};
}

- (BOOL)isEqual:(LNBook *)other
{
    return [self._id isEqualToString:other._id];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    return [self modelInitWithCoder:coder];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [self modelEncodeWithCoder:coder];
}

@end
