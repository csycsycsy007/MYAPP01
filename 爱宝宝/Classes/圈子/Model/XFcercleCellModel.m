//
//  XFcercleCellModel.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/17.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFcercleCellModel.h"

@implementation XFcercleCellModel

+ (void)loadDataWithURLString:(NSString *)URLString successBlock:(void (^)(NSMutableArray *))successBlock failedBlock:(void (^)(NSError *))failedBlock
{
    // URL
    NSURL *URL= [NSURL URLWithString:URLString];
    
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 处理响应
        if (connectionError == nil && data != nil) {
            // 反序列化
            // data : 保存的是JSON对象数组的二进制数据
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
//            NSLog(@"--------model 中%@---------",result);
            // 定义一个可变数组
            NSMutableArray *tmpM =[NSMutableArray arrayWithCapacity:result.count];
            
            // 遍历字典数组,取出字典,实现字典转模型
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XFcercleCellModel *model = [XFcercleCellModel circleWithDict:obj];
                [tmpM addObject:model];
                
            }];
            
            // 获取到模型数组,需要把模型数组回调控制器
            if (successBlock) {
                // 回调VC传入的刷新UI的代码块,把模型数组传递到VC的代码块
                successBlock(tmpM.copy);
            }
            
        } else {
            if (failedBlock) {
                failedBlock(connectionError);
            }
        }
    }];
}

+ (instancetype)circleWithDict:(NSDictionary *)dict
{
    XFcercleCellModel *model = [[XFcercleCellModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

// 重写这个方法的目的 : 防止模型的属性少于字典的key造成率崩溃问题
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"有不匹配的键值对");
}


@end
