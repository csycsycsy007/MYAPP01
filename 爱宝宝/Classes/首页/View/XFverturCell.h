//
//  XFverturCell.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/7.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFverCellMod.h"

@interface XFverturCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *verView;

@property (weak, nonatomic) IBOutlet UILabel *article_time;
@property (weak, nonatomic) IBOutlet UIButton *article_love;
@property (weak, nonatomic) IBOutlet UIButton *article_look;
@property (weak, nonatomic) IBOutlet UILabel *article_title;
@property (weak, nonatomic) IBOutlet UIImageView *article_image;


@property(nonatomic,strong) XFverCellMod *verMod;

+(instancetype)cellWithTableview:(UITableView *)table;
@end
