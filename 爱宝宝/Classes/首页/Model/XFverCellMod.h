//
//  XFverCellMod.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/7.
//  Copyright © 2016年 PUHIM. All rights reserved.
/*
 "article_images": "http://ma.beidaivf04.com/article/jrtt/images/1477114274.jpg",
 "article_title": "月经提前怎么回事？月经提前的食疗方法",
 "article_time": "2016-10-22 13:31:14",
 "article_love": "100",
 "article_look": "483",
 "article_id": "13"

 */

#import <Foundation/Foundation.h>

@interface XFverCellMod : NSObject

@property (nonatomic, copy) NSString *article_images;
@property (nonatomic, copy) NSString *article_title;
@property (nonatomic, copy) NSString *article_time;
@property (nonatomic, copy) NSString *article_love;
@property (nonatomic, copy) NSString *article_look;
@property (nonatomic, copy) NSString *article_id;

+(instancetype)initVerWithDict:(NSDictionary *)dic;

@end
