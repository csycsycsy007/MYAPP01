//
//  XFdocLiveCell.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/3.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFdocLiveCell.h"

@implementation XFdocLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)cellWithTableview:(UITableView *)table {
    
    static NSString *reuseIdentifier = @"docLive";
    
    XFdocLiveCell *cell = [table dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFdocLiveCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
