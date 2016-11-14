//
//  HSHTTPClient.m
//
//  Created by Song Hua on 16/9/23.
//  Copyright © 2016年 Song Hua. All rights reserved.
//

#import "HSHTTPClient.h"
#import "MBProgressHUD+Ex.h"



@interface HSHTTPClient ()
@property (nonatomic, strong) AFNetworkReachabilityManager *manager;
@end
@implementation HSHTTPClient

static HSHTTPClient * _instance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HSHTTPClient alloc]init];
        
        //申明返回的结果是json类型
        _instance.responseSerializer = [AFJSONResponseSerializer serializer];
        
        //如果报接受类型不一致请替换一致text/html或别的
        _instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/x-json",@"text/html",@"text/plain",nil];

    });
    return _instance;
}

#pragma mark - 第一次封装 GET 和 POST,我们使用枚举参数,来区分get和post
-(void)request:(HSHTTPClientType)type URLString:(NSString *)URLString parameters:(id)parameters progress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure{
    if (type == GET) {
        [self GET:URLString parameters:parameters success:success failure:failure];
    }else if (type == POST){
        [self POST:URLString parameters:parameters success:success failure:failure];
    }
}

/*
1.progress downloadProgress: ((NSProgress) -> Void)? 没用
2.成功或者失败的回调的 NSURLSessionDataTask 没用
3. 返回的数据是 AnyObject?,我们需要自己处理
*/
#pragma mark - 第二次封装,处理返回的数据,和判断网络状态
-(void)request:(HSHTTPClientType)type URLString:(NSString *)URLString parameters:(id)parameters  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    void (^orginalSuccess)(NSURLSessionDataTask * task,id json) = ^(NSURLSessionDataTask * task,id json){
        // 网络请求返回之后,我们对数据进行处理
        if (success) {
            // 如果有数据,我们该
            success(json);
        }
    };
    void (^orginalFailure)(NSURLSessionDataTask * task,NSError * error) = ^(NSURLSessionDataTask * task,NSError * error){
        // 网络请求返回之后,我们对数据进行处理
        if (failure) {
            // 如果有数据,我们该
            failure(error);
        }
    };
    
#warning 此处可以用来判断用户当前的网络状态,之后在发送网络请求...
    
    [self request:type URLString:URLString parameters:parameters progress:nil success:orginalSuccess failure:orginalFailure];

}


#pragma mark - 第三次封装 - 创建一个类方法 方便使用和后期扩展
+(void)request:(HSHTTPClientType)type URLString:(NSString *)URLString parameters:(id)parameters  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    //BaseURL 可以用来拼接穿过来的URL
    
    [[HSHTTPClient shareInstance] request:type URLString:URLString parameters:parameters success:success failure:failure];
}

#pragma mark - 监听网络状态
// 监听网络状态
- (void)useAFNReachabilityCheckNetworkState {
    
    // 1.创建网络监听管理者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    self.manager = manager;
    // 2.监听网络状态的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkState) name:AFNetworkingReachabilityDidChangeNotification object:nil];
    // 3.开始监听
    [manager startMonitoring];
}

- (void)checkNetworkState {
    /*
     AFNetworkReachabilityStatusUnknown          = -1,  未识别
     AFNetworkReachabilityStatusNotReachable     = 0,   未连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
     AFNetworkReachabilityStatusReachableViaWiFi = 2,  wifi
     */
    [self.manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [MBProgressHUD showError:@"当前是未知的网络状态"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [MBProgressHUD showError:@"世界上最遥远的距离就是没网"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [MBProgressHUD showSuccess:@"当前连接连接的是蜂窝移动网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [MBProgressHUD showSuccess:@"当前连接的是WIFI"];
                break;
            default:
                break;
        }
    }];
}

@end
