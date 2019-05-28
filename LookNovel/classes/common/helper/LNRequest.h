//
//  LNRequest.h
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "YBBaseRequest.h"

typedef void(^httpCompleteBlock)(id result, BOOL cache, NSError *error);

@interface LNRequest : YBBaseRequest

+ (void)GET:(NSString *)url params:(NSDictionary *)params cache:(BOOL)cache complete:(httpCompleteBlock)completeBlock;

+ (void)POST:(NSString *)url params:(NSDictionary *)params cache:(BOOL)cache complete:(httpCompleteBlock)completeBlock;

+ (float)cacheSize;

+ (void)clearCache;

@end
