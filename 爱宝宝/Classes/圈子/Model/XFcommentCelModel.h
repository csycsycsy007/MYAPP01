//
//  XFcommentCelModel.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/27.
//  Copyright © 2016年 PUHIM. All rights reserved.
/*
 "cirle_images": "http://ma.beidaivf04.com/images/user/default.jpg",
 "cirle_name": "17744255486",
 "cirle_content": "\r\n恭喜姐妹，想请教一下姐妹内膜薄怎样调理，因为我内膜也薄\r\n",
 "cirle_time": "2016-10-21 16:17:01",
 "cirle_floor": 1

 
 */

#import <Foundation/Foundation.h>

@interface XFcommentCelModel : NSObject

@property(nonatomic,copy) NSString * cirle_images;
@property(nonatomic,copy) NSString * cirle_name;
@property(nonatomic,copy) NSString * cirle_content;
@property(nonatomic,copy) NSString * cirle_time;
@property(nonatomic,assign) NSInteger  cirle_floor;


+ (instancetype)commentWithDict:(NSDictionary *)dict;
@end
