//
//  XFfourBtnLines.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/19.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFfourBtnLines.h"

@implementation XFfourBtnLines


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    CGContextRef cxtRef = UIGraphicsGetCurrentContext();
    
    // 2.创建路径
    float a = [UIScreen mainScreen].bounds.size.width;
    float b = [UIScreen mainScreen].bounds.size.height;
    
    
    self.clipsToBounds = false;
    
    //
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    
    if (a <= 375) {
        
        [path moveToPoint:CGPointMake(0 , 0)];
        
        //260
        [path addLineToPoint:CGPointMake(a, 0)];  //49 默认 tabbar 高度
        
        [path moveToPoint:CGPointMake(0, 60)];
        
        // 2.3画线
        [path addLineToPoint:CGPointMake(a, 60)];
        
        [path moveToPoint:CGPointMake(0, 120)];
        
        // 2.3画线
        [path addLineToPoint:CGPointMake(a, 120)];
        
        [path moveToPoint:CGPointMake(a/2, 0)];
        
        // 2.3画线
        [path addLineToPoint:CGPointMake(a/2, 120)];


        
        
    } else {
        [path moveToPoint:CGPointMake(a/2 - 40, 0)];
        
        
        [path addLineToPoint:CGPointMake(a/2 - 40, b - 480 - 49)];  //49 默认 tabbar 高度
        
        [path moveToPoint:CGPointMake(a/2 - 40, (b - 480 - 49) / 2)];
        
        // 2.3画线
        [path addLineToPoint:CGPointMake(a, (b - 480 - 49) / 2)];
        
        
    }
    
    
    // 3.将路径添加到图形上下文中
    CGContextAddPath(cxtRef, path.CGPath);
    
    // 4.渲染
    CGContextDrawPath(cxtRef, kCGPathStroke);

    
}

-(void)layoutSubviews{
    
    float a = [UIScreen mainScreen].bounds.size.width;
//    float b = [UIScreen mainScreen].bounds.size.height;

    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, a/2, 60)];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(a/2, 0, a/2, 60)];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 60, a/2, 60)];
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(a/2, 60, a/2, 60)];
    
    [self btnFactoryWith:btn1 imageWithName:nil titleWith:@"我的帖子"];
    [self btnFactoryWith:btn2 imageWithName:nil titleWith:@"我的顾问"];
    [self btnFactoryWith:btn3 imageWithName:nil titleWith:@"管理日记"];
    [self btnFactoryWith:btn4 imageWithName:nil titleWith:@"我的圈子"];
    
    

}

-(void)btnFactoryWith:(UIButton *)btn imageWithName:(NSString *)imgName titleWith:(NSString *)titleName
{
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setTitle:titleName forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:btn];
}


@end
