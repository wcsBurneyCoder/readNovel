//
//  YBBaseRequest.h
//  YBNetwork<https://github.com/indulgeIn/YBNetwork>
//
//  Created by 杨波 on 2019/4/3.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBNetworkResponse.h"
#import "YBNetworkCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBBaseRequest : NSObject

#pragma - 网络请求数据

/** 请求方法类型 */
@property (nonatomic, assign) YBRequestMethod requestMethod;

/** 请求访问路径 (例如：/detail/list) */
@property (nonatomic, copy) NSString *requestURI;

/** 请求参数 */
@property (nonatomic, copy, nullable) NSDictionary *requestParameter;

/** 请求超时时间 */
@property (nonatomic, assign) NSTimeInterval requestTimeoutInterval;

/** 请求上传文件包 */
@property (nonatomic, copy, nullable) void(^requestConstructingBody)(id<AFMultipartFormData> formData);

/** 下载路径 */
@property (nonatomic, copy) NSString *downloadPath;

#pragma - 发起网络请求

/** 发起网络请求 */
- (void)start;

/** 发起网络请求带回调 */
- (void)startWithSuccess:(nullable YBRequestSuccessBlock)success
                 failure:(nullable YBRequestFailureBlock)failure;

- (void)startWithCache:(nullable YBRequestCacheBlock)cache
               success:(nullable YBRequestSuccessBlock)success
               failure:(nullable YBRequestFailureBlock)failure;

- (void)startWithUploadProgress:(nullable YBRequestProgressBlock)uploadProgress
               downloadProgress:(nullable YBRequestProgressBlock)downloadProgress
                          cache:(nullable YBRequestCacheBlock)cache
                        success:(nullable YBRequestSuccessBlock)success
                        failure:(nullable YBRequestFailureBlock)failure;

/** 取消网络请求 */
- (void)cancel;

#pragma - 相关回调代理

/** 请求结果回调代理 */
@property (nonatomic, weak) id<YBResponseDelegate> delegate;

#pragma - 缓存

/** 缓存处理器 */
@property (nonatomic, strong, readonly) YBNetworkCache *cacheHandler;

#pragma - 其它

/** 网络请求释放策略 (默认 YBNetworkReleaseStrategyHoldRequest) */
@property (nonatomic, assign) YBNetworkReleaseStrategy releaseStrategy;

/** 重复网络请求处理策略 (默认 YBNetworkRepeatStrategyAllAllowed) */
@property (nonatomic, assign) YBNetworkRepeatStrategy repeatStrategy;

/** 是否正在网络请求 */
- (BOOL)isExecuting;

/** 请求标识，可以查看完整的请求路径和参数 */
- (NSString *)requestIdentifier;

#pragma - 网络请求公共配置 (以子类化方式实现: 针对不同的接口团队设计不同的公共配置)

/**
 事务管理器 (通常情况下不需设置) 。注意：
 1、其 requestSerializer 和 responseSerializer 属性会被下面两个同名属性覆盖。
 2、其 completionQueue 属性会被框架内部覆盖。
 */
@property (nonatomic, strong, nullable) AFHTTPSessionManager *sessionManager;

/** 请求序列化器 */
@property (nonatomic, strong) AFHTTPRequestSerializer *requestSerializer;

/** 响应序列化器 */
@property (nonatomic, strong) AFHTTPResponseSerializer *responseSerializer;

/** 服务器地址及公共路径 (例如：https://www.baidu.com) */
@property (nonatomic, copy) NSString *baseURI;

@end


/// 预处理请求数据 (重载分类方法)
@interface YBBaseRequest (PreprocessRequest)

/** 预处理请求参数, 返回处理后的请求参数 */
- (nullable NSDictionary *)yb_preprocessParameter:(nullable NSDictionary *)parameter;

/** 预处理拼接后的完整 URL 字符串, 返回处理后的 URL 字符串 */
- (NSString *)yb_preprocessURLString:(NSString *)URLString;

@end


/// 预处理响应数据 (重载分类方法)
@interface YBBaseRequest (PreprocessResponse)

/** 预处理请求成功数据 (子线程执行, 若数据来自缓存在主线程执行) */
- (void)yb_preprocessSuccessInChildThreadWithResponse:(YBNetworkResponse *)response;

/** 预处理请求成功数据 */
- (void)yb_preprocessSuccessInMainThreadWithResponse:(YBNetworkResponse *)response;

/** 预处理请求失败数据 (子线程执行) */
- (void)yb_preprocessFailureInChildThreadWithResponse:(YBNetworkResponse *)response;

/** 预处理请求失败数据 */
- (void)yb_preprocessFailureInMainThreadWithResponse:(YBNetworkResponse *)response;

@end

NS_ASSUME_NONNULL_END
