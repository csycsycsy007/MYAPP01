//
//  XFhotBtnMod.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/31.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFhotBtnMod : NSObject

@property(nonatomic,copy) NSString * hot_title;
@property(nonatomic,copy) NSString * hot_url;


+(instancetype)initHotModWith:(NSDictionary *)dic;

@end
