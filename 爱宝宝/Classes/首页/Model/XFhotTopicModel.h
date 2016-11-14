//
//  XFhotTopicModel.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/24.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFhotTopicModel : NSObject

@property(nonatomic,copy) NSString *forum_id;

@property(nonatomic,copy) NSString *forum_title;

+(instancetype)inithotTopWithDict:(NSDictionary *)dic;

@end
