//
//  XFbannerImage.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/22.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFbannerImage.h"

@implementation XFbannerImage

+(instancetype)initBannerWithDict:(NSDictionary *)dic{
    
    XFbannerImage *banne = [[XFbannerImage alloc]init];
    
    
    [banne setValuesForKeysWithDictionary:dic];
    
    return banne;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
