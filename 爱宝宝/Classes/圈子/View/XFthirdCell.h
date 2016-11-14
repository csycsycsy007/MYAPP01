//
//  XFthirdCell.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/16.
//  Copyright © 2016年 PUHIM. All rights reserved.
/*
 "cirle_title": "宝宝出生了",
 "user_images": "http://ma.beidaivf04.com//images/user/default.jpg",
 "user_name": "爱宝宝",
 "cirle_time": "144小时前",
 "cirle_look": "24",
 "cirle_commentNb": "5",
 "cirle_tag": "试管",
 "cirle_content":
 */

#import <UIKit/UIKit.h>
#import "XFcercleCellModel.h"

@interface XFthirdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *user_images;
@property (weak, nonatomic) IBOutlet UILabel *cirle_title;

@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *cirle_time;
@property (weak, nonatomic) IBOutlet UIButton *cirle_look;

@property (weak, nonatomic) IBOutlet UIButton *cirle_tag;

@property (weak, nonatomic) IBOutlet UIButton *cirle_commentNb;



@property(nonatomic,strong) XFcercleCellModel * cirModel;

// +(instancetype)xibTableViewCell;
+(instancetype)cellWithTableview:(UITableView *)table;

@end
