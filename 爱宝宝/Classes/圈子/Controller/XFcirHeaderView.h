//
//  XFcirHeaderView.h
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/26.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFcirHeaderView : UIView
@property (weak, nonatomic) IBOutlet UILabel *head_titlelab;
@property (weak, nonatomic) IBOutlet UIButton *looktimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *userIdlab;

@property (weak, nonatomic) IBOutlet UILabel *userTimeLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIButton *labBtn;

@property (weak, nonatomic) IBOutlet UIView *line;


+ (instancetype)allocHeaderView;



@end
