//
//  HSHTTPClient.h
//  podTest
//
//  Created by Song Hua on 16/9/23.
//  Copyright © 2016年 Song Hua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
typedef enum {
    /** GET请求 */
    GET = 0,
    /** POST请求 */
    POST = 1,
    
}HSHTTPClientType;

@interface HSHTTPClient : AFHTTPSessionManager
+(void)request:(HSHTTPClientType)type URLString:(NSString *)URLString parameters:(id)parameters  success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
