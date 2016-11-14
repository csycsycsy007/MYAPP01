//
//  XFselectedBtnAndTitle.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/5.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFselectedBtnAndTitle.h"

@implementation XFselectedBtnAndTitle

/*  这部分失败.
+(instancetype)initWithBtnImage:(NSString *)iconName withTitleName:(NSString *)titleName {
    XFselectedBtnAndTitle *x = [[XFselectedBtnAndTitle alloc]init];
    
    [x.titleLabel setText:titleName];
    [x.selectBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    
    
    return x;
}
*/

-(void)layoutSubviews{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
    [btn setBackgroundColor:[UIColor blueColor]];
    
    self.selectBtn = btn;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, 100, 20)];
//    lab.text = @"ssf";
//    [lab setText:@"ssf"];
//    lab.textAlignment = UITextAlignmentCenter;
//    [lab setTextAlignment:UITextAlignmentCenter];
    [lab setTextAlignment:NSTextAlignmentCenter];
    self.titleLabel = lab;
    
    [self addSubview:self.selectBtn];
    [self addSubview:self.titleLabel];
}
@end
