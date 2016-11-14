//
//  XFconsulterVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/8.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "XFconsulterVC.h"
#import "Masonry.h"


@interface XFconsulterVC ()

@end

@implementation XFconsulterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    


}

#pragma mark ---------- 创建布局
- (void)setUpLayout {
    
    //1.大图头像
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.image = [UIImage imageNamed:@"lbt2"];
    
    //2.名字标签
    UILabel *nameLab = [[UILabel alloc]init];
    [nameLab setText:@"王菲菲-试管婴儿顾问"];
    nameLab.textAlignment = NSTextAlignmentCenter;
    //3.职业年龄
    UILabel *ageLab = [[UILabel alloc]init];
    NSString *str1 = [NSString stringWithFormat:@"职业年龄: %zd年",5];
    [ageLab setText:str1];
    //4.服务等级
    UILabel *starLab = [[UILabel alloc]init];
    [starLab setText:@"服务等级:"];
    //5.评价标签
    UILabel *commentLab = [[UILabel alloc]init];
    NSString *str2 = [NSString stringWithFormat:@"评价标签:%@",@"一二三"];
    [commentLab setText:@"评价标签:"];
    //6.留言咨询
    UIButton *replyBtn = [[UIButton alloc]init];
    [replyBtn setTitle:@"留言咨询" forState: UIControlStateNormal];
    [replyBtn setImage:[UIImage imageNamed:@"pl"] forState:UIControlStateNormal];
    [replyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //7.电话咨询
    UIButton *phoneBtn = [[UIButton alloc]init];
    [phoneBtn setTitle:@"电话咨询" forState: UIControlStateNormal];
    [phoneBtn setImage:[UIImage imageNamed:@"pl"] forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //8.分割线
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    //1
    [imgV makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(8);
        make.left.equalTo(self.view).offset(8);
        make.right.equalTo(self.view).offset(-8);
        make.height.equalTo(@180);
    }];
    //2
    [nameLab makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.bounds.size.width);
        make.top.equalTo(imgV).offset(20);
    }];
    //3
    [ageLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.width.equalTo(@180);
        make.top.equalTo(nameLab).offset(45);
    }];
    //4
    [starLab makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
//        make.width.equalTo(@180);
        make.top.equalTo(ageLab).offset(20);
    }];
    //5
    [commentLab makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(12);
        make.width.equalTo(self.view.bounds.size.width);
        make.top.equalTo(starLab).offset(20);
        make.height.equalTo(@42);
    }];
    
    //6
    


}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
