//
//  CFNetworking.h
//  CFNetworkingHelper
//
//  Created by David on 2018/10/17.
/**
 本工具类的目的：
 1、封装一层AFN请求发起的代码，目的使网络请求更加简单
 2、实用于简单快速的网络请求需求
 3、进行网络请求需要先确定ATS设置
 4、大型项目建议使用YTK
 */

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

static NSInteger const TIMEOUT = 10;

typedef enum : NSUInteger {
    Type_AFHTTPRequestSerializer = 0,           //二进制
    Type_AFJSONRequestSerializer,               //json格式
} RequestSerializerType;

typedef enum : NSUInteger {
    Type_AFJSONResponseSerializer = 0,          //默认返回josn格式
    Type_AFHTTPResponseSerializer,              //二进制
} ResponseSerializerType;

@interface CFNetworking : NSObject

/**超时时间(s) 默认10s*/
@property (assign, nonatomic) NSInteger              timeout;
/**request 序列化类型*/
@property (assign, nonatomic) RequestSerializerType  requestSerializerType;
/**response 序列化类型*/
@property (assign, nonatomic) ResponseSerializerType responseSerializerType;

///单例
+ (instancetype)shareInstance;

+ (instancetype)jsonRequestJsonResponseManager;
+ (instancetype)jsonRequestHttpResponseManager;
+ (instancetype)httpRequestJsonResonseManager;
+ (instancetype)httpRequestHttpResonseManager;



///GET
- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
                               showHUD:(BOOL)showHUD
                                atView:(nullable UIView *)view;
///POST
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
                                showHUD:(BOOL)showHUD
                                 atView:(nullable UIView *)view;
///FORM-DATA
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(id)parameters
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress * _Nonnull progress))uploadProgress
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                                showHUD:(BOOL)showHUD
                                 atView:(nullable UIView *)view;
@end

NS_ASSUME_NONNULL_END
