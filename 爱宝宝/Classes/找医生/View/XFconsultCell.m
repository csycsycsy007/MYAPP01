//
//  XFconsultCell.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/4.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFconsultCell.h"

@implementation XFconsultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableview:(UITableView *)table {
    
    static NSString *reuseIdentifier = @"consultCell";
    
    XFconsultCell *cell = [table dequeueReusableCellWithIdentifier:reuseIdentifier];
    

    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFconsultCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}
@end
