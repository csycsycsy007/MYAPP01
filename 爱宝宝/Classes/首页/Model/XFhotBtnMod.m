//
//  XFhotBtnMod.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/31.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFhotBtnMod.h"

@implementation XFhotBtnMod


+(instancetype)initHotModWith:(NSDictionary *)dic{
    
    XFhotBtnMod *mod = [[XFhotBtnMod alloc]init];
    
    [mod setValuesForKeysWithDictionary:dic];
    
    return mod;

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
