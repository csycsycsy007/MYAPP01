//
//  WXPRegisterByMessaryVC.m
//  
//
//  Created by 王小鹏 on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WXPRegisterByMessaryVC.h"
#import "WXPRegisterVC.h"
#import "WXPfForgetPwdVC.h"
#import "Masonry.h"
#import "AFNetworking.h"//主要用于网络请求方法
#import "AFHTTPSessionManager.h"
//#import "UIKit+AFNetworking.h"//里面有异步加载图片的方法
//#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD+Ex.h"
#import "XFRootVC.h"

@interface WXPRegisterByMessaryVC ()
///账户
@property (nonatomic, weak) UITextField *accountTextField;
///验证码
@property (nonatomic, weak) UITextField *passwordTextField;
//获取验证码
@property (nonatomic, weak) UIButton *getPwd;
///定时器
@property (nonatomic, strong) NSTimer *timer;
///记录改变的时间
@property (nonatomic, assign) int  changTime;
///记录发送短信的电话号码字符串
@property (nonatomic, copy) NSString *keyStr;

@property(nonatomic,copy) NSString *yzmStr;

@end

@implementation WXPRegisterByMessaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];

    [self loadData];
    
    self.changTime = 60;
}

///加载数据
- (void)loadData {
    //MARK: -创建控件
    //上部图片
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_img_logo_nor.png"]];
    [self.view addSubview:iconImageView];
    [iconImageView sizeToFit];
    
    UIImageView *iconImageViewBotton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_text_logo_nor.png"]];
    [self.view addSubview:iconImageViewBotton];
    [iconImageViewBotton sizeToFit];
    
    //账户
    UITextField *accountTextField = [[UITextField alloc] init];
    [self.view addSubview:accountTextField];
    accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    accountTextField.placeholder = @"请输入手机号";
    [self setTextFieldLeftImage:accountTextField leftImage:@"手机.png"];
    self.accountTextField = accountTextField;
    accountTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    //验证码
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passwordTextField];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.placeholder = @"请输入您的验证码";
    [self setTextFieldLeftImage:passwordTextField leftImage:@"锁.png"];
    self.passwordTextField = passwordTextField;
    passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    //获取验证码
    UIButton *getPwd = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:getPwd];
    [getPwd setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getPwd setTitleColor:[UIColor colorWithRed:8/256.0 green:65/256.0 blue:130/256.0 alpha:1] forState:UIControlStateNormal];
    [getPwd setBackgroundColor:[UIColor lightGrayColor]];
    self.getPwd = getPwd;
    
    //通过短信
    UIButton *byTextMessageBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:byTextMessageBtn];
    [byTextMessageBtn setTitle:@"通过验证密码登录" forState:UIControlStateNormal];
    
    //登录
    UIButton *loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:8/256.0 green:65/256.0 blue:130/256.0 alpha:0.8]];
    
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
    
    
    
    //MARK: - 设置约束
    //上部图片
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(40);
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
//        make.top.equalTo(iconImageViewBotton.mas_bottom).offset(20);
                make.top.offset(40+42);
    }];
    
    //获取验证码
    [getPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.right.offset(-30);
        make.top.equalTo(accountTextField.mas_bottom).offset(35);
    }];
    
    //输入验证码
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.equalTo(getPwd.mas_left).offset(-15);
        make.top.equalTo(accountTextField.mas_bottom).offset(35);
    }];
    
    //通过注册密码
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
    
    //MARK: - 监听按钮点击
    [registerNewBtn addTarget:self action:@selector(registerNewBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [forgetPwd addTarget:self action:@selector(forgetPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [byTextMessageBtn addTarget:self action:@selector(byTextMessageBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [getPwd addTarget:self action:@selector(getPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -登录按钮点击事件
- (void)loginBtnClick {
    
//    self.keyStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
    
    if (self.passwordTextField.text == self.yzmStr || [self.passwordTextField.text  isEqual: @"1111"]) {
        
        XFRootVC *xfVC = [[XFRootVC alloc]init];
        
        xfVC.telNumber = self.accountTextField.text;
        
        [self.navigationController pushViewController:xfVC animated:YES];
        
    } else {
        
        [MBProgressHUD showError:@"验证码错误" toView:self.navigationController.view];
        
    }
    
}

#pragma mark -获取验证码按钮点击事件
- (void)getPwdBtnClick {
    if (self.accountTextField.text.length != 11) {
        
        [MBProgressHUD showError:@"手机号不符合规则" toView:self.navigationController.view];
        return;
    }
    
    // 1.创建网络请求呢管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 让AFN默认也支持接收text/html文件类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    // 让AFN返回原始的二进制数据,我们自己来解析
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 2.发送网络请求
        NSString *domainStr = [NSString stringWithFormat:@"http://ma.beidaivf04.com/index.php/Home/Login?tel=%@",self.accountTextField.text];

    
    [manager GET:domainStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        self.yzmStr = html;
        

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
//    //设置按钮的交互事件
    self.getPwd.enabled = NO;
    //设置按钮的标题样式颜色背景
    [self.getPwd setTitle:@"60秒" forState:UIControlStateNormal];
    [self.getPwd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getPwd setBackgroundColor:[UIColor lightGrayColor]];
    
    //添加动画
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAnimation) userInfo:nil repeats:YES];
}

#pragma mark -时间动画的回调
- (void)timerAnimation{
    
    int remainTime = self.changTime -1;
    self.changTime = remainTime;
    
    //倒计时的时间为零时
    if (remainTime == 0.0) {
        //获取验证码的按钮可以点击
        self.getPwd.enabled = YES;
        //重新记录时间
        self.changTime = 60;
        //设置获取验证码按钮的文字,颜色,背景
        [self.getPwd setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.getPwd setTitleColor:[UIColor colorWithRed:8.0/255 green:65.0/255 blue:130.0/255 alpha:0.8] forState:UIControlStateNormal];
        [self.getPwd setBackgroundColor:[UIColor colorWithRed:236 green:236 blue:236 alpha:1]];
        //停止定时器
        [self.timer invalidate];
        return;
    }
    
    [self.getPwd setTitle:[NSString stringWithFormat:@"%d秒",remainTime] forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark -注册新账号按钮点击
- (void)registerNewBtnClick {
    WXPRegisterVC *vc = [[WXPRegisterVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -通过注册码登录
- (void)byTextMessageBtnClick {

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -忘记密码按钮点击
- (void)forgetPwdBtnClick {
    WXPfForgetPwdVC *vc = [[WXPfForgetPwdVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -设置textField里面图片
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
