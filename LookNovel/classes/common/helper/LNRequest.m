//
//  LNRequest.m
//  LookNovel
//
//  Created by wangchengshan on 2019/5/9.
//  Copyright © 2019 wcs Co.,ltd. All rights reserved.
//

#import "LNRequest.h"

@implementation LNRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 8;
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:self.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        self.responseSerializer.acceptableContentTypes = contentTypes;
        self.releaseStrategy = YBNetworkReleaseStrategyHoldRequest;
        self.repeatStrategy = YBNetworkRepeatStrategyCancelNewest;
        [self.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Safari/605.1.15" forHTTPHeaderField:@"User-Agent"];
    }
    return self;
}

+ (void)GET:(NSString *)url params:(NSDictionary *)params cache:(BOOL)cache complete:(nonnull httpCompleteBlock)completeBlock
{
    [self startRequestWithMethod:YBRequestMethodGET url:url params:params cache:cache complete:completeBlock];
    
}

+ (void)POST:(NSString *)url params:(NSDictionary *)params cache:(BOOL)cache complete:(httpCompleteBlock)completeBlock
{
    [self startRequestWithMethod:YBRequestMethodPOST url:url params:params cache:cache complete:completeBlock];
}

+ (void)startRequestWithMethod:(YBRequestMethod)method url:(NSString *)url params:(NSDictionary *)params cache:(BOOL)cache complete:(nonnull httpCompleteBlock)completeBlock
{
    LNRequest *request = [[self alloc] init];
    request.requestMethod = method;
    request.requestURI = url;
    request.requestParameter = params;
    if (cache) {
        request.cacheHandler.readMode = YBNetworkCacheReadModeNotCallBackNetwork;
        request.cacheHandler.writeMode = YBNetworkCacheWriteModeMemoryAndDisk;
    }
    void (^cacheBlock)(YBNetworkResponse * response) = cache?(^(YBNetworkResponse * response){
        if (completeBlock) {
            completeBlock(response.responseObject, YES, nil);
        }
    }):NULL;
    [request startWithCache:cacheBlock success:^(YBNetworkResponse * _Nonnull response) {
        if (completeBlock) {
            completeBlock(response.responseObject, NO, nil);
        }
    } failure:^(YBNetworkResponse * _Nonnull response) {
        if (completeBlock) {
            completeBlock(nil, NO, response.error);
        }
    }];
}

/** 预处理请求成功数据 */
- (void)yb_preprocessSuccessInMainThreadWithResponse:(YBNetworkResponse *)response
{
    
}

/** 预处理请求失败数据 */
- (void)yb_preprocessFailureInMainThreadWithResponse:(YBNetworkResponse *)response
{
    NSError *err = response.error;
    switch (response.errorType) {
        case YBResponseErrorTypeTimedOut:
            err = [NSError errorWithDomain:@"请求超时" code:err.code userInfo:nil];
            break;
        case YBResponseErrorTypeCancelled:
            break;
            case YBResponseErrorTypeNoNetwork:
            err = [NSError errorWithDomain:@"网络连接失败，请检查网络" code:err.code userInfo:nil];
            break;
        default:
            break;
    }
    response.error = err;
}

+ (float)cacheSize
{
    return [YBNetworkCache getDiskCacheSize];
}

+ (void)clearCache
{
    [YBNetworkCache removeDiskCache];
}
@end
