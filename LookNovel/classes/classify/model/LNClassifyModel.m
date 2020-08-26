//
//  LNClassifyModel.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/15.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNClassifyModel.h"

@implementation LNClassifyModel
- (void)setCoverImgs:(NSArray<NSString *> *)coverImgs
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSString *url in coverImgs) {
        NSString *str = [LNCommonHelper getCoverUrl:url];
        [array addObject:str];
    }
    _coverImgs = [array copy];
}
@end

@implementation LNClassifyGroupModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"categories": [LNClassifyModel class]};
}


@end
