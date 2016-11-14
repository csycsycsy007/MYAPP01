//
//  XFdetailedMod.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/24.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFdetailedMod.h"

@interface XFdetailedMod ()

@end

@implementation XFdetailedMod

+(instancetype)initDetModWith:(NSDictionary *)dic {
    
    XFdetailedMod *mod = [[XFdetailedMod alloc]init];
    
    [mod setValuesForKeysWithDictionary:dic];
    
    return mod;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
