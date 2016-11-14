//
//  WXPLoginVC.m
//  
//
//  Created by 王小鹏 on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WXPLoginVC.h"
#import "Masonry.h"
#import "WXPRegisterVC.h"
#import "WXPfForgetPwdVC.h"
#import "WXPRegisterByMessaryVC.h"
#import "MBProgressHUD+Ex.h"
#import "XFRootVC.h"
//#import "ThirdPlatformLogin.h"
#import "AppDelegate.h"
#import "HSHTTPClient.h"



@interface WXPLoginVC ()
///账号
@property (nonatomic, weak) UITextField *accountTextField;
///密码
@property (nonatomic, weak) UITextField *passwordTextField;
@property (nonatomic, copy) NSString *pwd;

@end

@implementation WXPLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
    self.pwd = pwd;
    self.passwordTextField.text = pwd;
    //加载数据
    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated {
    self.accountTextField.text = self.pwd;
    self.navigationController.navigationBarHidden = NO;
}

///加载内容
- (void)loadData {
    //MARK: -创建控件
    //上部图片
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iocn80"]];
    [self.view addSubview:iconImageView];
    [iconImageView sizeToFit];
    
    UIImageView *iconImageViewBotton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_text_logo_nor.png"]];
    [self.view addSubview:iconImageViewBotton];
    [iconImageViewBotton sizeToFit];
    
    //账户
    UITextField *accountTextField = [[UITextField alloc] init];
    [self.view addSubview:accountTextField];
    accountTextField.borderStyle = UITextBorderStyleRoundedRect;
//    accountTextField.background = [UIImage imageNamed:@"nav"];
    accountTextField.placeholder = @"请输入手机号";
    [self setTextFieldLeftImage:accountTextField leftImage:@"手机.png"];
    accountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    
    //密码
    UITextField *passwordTextField = [[UITextField alloc] init];
    [self.view addSubview:passwordTextField];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self setTextFieldLeftImage:passwordTextField leftImage:@"锁.png"];
    passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    passwordTextField.secureTextEntry = YES;
    
    //赋值
    self.accountTextField = accountTextField;
    self.passwordTextField = passwordTextField;
    
    //通过短信
    UIButton *byTextMessageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:byTextMessageBtn];
    [byTextMessageBtn setTitle:@"通过短信验证登录" forState:UIControlStateNormal];
    
    //登录
    UIButton *loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:8/255.0 green:65/255.0 blue:130/255.0 alpha:0.8]];
    
    //注册新账号
    UIButton *registerNewBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:registerNewBtn];
    [registerNewBtn setTitle:@"注册新账号" forState:UIControlStateNormal];
    
    //忘记密码
    UIButton *forgetPwd = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:forgetPwd];
    [forgetPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    //中间分割线
    UIView *centerLine = [[UIView alloc] init];
    [self.view addSubview:centerLine];
    centerLine.backgroundColor = [UIColor blackColor];

    //第三方登录按钮
    UIButton *QQBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:QQBtn];
    [QQBtn setBackgroundImage:[UIImage imageNamed:@"图层-2.png@2x_1"] forState:UIControlStateNormal];

    UIButton *weiChatBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:weiChatBtn];
    [weiChatBtn setBackgroundImage:[UIImage imageNamed:@"weichat.png"] forState:UIControlStateNormal];
    
    UIButton *renrenBtn =[UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:renrenBtn];
    [renrenBtn setBackgroundImage:[UIImage imageNamed:@"renren.png"] forState:UIControlStateNormal];

    UIButton *weiboBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:weiboBtn];
    [weiboBtn setBackgroundImage:[UIImage imageNamed:@"微博.png@2x_7"] forState:UIControlStateNormal];

    
    //MARK: - 设置约束
    //上部图片
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(84);
//        make.width.mas_equalTo(120);
//        make.height.mas_equalTo(130);
    }];
    [iconImageViewBotton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(1);
    }];
    
    //账户
    [accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(iconImageViewBotton.mas_bottom).offset(20);
    }];
    
    //密码
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(accountTextField.mas_bottom).offset(20);
    }];
    
    //通过短信
    [byTextMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(passwordTextField.mas_bottom).offset(30);
        make.width.mas_equalTo(150);
    }];
    
    //登录
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(byTextMessageBtn.mas_bottom).offset(20);
    
    }];
    
    // //注册新账号
    [registerNewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-60);
        make.top.equalTo(loginBtn.mas_bottom).offset(40);
        make.width.mas_equalTo(80);
    }];
    
    //忘记密码
    [forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(60);
        make.top.equalTo(loginBtn.mas_bottom).offset(40);
        make.width.mas_equalTo(80);
    }];
    
    //中间分割线
    [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(registerNewBtn);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(30);
    }];
//    //qq登录
//    [QQBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view).offset(-30);
//        make.top.equalTo(centerLine.mas_bottom).offset(30);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [weiChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.view).offset(30);
//        make.top.equalTo(centerLine.mas_bottom).offset(30);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(QQBtn.mas_centerX).offset(-60);
//        make.top.equalTo(centerLine.mas_bottom).offset(30);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [renrenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(weiChatBtn.mas_centerX).offset(60);
//        make.top.equalTo(centerLine.mas_bottom).offset(30);
//        make.width.mas_equalTo(20);
//        make.height.mas_equalTo(20);
//
//    }];
    
    //MARK: - 监听按钮点击
    [registerNewBtn addTarget:self action:@selector(registerNewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [forgetPwd addTarget:self action:@selector(forgetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [byTextMessageBtn addTarget:self action:@selector(byTextMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
//    [QQBtn addTarget:self action:@selector(QQBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [weiChatBtn addTarget:self action:@selector(weiChatBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [weiboBtn addTarget:self action:@selector(weiboBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [renrenBtn addTarget:self action:@selector(renrenBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 第三方登录
//- (void)QQBtnClick {
//    [ThirdPlatformLogin QQLogin];
//    
//    //登录完成 跳到首页
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 0;
//}

//- (void)weiChatBtnClick {
//    [ThirdPlatformLogin weChatLogin];
//    //登录完成 跳到首页
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 0;
//}
//
//- (void)weiboBtnClick {
//    [ThirdPlatformLogin weiboLogin];
//    //登录完成 跳到首页
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 0;
//}

//- (void)renrenBtnClick {
//    [ThirdPlatformLogin renrenLogin];
//    //登录完成 跳到首页
//    [self.navigationController popToRootViewControllerAnimated:YES];
//    self.tabBarController.selectedIndex = 0;
//}



///登录按钮点击
#pragma mark - 登录按钮点击
- (void)loginBtnClick {
/*
 用户登录接口，密码登录
 接口路径：http://ma.beidaivf04.com/index.php/Home/Enter
 传值方式：GET  参数：name=用户名 pwd=密码
 返回值：纯文本 “用户名不存在”,”密码错误”,”登陆成功” 关键字：无
 */

    
    
    if (self.accountTextField.text.length ==0 || self.passwordTextField.text.length == 0) {
        [MBProgressHUD showError:@"对比起,您输入的账户和密码不能空" toView:self.navigationController.view];
        return;
    }
    
    //网络判断
    NSString *ull = [NSString stringWithFormat:@"http://ma.beidaivf04.com/index.php/Home/Enter?name=%@&pwd=%@",self.accountTextField.text,self.passwordTextField.text];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    // 让AFN返回原始的二进制数据我们自己解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.securityPolicy.validatesDomainName = NO;
    
    //NSLog(@"ull = %@",ull);
    
    [manager GET:ull parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSLog(@"%@ -- %@",[responseObject class],responseObject);
        NSLog(@"%@",responseObject);
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",html);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //判断接收到的字符串
            //“用户名不存在”,”密码错误”,”登陆成功”
            if ([html isEqualToString:@"用户名不存在"]) {
                [MBProgressHUD showError:@"您输入的用户名不存在" toView:self.navigationController.view];
                return ;
            }
            
            if ([html isEqualToString:@"密码错误"]) {
                [MBProgressHUD showError:@"您输入的密码错误" toView:self.navigationController.view];
                return ;
                
            }
            
            if ([html isEqualToString:@"登录成功"]) {
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setValue:@"autologinIdentifier" forKey:@"autologinIdentifier"];
                [userDefaults synchronize];
                
                [MBProgressHUD showSuccess:@"登陆成功" toView:self.navigationController.view];
                
                XFRootVC *vc = [[XFRootVC alloc]init];
                
                
                AppDelegate *ap = [[UIApplication sharedApplication]delegate];
                
                ap.idNumber = self.accountTextField.text;
                
                [self.navigationController pushViewController:vc animated:YES];
                
                
            }

            
            
            
        });
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // NSLog(@"%@",error);
    }];
    
    
    
}


///注册新账号按钮点击
#pragma mark - 注册新账号按钮点击
- (void)registerNewBtnClick {
    WXPRegisterVC *vc = [[WXPRegisterVC alloc] init];
    vc.userType = self.userType;
    
//    NSLog(@"loginVC 里 %@",self.userType);
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

///通过短信验证码登录
#pragma mark - 通过短信验证码登录
- (void)byTextMessageBtnClick {
    WXPRegisterByMessaryVC *vc = [[WXPRegisterByMessaryVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


///忘记密码按钮点击
#pragma mark - 忘记密码按钮点击
- (void)forgetPwdBtnClick {
    WXPfForgetPwdVC *vc = [[WXPfForgetPwdVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

///设置textField里面图片
#pragma mark - 设置textField里面图片
-(void)setTextFieldLeftImage:(UITextField *)textField leftImage:(NSString *)imageNamed{
    
    //设置左边的图片
    UIImageView *leftView = [[UIImageView alloc]init];
    leftView.image = [UIImage imageNamed:imageNamed];
    leftView.frame = CGRectMake(0, 0, 30, 30);
    
    //设置leftView的内容居中显示
    leftView.contentMode = UIViewContentModeCenter;
    textField.leftView = leftView;
    
    // 设置左边的view永远显示
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    // 设置右边永远显示清除按钮
    textField.clearButtonMode = UITextFieldViewModeAlways;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
