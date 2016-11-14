//
//  XFbannerImage.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/22.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFbannerImage : NSObject

@property(nonatomic,copy) NSString *cirlr_url ;

@property(nonatomic,copy) NSString *banner ;


+(instancetype)initBannerWithDict:(NSDictionary *)dic;
@end
