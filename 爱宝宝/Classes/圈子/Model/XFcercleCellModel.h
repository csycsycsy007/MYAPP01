//
//  XFcercleCellModel.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/17.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFcercleCellModel : NSObject
/*
 "cirle_id": "1",
 "user_images": "http://ma.beidaivf04.com/images/user/default.jpg",/
 "user_name": "17744255486",
 "user_time": "4天前",
 "cirle_title": "5年了，终于有自己的孩子了！！",/
 "cirle_tag": "孩子,婚姻,试管",
 "cirle_look": "34",
 "cirle_commentNb": "28"

 */

@property(nonatomic,copy) NSString *cirle_id;
@property(nonatomic,copy) NSString *cirle_title;
@property(nonatomic,copy) NSString *user_images;
@property(nonatomic,copy) NSString *user_name;
@property(nonatomic,copy) NSString *user_time;
@property(nonatomic,copy) NSString *cirle_look;
@property(nonatomic,copy) NSString *cirle_commentNb;
@property(nonatomic,copy) NSString *cirle_tag;
//@property(nonatomic,copy) NSString *cirle_content;
//@property(nonatomic,copy) NSString *cirle_share;

+ (void)loadDataWithURLString:(NSString *)URLString successBlock:(void(^)(NSMutableArray *circleModels))successBlock failedBlock:(void(^)(NSError *error))failedBlock;


@end
