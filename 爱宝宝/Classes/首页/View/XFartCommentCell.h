//
//  XFartCommentCell.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/1.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFartCommentMod.h"

@interface XFartCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *floorLab;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UILabel *commentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;



@property(nonatomic,strong) XFartCommentMod * cellModel;

+(instancetype)cellWithTableview:(UITableView *)table;
@end
