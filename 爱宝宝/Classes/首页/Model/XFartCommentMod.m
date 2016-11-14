//
//  XFartCommentMod.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/1.
//  Copyright © 2016年 PUHIM. All rights reserved.
/*

 文章评论数据接口
 接口路径：http://ma.beidaivf04.com/admin.php/Index/article_comment
 传值方式：GET 参数 page=分页 id=文章编号
 返回值：comment_id=标题 comment_name=评论用户 comment_images=用户头像 comment_content=评论内容 comment_love=点赞人数 comment_time=评论时间 comment_floor=楼层
*/

#import "XFartCommentMod.h"

@implementation XFartCommentMod

+(instancetype)initCommentModWith:(NSDictionary *)dic{
    
    XFartCommentMod *mod = [[XFartCommentMod alloc]init];
    
    [mod setValuesForKeysWithDictionary:dic];
    
    return mod;

}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end
