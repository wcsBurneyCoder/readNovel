//
//  YBNetworkManager.m
//  YBNetwork<https://github.com/indulgeIn/YBNetwork>
//
//  Created by 杨波 on 2019/4/2.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBNetworkManager.h"
#import "YBBaseRequest+Internal.h"
#import <pthread/pthread.h>

#define YBNM_TASKRECORD_LOCK(...) \
pthread_mutex_lock(&self->_lock); \
__VA_ARGS__ \
pthread_mutex_unlock(&self->_lock);

@interface YBNetworkManager ()
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSURLSessionTask *> *taskRecord;
@end

@implementation YBNetworkManager {
    pthread_mutex_t _lock;
}

#pragma mark - life cycle

- (void)dealloc {
    pthread_mutex_destroy(&_lock);
}

+ (instancetype)sharedManager {
    static YBNetworkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[YBNetworkManager alloc] initSpecially];
    });
    return manager;
}

- (instancetype)initSpecially {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

#pragma mark - private

- (void)cancelTaskWithIdentifier:(NSNumber *)identifier {
    YBNM_TASKRECORD_LOCK(NSURLSessionTask *task = self.taskRecord[identifier];)
    if (task) {
        [task cancel];
        YBNM_TASKRECORD_LOCK([self.taskRecord removeObjectForKey:identifier];)
    }
}

- (void)cancelAllTask {
    YBNM_TASKRECORD_LOCK(
        for (NSURLSessionTask *task in self.taskRecord) {
            [task cancel];
        }
        [self.taskRecord removeAllObjects];
    )
}

- (NSNumber *)startDownloadTaskWithManager:(AFHTTPSessionManager *)manager URLRequest:(NSURLRequest *)URLRequest downloadPath:(NSString *)downloadPath  downloadProgress:(nullable YBRequestProgressBlock)downloadProgress completion:(YBRequestCompletionBlock)completion {
    
    // 保证下载路径是文件而不是目录
    NSString *validDownloadPath = downloadPath.copy;
    BOOL isDirectory;
    if(![[NSFileManager defaultManager] fileExistsAtPath:validDownloadPath isDirectory:&isDirectory]) {
        isDirectory = NO;
    }
    if (isDirectory) {
        validDownloadPath = [NSString pathWithComponents:@[validDownloadPath, URLRequest.URL.lastPathComponent]];
    }
    
    // 若存在文件则移除
    if ([[NSFileManager defaultManager] fileExistsAtPath:validDownloadPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:validDownloadPath error:nil];
    }
    
    __block NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:URLRequest progress:downloadProgress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:validDownloadPath isDirectory:NO];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        YBNM_TASKRECORD_LOCK([self.taskRecord removeObjectForKey:@(task.taskIdentifier)];)
        if (completion) {
            completion([YBNetworkResponse responseWithSessionTask:task responseObject:filePath error:error]);
        }
    }];
    
    NSNumber *taskIdentifier = @(task.taskIdentifier);
    YBNM_TASKRECORD_LOCK(self.taskRecord[taskIdentifier] = task;)
    [task resume];
    return taskIdentifier;
}

- (NSNumber *)startDataTaskWithManager:(AFHTTPSessionManager *)manager URLRequest:(NSURLRequest *)URLRequest uploadProgress:(nullable YBRequestProgressBlock)uploadProgress downloadProgress:(nullable YBRequestProgressBlock)downloadProgress completion:(YBRequestCompletionBlock)completion {
    
    __block NSURLSessionDataTask *task = [manager dataTaskWithRequest:URLRequest uploadProgress:^(NSProgress * _Nonnull _uploadProgress) {
        if (uploadProgress) {
            uploadProgress(_uploadProgress);
        }
    } downloadProgress:^(NSProgress * _Nonnull _downloadProgress) {
        if (downloadProgress) {
            downloadProgress(_downloadProgress);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        YBNM_TASKRECORD_LOCK([self.taskRecord removeObjectForKey:@(task.taskIdentifier)];)
        if (completion) {
            completion([YBNetworkResponse responseWithSessionTask:task responseObject:responseObject error:error]);
        }
    }];
    
    NSNumber *taskIdentifier = @(task.taskIdentifier);
    YBNM_TASKRECORD_LOCK(self.taskRecord[taskIdentifier] = task;)
    [task resume];
    return taskIdentifier;
}

#pragma mark - public

- (void)cancelNetworkingWithSet:(NSSet<NSNumber *> *)set {
    YBNM_TASKRECORD_LOCK(
        for (NSNumber *identifier in set) {
            NSURLSessionTask *task = self.taskRecord[identifier];
            if (task) {
                [task cancel];
                [self.taskRecord removeObjectForKey:identifier];
            }
        }
    )
}

- (NSNumber *)startNetworkingWithRequest:(YBBaseRequest *)request uploadProgress:(nullable YBRequestProgressBlock)uploadProgress downloadProgress:(nullable YBRequestProgressBlock)downloadProgress completion:(nullable YBRequestCompletionBlock)completion {
    
    // 构建网络请求数据
    NSString *method = [request requestMethodString];
    AFHTTPRequestSerializer *serializer = [self requestSerializerForRequest:request];
    NSString *URLString = [self URLStringForRequest:request];
    id parameter = [self parameterForRequest:request];
    
    // 构建 URLRequest
    NSError *error = nil;
    NSMutableURLRequest *URLRequest = nil;
    if (request.requestConstructingBody) {
        URLRequest = [serializer multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:parameter constructingBodyWithBlock:request.requestConstructingBody error:&error];
    } else {
        URLRequest = [serializer requestWithMethod:method URLString:URLString parameters:parameter error:&error];
    }
    
    if (error) {
        if (completion) completion([YBNetworkResponse responseWithSessionTask:nil responseObject:nil error:error]);
        return nil;
    }
    
    // 发起网络请求
    AFHTTPSessionManager *manager = [self sessionManagerForRequest:request];
    if (request.downloadPath.length > 0) {
        return [self startDownloadTaskWithManager:manager URLRequest:URLRequest downloadPath:request.downloadPath downloadProgress:downloadProgress completion:completion];
    } else {
        return [self startDataTaskWithManager:manager URLRequest:URLRequest uploadProgress:uploadProgress downloadProgress:downloadProgress completion:completion];
    }
}

#pragma mark - read info from request

- (AFHTTPRequestSerializer *)requestSerializerForRequest:(YBBaseRequest *)request {
    AFHTTPRequestSerializer *serializer = request.requestSerializer ?: [AFJSONRequestSerializer serializer];
    if (request.requestTimeoutInterval > 0) {
        serializer.timeoutInterval = request.requestTimeoutInterval;
    }
    return serializer;
}

- (NSString *)URLStringForRequest:(YBBaseRequest *)request {
    NSString *URLString = [request requestURLString];
    if ([request respondsToSelector:@selector(yb_preprocessURLString:)]) {
        URLString = [request yb_preprocessURLString:URLString];
    }
    return URLString;
}

- (id)parameterForRequest:(YBBaseRequest *)request {
    id parameter = request.requestParameter;
    if ([request respondsToSelector:@selector(yb_preprocessParameter:)]) {
        parameter = [request yb_preprocessParameter:parameter];
    }
    return parameter;
}

- (AFHTTPSessionManager *)sessionManagerForRequest:(YBBaseRequest *)request {
    AFHTTPSessionManager *manager = request.sessionManager;
    if (!manager) {
        static AFHTTPSessionManager *defaultManager = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            defaultManager = [AFHTTPSessionManager new];
        });
        manager = defaultManager;
    }
    manager.completionQueue = dispatch_queue_create("com.ybnetwork.completionqueue", DISPATCH_QUEUE_CONCURRENT);
    if (request.responseSerializer) manager.responseSerializer = request.responseSerializer;
    return manager;
}

#pragma mark - getter

- (NSMutableDictionary<NSNumber *,NSURLSessionTask *> *)taskRecord {
    if (!_taskRecord) {
        _taskRecord = [NSMutableDictionary dictionary];
    }
    return _taskRecord;
}

@end
