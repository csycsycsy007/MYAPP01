////
////  XFtableOne.m
////  爱宝宝
////
////  Created by 小凡 席 on 16/9/13.
////  Copyright © 2016年 PUHIM. All rights reserved.
////
//
//#import "XFtableOne.h"
//
//
//@interface XFtableOne ()
//@property (nonatomic, strong) NSOperationQueue *queue;
////@property(nonatomic,weak) UILabel * titleLabel;
////@property(nonatomic,weak) UILabel * detailsLabel;
////@property(nonatomic,weak) UIImageView * img;
//////模型
////@property(nonatomic,strong) XFcellModel1 *mod;
//@end
//
//@implementation XFtableOne
//
//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//+ (instancetype)cellWithTableview:(UITableView *)table {
//    //设置 id
//    static NSString *ID = @"tableOn";
//    
//    XFtableOne *cell = [table dequeueReusableCellWithIdentifier:ID];
//    
//    if (cell == nil) {
//        //创建 cell
//        cell = [[XFtableOne alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        
//        //给 cell 加个背景色
//        cell.backgroundColor = [UIColor colorWithRed:209/255.0 green:250/255.0 blue:1.0 alpha:1.0];
//    }
//    return cell;
//    
//}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
////    float a = [UIScreen mainScreen].bounds.size.width;
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    
//    if(self){
//        //1.标题
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, 200, 30)];
//        self.titleLabel = label;
////        self.titleLabel.text = @"孕妇小知识的普及";
//        //2.详细内容
//        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(140, 50, 200, 21)];
//        label2.font = [UIFont systemFontOfSize:14];
//        self.detailsLabel = label2;
////        self.detailsLabel.text = @"详细信息详细信息";
//        //3.图片
//        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 120, 84)];
//        self.img = img;
////        self.img.image = [UIImage imageNamed:@"lbt1"];
//        
//        [self.contentView addSubview:self.titleLabel];
//        [self.contentView addSubview:self.detailsLabel];
//        [self.contentView addSubview:img];
//    }
//    
//    return  self;
//    
//}
///*
// @property (nonatomic, copy) NSString *img;
// @property (nonatomic, copy) NSString *content;
// @property (nonatomic, copy) NSString *con;
// @property (nonatomic, copy) NSString *title;
// */
//-(void)setMod:(XFcellModel1 *)mod{
//    _mod = mod;
//    [self settingData];
//
//}
//
//- (NSOperationQueue *)queue
//{
//    if (_queue == nil) {
//        _queue = [[NSOperationQueue alloc] init];
//    }
//    return _queue;
//}
//
//
//-(void)settingData {
//    //cell 的图
//
//
//    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
//        // 下载图片 : 耗时操作
//////        NSURL *url = [NSURL URLWithString:self.mod.img];
////        NSData *data = [NSData dataWithContentsOfURL:url];
////        UIImage *image = [UIImage imageWithData:data];
//        
//        // 图片下载完后曾只有,需要刷新UI
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            // 给cell的imageView赋值
//            self.img.image = image;
//        }];
//    }];
//    
//    // 把下载操作添加到队列
//    [self.queue addOperation:op];
//    
////    [self.img sd_setImageWithURL:url];
//    //cell 的标题
////    self.titleLabel.text = self.mod.title;
////    self.detailsLabel.text = self.mod.cont;
//    
//    
//}
//
//
//@end
