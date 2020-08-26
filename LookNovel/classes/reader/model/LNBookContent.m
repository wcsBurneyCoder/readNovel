//
//  LNBookContent.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookContent.h"

@implementation LNBookContent

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"chapterId": @"id"};
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
