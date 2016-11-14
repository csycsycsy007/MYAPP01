//
//  XFverturCell.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/7.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFverturCell.h"
#import "UIImageView+WebCache.h"

@interface XFverturCell ()
@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation XFverturCell


- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}



- (void)awakeFromNib {
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



-(void)setVerMod:(XFverCellMod *)verMod {
    _verMod = verMod;
    [self settingData];
}

- (void)settingData {
    
    [self.verView bringSubviewToFront:self.article_title];
    
    self.article_look.titleLabel.text = self.verMod.article_look;
    self.article_love.titleLabel.text = self.verMod.article_love;
    self.article_title.text = self.verMod.article_title;
    self.article_time.text = self.verMod.article_time;
    
    self.article_title.preferredMaxLayoutWidth = 260;
    self.article_title.numberOfLines = 0;
    
    

    
    
    
}

+(instancetype)cellWithTableview:(UITableView *)table {
    
    static NSString *reuseIdentifier = @"verCell";
    
    XFverturCell *cell = [table dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFverturCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


@end
