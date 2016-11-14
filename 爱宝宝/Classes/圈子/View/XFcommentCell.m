//
//  XFcommentCell.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/27.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFcommentCell.h"

@interface XFcommentCell ()
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation XFcommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

-(void)setCellModel:(XFcommentCelModel *)cellModel {
    
    _cellModel = cellModel;
    [self settingData];
    
}

-(void)settingData {

    

//    NSLog(@"%@",self.contentLab.text);

    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 下载图片 : 耗时操作
        NSURL *url = [NSURL URLWithString:self.cellModel.cirle_images];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
//        NSLog(@"%@",self.cellModel.cirle_images);
        
        // 图片下载完后曾只有,需要刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 赋值

            [self.imgIconBtn setImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

        }];
    }];
    
//     把下载操作添加到队列
    [self.queue addOperation:op];

    
}
+(instancetype)cellWithTableview:(UITableView *)table {
    
    static NSString *reuseIdentifier = @"commentcell";
    
    XFcommentCell *cell = [table dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XFcommentCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
