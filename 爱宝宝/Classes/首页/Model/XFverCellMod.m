//
//  XFverCellMod.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/7.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFverCellMod.h"

@implementation XFverCellMod

+(instancetype)initVerWithDict:(NSDictionary *)dic{
    
    XFverCellMod *banne = [[XFverCellMod alloc]init];
    
    
    [banne setValuesForKeysWithDictionary:dic];
    
    return banne;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end
