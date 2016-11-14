//
//  XFcommentCell.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/27.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFcommentCelModel.h"


@interface XFcommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *imgIconBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *floorLab;

@property(nonatomic,strong) XFcommentCelModel * cellModel;
// 创建cell
+(instancetype)cellWithTableview:(UITableView *)table;


@end
