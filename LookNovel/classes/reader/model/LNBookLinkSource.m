//
//  LNBookLinkSource.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookLinkSource.h"

@implementation LNBookLinkSource
MJCodingImplementation

- (BOOL)isEqual:(LNBookLinkSource *)object
{
    return [self._id isEqualToString:object._id];
}

@end
