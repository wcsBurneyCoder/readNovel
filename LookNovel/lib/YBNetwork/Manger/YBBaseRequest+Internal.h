//
//  YBBaseRequest+Internal.h
//  YBNetwork<https://github.com/indulgeIn/YBNetwork>
//
//  Created by 杨波 on 2019/4/3.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBBaseRequest ()

/// 请求方法字符串
- (NSString *)requestMethodString;

/// 请求 URL 字符串
- (NSString *)requestURLString;

@end

NS_ASSUME_NONNULL_END
