//
//  XFartCommentMod.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/1.
//  Copyright © 2016年 PUHIM. All rights reserved.
/*
 comment_id=标题 comment_name=评论用户 comment_images=用户头像 comment_content=评论内容 comment_love=点赞人数 comment_time=评论时间 comment_floor=楼层
 */

#import <Foundation/Foundation.h>

@interface XFartCommentMod : NSObject

@property(nonatomic,copy) NSString *comment_id;
@property(nonatomic,copy) NSString *comment_name;
@property(nonatomic,copy) NSString *comment_images;
@property(nonatomic,copy) NSString *comment_content;
@property(nonatomic,copy) NSString *comment_love;
@property(nonatomic,copy) NSString *comment_time;
@property(nonatomic,assign) NSInteger comment_floor;

+(instancetype)initCommentModWith:(NSDictionary *)dic;
@end
