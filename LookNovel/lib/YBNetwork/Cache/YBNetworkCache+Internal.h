//
//  YBNetworkCache+Internal.h
//  YBNetwork<https://github.com/indulgeIn/YBNetwork>
//
//  Created by 杨波 on 2019/4/7.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBNetworkCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBNetworkCache ()

/**
 存数据
 
 @param object 数据对象
 @param key 标识
 */
- (void)setObject:(nullable id<NSCoding>)object forKey:(id)key;

/**
 取数据
 
 @param key 标识
 @param block 回调 (主线程)
 */
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> _Nullable object))block;

@end

NS_ASSUME_NONNULL_END
