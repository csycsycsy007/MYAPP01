//
//  XFthirdCell.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/16.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFthirdCell.h"
#import "UIImageView+WebCache.h"

@interface XFthirdCell ()
@property (nonatomic, strong) NSOperationQueue *queue;


@end

@implementation XFthirdCell

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


-(void)setCirModel:(XFcercleCellModel *)cirModel {
    
    _cirModel = cirModel;
    
    [self settingData];
    
    
}
/*
 @property(nonatomic,copy) NSString *cirle_id;
 @property(nonatomic,copy) NSString *cirle_title;
 @property(nonatomic,copy) NSString *user_images;
 @property(nonatomic,copy) NSString *user_name;
 @property(nonatomic,copy) NSString *user_time;
 @property(nonatomic,copy) NSString *cirle_look;
 @property(nonatomic,copy) NSString *cirle_commentNb;
 @property(nonatomic,copy) NSString *cirle_tag;
 */

- (void)settingData {
    
    
    
    self.cirle_title.text = self.cirModel.cirle_title;
    self.user_name.text = self.cirModel.user_name;
    self.cirle_time.text = self.cirModel.user_time;
    self.cirle_look.titleLabel.text = self.cirModel.cirle_look;
    self.cirle_tag.titleLabel.text = self.cirModel.cirle_tag;
    self.cirle_commentNb.titleLabel.text = self.cirModel.cirle_commentNb;
    
    self.cirle_look.userInteractionEnabled = NO;
    self.cirle_tag.userInteractionEnabled = NO;
    self.cirle_commentNb.userInteractionEnabled = NO;
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 下载图片 : 耗时操作
        NSURL *url = [NSURL URLWithString:self.cirModel.user_images];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        
        
        // 图片下载完后曾只有,需要刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 赋值
            self.user_images.image = image;
        }];
    }];
    
    // 把下载操作添加到队列
    [self.queue addOperation:op];

    
}

+(instancetype)cellWithTableview:(UITableView *)table {
    
    static NSString *reuseIdentifier = @"thirdCell";
    
    XFthirdCell *cell = [table dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFthirdCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}



-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}




@end
