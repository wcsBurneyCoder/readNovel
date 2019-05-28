//
//  YBNetworkManager.h
//  YBNetwork<https://github.com/indulgeIn/YBNetwork>
//
//  Created by 杨波 on 2019/4/2.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBBaseRequest.h"
#import "YBNetworkResponse.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^YBRequestCompletionBlock)(YBNetworkResponse *response);

@interface YBNetworkManager : NSObject

+ (instancetype)sharedManager;

- (nullable NSNumber *)startNetworkingWithRequest:(YBBaseRequest *)request
                                   uploadProgress:(nullable YBRequestProgressBlock)uploadProgress
                                 downloadProgress:(nullable YBRequestProgressBlock)downloadProgress
                                       completion:(nullable YBRequestCompletionBlock)completion;

- (void)cancelNetworkingWithSet:(NSSet<NSNumber *> *)set;

- (instancetype)init OBJC_UNAVAILABLE("use '+sharedManager' instead");
+ (instancetype)new OBJC_UNAVAILABLE("use '+sharedManager' instead");

@end

NS_ASSUME_NONNULL_END
