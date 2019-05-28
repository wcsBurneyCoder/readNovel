//
//  LNBookContent.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/10.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNBookContent.h"

@implementation LNBookContent
MJCodingImplementation

- (NSDictionary *)modelCustomWillTransformFromDictionary:(NSDictionary *)dic
{
    id content = [dic objectForKey:@"cpContent"];
    if (content) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
        [dict setValue:content forKey:@"body"];
        return [dict copy];
    }
    return dic;
}

@end
