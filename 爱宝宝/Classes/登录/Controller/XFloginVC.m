//
//  XFloginVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/19.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFloginVC.h"
#import "XFregistVC.h"
#import "XFbtnsView.h"
#import "XFRootVC.h"

@interface XFloginVC ()<XFbtnViewDelegate>
@property(nonatomic,weak) UIButton * loginBtn;
@property(nonatomic,weak) UIButton * regisBtn;
@property(nonatomic,weak) UITextView * phoneText;
@property(nonatomic,weak) UITextView * checkText;
//@property(nonatomic,weak) <#type#> * <#name#>;
//@property(nonatomic,weak) <#type#> * <#name#>;

@end

@implementation XFloginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self createLoinBtn];
    [self setUpViewsOfloginAndregister];

}

-(void)loginBtnClick:(XFbtnsView *)appView {
    

    
    
    XFRootVC *vc = [[XFRootVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createLoinBtn {
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(100, 320, 200, 60)];
//    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 420, 200, 60)];
//    btn1.titleLabel.text = @"登录";
//    btn2.titleLabel.text = @"注册";
//    [btn1 setTitle:@"登录" forState: UIControlStateNormal];
//    [btn2 setTitle:@"注册" forState: UIControlStateNormal];
//    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//    [self.view addSubview:btn1];
//    [self.view addSubview:btn2];
    
//    [btn1 addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [btn2 addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建 text
//    UITextView *phoneNum = [[UITextView alloc]init];
//    phoneNum.
}



-(void)registerBtnClick
{
    XFregistVC *vc = [[XFregistVC alloc]init];
//    [self presentViewController:vc animated:NO completion:^{
//        NSLog(@"去注册页面");
//    }];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}




-(void)setUpViewsOfloginAndregister
{
    XFbtnsView *vie = [XFbtnsView initWithnnnib];
    vie.frame = CGRectMake(0, 400, [UIScreen mainScreen].bounds.size.width, 156);
    [self.view addSubview:vie];
    vie.delegate = self;
//    vie.
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
}

@end
