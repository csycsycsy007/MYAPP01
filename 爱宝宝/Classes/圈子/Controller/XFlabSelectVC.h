//
//  XFlabSelectVC.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/14.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tempBlock)(NSString * text);

@interface XFlabSelectVC : UIViewController


@property(nonatomic,copy)tempBlock finish1Block;
@property(nonatomic,copy)tempBlock finish2Block;
@property(nonatomic,copy)tempBlock finish3Block;
@end
