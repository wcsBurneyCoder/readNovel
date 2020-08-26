//
//  LNBookChapter.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookChapter.h"

@implementation LNBookChapter

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"Id": @"id"};
}

- (BOOL)isEqual:(LNBookChapter *)other
{
    return [self.Id isEqualToString:other.Id];
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
