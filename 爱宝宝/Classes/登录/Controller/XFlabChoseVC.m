//
//  XFlabChoseVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/30.
//  Copyright © 2016年 PUHIM. All rights reserved.
//
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "XFlabChoseVC.h"
#import "Masonry.h"
#import "WXPLoginVC.h"
#import "WXPRegisterVC.h"


//测试用
#import "XFRootVC.h"
#import "AppDelegate.h"

@interface XFlabChoseVC ()

@end

@implementation XFlabChoseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:90 green:80 blue:80 alpha:1.0];
    [self setUplab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUplab {
    
    UILabel *pLabel = [[UILabel alloc]init];
    
    pLabel.text = @"请选择状态标签";
    //设置字体和大小
//    pLabel.font = [UIFont fontWithName:@"Verdana" size:18];
    pLabel.font = [UIFont systemFontOfSize:22];
    //字体对齐方式
    pLabel.textAlignment = NSTextAlignmentCenter;
    //字体颜色
    pLabel.textColor = [UIColor blackColor];
    //显示行数
    pLabel.numberOfLines = 1;
    //阴影颜色
//    pLabel.shadowColor = [UIColor blackColor];
    //阴影尺寸
//    pLabel.shadowOffset = CGSizeMake(2.0,1.0);
    //设置label的背景色为透明色
    pLabel.backgroundColor = [UIColor lightGrayColor];
    //把标签添加到当前视图
    [self.view addSubview:pLabel];
    
    [pLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        
    }];
    
    UILabel *contentLab = [[UILabel alloc]init];
    contentLab.textAlignment = NSTextAlignmentCenter;
    contentLab.text = @"第一时间了解你最关注的";
    contentLab.backgroundColor = [UIColor clearColor];
    contentLab.textColor = [UIColor blackColor];
    [self.view addSubview:contentLab];
    
    
    [contentLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pLabel).offset(35);
        make.left.equalTo(self.view).offset(80);
        make.right.equalTo(self.view).offset(-80);
    }];
    //1
    UIButton *btn1 = [[UIButton alloc]init];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn1 setTitle:@"备孕" forState:UIControlStateNormal];
    [self.view addSubview:btn1];
    //2
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [btn2 setTitle:@"难孕" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    //3
    UIButton *btn3 = [[UIButton alloc]init];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [btn3 setTitle:@"怀孕中" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    //4
    UIButton *btn4 = [[UIButton alloc]init];
    [btn4 setBackgroundImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    [btn4 setTitle:@"宝妈" forState:UIControlStateNormal];
    [self.view addSubview:btn4];
    
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-([UIScreen mainScreen].bounds.size.width)*0.5-5);
        make.top.equalTo(self.view).offset(200);
        make.width.equalTo(118);
        make.height.equalTo(118);
    }];
    [btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(([UIScreen mainScreen].bounds.size.width)*0.5+5);
        make.top.equalTo(self.view).offset(200);
        make.width.equalTo(118);
        make.height.equalTo(118);
    }];
    [btn3 makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-([UIScreen mainScreen].bounds.size.width)*0.5-5);
        make.top.equalTo(self.view).offset(328);
        make.width.equalTo(118);
        make.height.equalTo(118);
    }];
    [btn4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(([UIScreen mainScreen].bounds.size.width)*0.5+5);
        make.top.equalTo(self.view).offset(328);
        make.width.equalTo(118);
        make.height.equalTo(118);
    }];
    
    btn1.tag = 100;
    btn2.tag = 101;
    btn3.tag = 102;
    btn4.tag = 103;

    //添加监听
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

}


-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}



-(void)btnClick:(UIButton *)btn {
    NSLog(@"------%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"loginBtnClick"]);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loginBtnClick"]) {
        XFRootVC *vc1 = [[XFRootVC alloc]init];
        vc1.userType = btn.titleLabel.text;
        [self.navigationController pushViewController:vc1 animated:YES];

    }else{
        WXPLoginVC *vc = [[WXPLoginVC alloc]init];
        vc.userType = btn.titleLabel.text;
        
        [self.navigationController pushViewController:vc animated:YES];
 
    }
    
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
