//
//  XFpicAndLab.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/16.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFpicAndLab.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface XFpicAndLab ()
@property(nonatomic,weak) UIImageView *picView;
@property(nonatomic,weak) UILabel *labLable;
@end
@implementation XFpicAndLab


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    // 1.获取图形上下文
    CGContextRef cxtRef = UIGraphicsGetCurrentContext();
    
    // 2.创建路径
    float a = [UIScreen mainScreen].bounds.size.width;
    
//    if(a == 320) {
    
    self.clipsToBounds = false;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, a, 80) cornerRadius:10];
//        
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
//    } else if (a == 375) {
//        
//    } else if (a == 414) {
//        
//    }
    
    [path moveToPoint:CGPointMake(0, 0)];
    
    // 2.3画线
    [path addLineToPoint:CGPointMake(a, 0)];
    
    [path moveToPoint:CGPointMake(0, 80)];
    
    // 2.3画线
    [path addLineToPoint:CGPointMake(a, 80)];
    
    
    [path moveToPoint:CGPointMake(0, 40)];
    
    // 2.3画线
    [path addLineToPoint:CGPointMake(a, 40)];
    
    [path moveToPoint:CGPointMake(a/2, 0)];
    
    // 2.3画线
    [path addLineToPoint:CGPointMake(a/2, 80)];
    
    
    // 3.将路径添加到图形上下文中
    CGContextAddPath(cxtRef, path.CGPath);
    
    // 4.渲染
    CGContextDrawPath(cxtRef, kCGPathStroke);
}

-(void)layoutSubviews {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10  , 10, 23, 23)];

    imgView1.image = [UIImage imageNamed:@"头像"];
    [self addSubview:imgView1];
    
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width /2 +10  , 10, 23, 23)];
    
    imgView2.image = [UIImage imageNamed:@"头像"];
    [self addSubview:imgView2];
    
    UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(10  , 40 + 10, 23, 23)];
    
    imgView3.image = [UIImage imageNamed:@"头像"];
    [self addSubview:imgView3];
    
    UIImageView *imgView4 = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width /2 +10  , 50, 23, 23)];
    
    imgView4.image = [UIImage imageNamed:@"头像"];
    [self addSubview:imgView4];

    //设置标签
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(43, 10, 120, 20)];
    lab1.text = @"生男生女秘籍";
    [self addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width /2 +43, 10, 120, 20)];
    lab2.text = @"备孕却怀不上";
    [self addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(43, 50, 120, 20)];
    lab3.text = @"自己在家养精";
    [self addSubview:lab3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 +43, 50, 120, 20)];
    lab4.text = @"热门超级话题";
    [self addSubview:lab4];
    
}




@end
