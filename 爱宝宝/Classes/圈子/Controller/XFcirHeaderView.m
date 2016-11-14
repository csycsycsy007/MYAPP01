//
//  XFcirHeaderView.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/26.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFcirHeaderView.h"

@implementation XFcirHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)allocHeaderView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"XFcirHeaderView" owner:nil options:nil] lastObject];
}


@end
