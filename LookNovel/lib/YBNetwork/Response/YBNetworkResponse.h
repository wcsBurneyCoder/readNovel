//
//  YBNetworkResponse.h
//  YBNetwork<https://github.com/indulgeIn/YBNetwork>
//
//  Created by 杨波 on 2019/4/6.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBNetworkDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBNetworkResponse : NSObject

/// 请求成功数据
@property (nonatomic, strong, nullable) id responseObject;

/// 请求失败类型 (使用该属性做业务处理足够)
@property (nonatomic, assign) YBResponseErrorType errorType;

/// 请求失败 NSError
@property (nonatomic, strong, nullable) NSError *error;


/// 请求任务
@property (nonatomic, strong, readonly, nullable) NSURLSessionTask *sessionTask;

/// sessionTask.response
@property (nonatomic, strong, readonly, nullable) NSHTTPURLResponse *URLResponse;


+ (instancetype)responseWithSessionTask:(nullable NSURLSessionTask *)sessionTask
                         responseObject:(nullable id)responseObject
                                  error:(nullable NSError *)error;

@end

NS_ASSUME_NONNULL_END
