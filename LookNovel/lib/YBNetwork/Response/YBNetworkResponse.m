//
//  YBNetworkResponse.m
//  YBNetwork<https://github.com/indulgeIn/YBNetwork>
//
//  Created by 杨波 on 2019/4/6.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBNetworkResponse.h"

@implementation YBNetworkResponse

#pragma mark - life cycle

+ (instancetype)responseWithSessionTask:(NSURLSessionTask *)sessionTask responseObject:(id)responseObject error:(NSError *)error {
    YBNetworkResponse *response = [YBNetworkResponse new];
    response->_sessionTask = sessionTask;
    response->_responseObject = responseObject;
    if (error) {
        response->_error = error;
        YBResponseErrorType errorType;
        switch (error.code) {
            case NSURLErrorTimedOut:
                errorType = YBResponseErrorTypeTimedOut;
                break;
            case NSURLErrorCancelled:
                errorType = YBResponseErrorTypeCancelled;
                break;
            default:
                errorType = YBResponseErrorTypeNoNetwork;
                break;
        }
        response->_errorType = errorType;
    }
    return response;
}

#pragma mark - getter

- (NSHTTPURLResponse *)URLResponse {
    if (!self.sessionTask || ![self.sessionTask.response isKindOfClass:NSHTTPURLResponse.class]) {
        return nil;
    }
    return (NSHTTPURLResponse *)self.sessionTask.response;
}

@end
