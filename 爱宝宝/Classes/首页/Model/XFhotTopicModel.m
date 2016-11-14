//
//  XFhotTopicModel.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/24.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFhotTopicModel.h"

@implementation XFhotTopicModel


+(instancetype)inithotTopWithDict:(NSDictionary *)dic{
    
    XFhotTopicModel *banne = [[XFhotTopicModel alloc]init];
    
    //    NSLog(@"%@",dic);
    
    [banne setValuesForKeysWithDictionary:dic];
    
    return banne;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
