//
//  XFartCommentCell.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/1.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFartCommentCell.h"

@interface XFartCommentCell ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation XFartCommentCell

- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(void)setCellModel:(XFartCommentMod *)cellModel {
    
    _cellModel = cellModel;
    [self settingData];
    
}

-(void)settingData {
    
    
    
    //    NSLog(@"%@",self.contentLab.text);
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 下载图片 : 耗时操作
        NSURL *url = [NSURL URLWithString:self.cellModel.comment_images];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        //        NSLog(@"%@",self.cellModel.cirle_images);
        
        // 图片下载完后曾只有,需要刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 赋值
            
            [self.iconBtn setImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            
        }];
    }];
    
    //     把下载操作添加到队列
    [self.queue addOperation:op];
    
    
}
+(instancetype)cellWithTableview:(UITableView *)table {
    
    static NSString *reuseIdentifier = @"ommentcell";
    
    XFartCommentCell *cell = [table dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFartCommentCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

@end
