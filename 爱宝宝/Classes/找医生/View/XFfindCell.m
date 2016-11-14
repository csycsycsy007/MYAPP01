//
//  XFfindCell.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/12.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFfindCell.h"

@implementation XFfindCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTableview:(UITableView *)table {
    
    static NSString *reuseIdentifier = @"findDoc";
    
    XFfindCell *cell = [table dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFfindCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
