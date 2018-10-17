//
//  CFNetworking.m
//  CFNetworkingHelper
//
//  Created by David on 2018/10/17.
//

#import "CFNetworking.h"

#define _cfStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

typedef void(^Failureblock)(NSURLSessionDataTask * _Nullable task, NSError *error);

static CFNetworking *shareFile = nil;

@interface CFNetworking ()

/** AFN Manage类*/
@property (strong, nonatomic) AFHTTPSessionManager *manage;
/**配置文件*/
@property (strong, nonatomic) NSURLSessionConfiguration *configuration;

@property(nonatomic,copy)Failureblock failureblock;

@end

@implementation CFNetworking

#pragma mark - 初始化

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareFile = [super allocWithZone:zone];
    });
    return shareFile;
}

+ (instancetype)shareInstance{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestSerializerType = Type_AFHTTPRequestSerializer;
        self.responseSerializerType = Type_AFJSONResponseSerializer;
        [self setUpAcceptableContentTypes];
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    return shareFile;
}

-(void)dealloc{}
-(void)cf_dealloc{}

+ (instancetype)jsonRequestJsonResponseManager{
    return [self requestType:Type_AFJSONRequestSerializer responseType:Type_AFJSONResponseSerializer];
}

+ (instancetype)jsonRequestHttpResponseManager{
    return [self requestType:Type_AFJSONRequestSerializer responseType:Type_AFJSONResponseSerializer];
}

+ (instancetype)httpRequestJsonResonseManager{
    return [self requestType:Type_AFHTTPRequestSerializer responseType:Type_AFJSONResponseSerializer];
}

+ (instancetype)httpRequestHttpResonseManager{
    return [self requestType:Type_AFHTTPRequestSerializer responseType:Type_AFHTTPResponseSerializer];
}

+ (instancetype)requestType:(RequestSerializerType)requestType responseType:(ResponseSerializerType)responseType{
    CFNetworking *net = [[CFNetworking alloc]init];
    net.requestSerializerType = requestType;
    net.responseSerializerType = responseType;
    [net setUpAcceptableContentTypes];
    return net;
}

#pragma mark - 共有方法
- (void)cancelRequest{
    [self.manage.operationQueue cancelAllOperations];
}

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
                               showHUD:(BOOL)showHUD
                                atView:(nullable UIView *)view{
    if (failure) {
        self.failureblock = failure;
    }
    
    if (showHUD==YES&&view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    return [self.manage GET:URLString
                 parameters:parameters
                   progress:downloadProgress
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        ///1、先判断是否需要关闭HUD
                        if (showHUD == YES&&view) {
                            [MBProgressHUD hideHUDForView:view animated:YES];
                        }
                        ///4、执行success的block
                        if(success){
                            success(task,responseObject);
                        }
                    }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        if (showHUD == YES&&view) {
                            [MBProgressHUD hideHUDForView:view animated:YES];
                        }
                        
                        if (failure) {
                            failure(task,error);
                        }
                    }];
    
}

//post 请求
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
                                showHUD:(BOOL)showHUD
                                 atView:(nullable UIView *)view{
    
    if (failure) {
        self.failureblock = failure;
    }
    
    if (showHUD==YES&&view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    return [self.manage POST:URLString
                  parameters:parameters
                    progress:uploadProgress
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         ///1、先判断是否需要关闭HUD
                         if (showHUD == YES&&view) {
                             [MBProgressHUD hideHUDForView:view animated:YES];
                         }
                         ///4、执行success的block
                         if (success) {
                             success(task,responseObject);
                         }
                         
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         if (showHUD == YES&&view) {
                             [MBProgressHUD hideHUDForView:view animated:YES];
                         }
                         
                         if (failure) {
                             failure(task,error);
                         }
                     }];
}

#pragma mark - 上传文件（image）

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress * _Nonnull progress))uploadProgress
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                                showHUD:(BOOL)showHUD
                                 atView:(nullable UIView *)view{
    
    if (failure) {
        self.failureblock = failure;
    }
    
    if (showHUD == YES&&view) {
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    return [self.manage POST:URLString
                  parameters:parameters
   constructingBodyWithBlock:block
                    progress:uploadProgress
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         if (showHUD == YES&&view) {
                             [MBProgressHUD hideHUDForView:view animated:YES];
                         }
                         ///4、执行success的block
                         if (success) {
                             success(task,responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         if (showHUD == YES&&view) {
                             [MBProgressHUD hideHUDForView:view animated:YES];
                         }
                         
                         if (failure) {
                             failure(task,error);
                         }
                     }];
    
}


#pragma mark - 私有方法

-(void)setUpAcceptableContentTypes{
    self.manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png",@"image/jpeg",@"application/rtf",@"image/gif",@"application/zip",@"audio/x-wav",@"image/tiff",@"application/x-shockwave-flash",@"application/vnd.ms-powerpoint",@"video/mpeg",@"video/quicktime",@"application/x-javascript",@"application/x-gzip",@"application/x-gtar",@"application/msword",@"text/css",@"video/x-msvideo",@"multipart/form-data",@"application/octet-stream",@"text/xml", nil];
}

#pragma mark - 异常处理


#pragma mark - 懒加载

- (AFHTTPSessionManager *)manage{
    if (!_manage) {
        self.configuration.timeoutIntervalForResource = self.timeout;
        _manage = [[AFHTTPSessionManager alloc]initWithBaseURL:nil sessionConfiguration:self.configuration];
    }
    return _manage;
}

- (NSURLSessionConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    return _configuration;
}

-(NSInteger)timeout{
    if (!_timeout) {
        _timeout = TIMEOUT;
    }
    return _timeout;
}

-(void)setResponseSerializerType:(ResponseSerializerType)responseSerializerType{
    _responseSerializerType = responseSerializerType;
    switch (_responseSerializerType) {
        case Type_AFHTTPResponseSerializer:{
            self.manage.responseSerializer = [AFHTTPResponseSerializer serializer];
        }break;
        case Type_AFJSONResponseSerializer:{
            self.manage.responseSerializer = [AFJSONResponseSerializer serializer];
        }break;
        default:{
            self.manage.responseSerializer = [AFJSONResponseSerializer serializer];
        }break;
    }
}

-(void)setRequestSerializerType:(RequestSerializerType)requestSerializerType{
    _requestSerializerType = requestSerializerType;
    switch (_requestSerializerType) {
        case Type_AFJSONRequestSerializer:{
            self.manage.requestSerializer = [AFJSONRequestSerializer serializer];
        }break;
        case Type_AFHTTPRequestSerializer:{
            self.manage.requestSerializer = [AFHTTPRequestSerializer serializer];
        }break;
        default:{
            self.manage.requestSerializer = [AFHTTPRequestSerializer serializer];
        }break;
    }
}

@end
