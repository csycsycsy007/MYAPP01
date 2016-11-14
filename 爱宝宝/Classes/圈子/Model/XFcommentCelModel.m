//
//  XFcommentCelModel.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/27.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFcommentCelModel.h"

@implementation XFcommentCelModel


+ (instancetype)commentWithDict:(NSDictionary *)dict
{
    XFcommentCelModel *model = [[XFcommentCelModel alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

// 重写这个方法的目的 : 防止模型的属性少于字典的key造成率崩溃问题
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"有不匹配的键值对");
}


@end
