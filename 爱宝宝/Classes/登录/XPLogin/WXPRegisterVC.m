//
//  WXPRegisterVC.m
//  group12_fastDoctor
//
//  Created by xxf on 16/7/18.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WXPRegisterVC.h"
#import "WXPLoginVC.h"
#import "Masonry.h"
//#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD+Ex.h"

#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"

#import "XFRootVC.h"

@interface WXPRegisterVC ()
///手机号
@property (nonatomic, weak) UITextField *phoneTextField;
///验证码
@property (nonatomic, weak) UITextField *passwordTextField;
///同意按钮
@property (nonatomic, weak) UIButton *argeeBtn;
//获取验证码
@property (nonatomic, weak) UIButton *getPwd;
//下一步按钮
@property (nonatomic, weak) UIButton *nextBtn;
//设置密码按钮
@property (nonatomic, weak) UITextField *psdField;


///定时器
@property (nonatomic, strong) NSTimer *timer;
///记录改变的时间
@property (nonatomic, assign) int  changTime;
///记录发送短信的电话号码字符串
@property (nonatomic, copy) NSString *yzmStr;

@property (nonatomic, copy) NSString *checkWord;



@end

@implementation WXPRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.changTime = 60;
    //加载数据
    [self loadData];
    
   }

///加载数据
- (void)loadData {
    //创建控件并添加到父控件中
#pragma mark - 创建控件并添加到父控件中
    UITextField *phoneTextField = [[UITextField alloc] init];//手机号码
    phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:phoneTextField];
    self.phoneTextField = phoneTextField;
    
    UITextField *passwordTextField = [[UITextField alloc] init];//验证码
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    
    UIButton *getPwd = [UIButton buttonWithType:UIButtonTypeCustom];//获取验证码
    [self.view addSubview:getPwd];
    self.getPwd = getPwd;
    
    UITextField *inviteNumTextField = [[UITextField alloc] init];//邀请码
    inviteNumTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:inviteNumTextField];
    self.psdField = inviteNumTextField;
    
    UIButton *argeeBtn = [UIButton buttonWithType:UIButtonTypeCustom];//同意按钮
    [self.view addSubview:argeeBtn];
    self.argeeBtn = argeeBtn;
    
    UILabel *readAndAgreeLable = [[UILabel alloc] init];//同意并阅读标签
    [self.view addSubview:readAndAgreeLable];
    
    UIButton *propertyBtn = [UIButton buttonWithType:UIButtonTypeSystem];//用户协议按钮
    [self.view addSubview:propertyBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];//下一步
    [self.view addSubview:nextBtn];
    self.nextBtn = nextBtn;
    
    UIButton *directLoginBtn = [UIButton buttonWithType:UIButtonTypeSystem];//已注册账号,直接登录
    
    [self.view addSubview:directLoginBtn];
    
    //设置占位文字和图片
    phoneTextField.placeholder = @"请输入你的手机号码";
    [self setTextFieldLeftImage:phoneTextField leftImage:@"手机.png"];
    passwordTextField.placeholder = @"请输入您的验证码";
    [self setTextFieldLeftImage:passwordTextField leftImage:@"锁.png"];
    inviteNumTextField.placeholder = @"请设置密码";
    [getPwd setBackgroundColor:[UIColor lightGrayColor]];
    [self setTextFieldLeftImage:inviteNumTextField leftImage:@"锁.png"];
    
    //设置默认状态的文字和颜色
    [getPwd setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getPwd setTitleColor:[UIColor colorWithRed:8/255.0 green:65/256.0 blue:130/256.0 alpha:1] forState:UIControlStateNormal];
    
    [argeeBtn setBackgroundImage:[UIImage imageNamed:@"illness_rb_img_nor.png"] forState:UIControlStateNormal];
    [argeeBtn setBackgroundImage:[UIImage imageNamed:@"illness_rb_img_sel.png"] forState:UIControlStateSelected];
    
    readAndAgreeLable.text = @"本人已经同意并阅读";
    readAndAgreeLable.font = [UIFont systemFontOfSize:12.0];
    
    [propertyBtn setTitle:@"用户协议" forState:UIControlStateNormal];
    propertyBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    [nextBtn setTitle:@"注册并登录" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    
    [directLoginBtn setTitle:@"已有注册账号,直接登录" forState:UIControlStateNormal];
    directLoginBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    
    //监听按钮点击
#pragma mark - 监听按钮点击
    [getPwd addTarget:self action:@selector(getPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [argeeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [directLoginBtn addTarget:self action:@selector(directLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark - 设置frame信息
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25 + 64);
        make.left.offset(30);
        make.right.offset(-30);
    }];
    //获取验证码
    [getPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.right.offset(-30);
        make.top.equalTo(phoneTextField.mas_bottom).offset(25);
    }];
    //输入验证码
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.equalTo(getPwd.mas_left).offset(-15);
        make.top.equalTo(phoneTextField.mas_bottom).offset(25);
    }];
    //输入邀请码
    [inviteNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(passwordTextField.mas_bottom).offset(25);
    }];
    //设置换出输入框的格式
    phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    //同意按钮
    [argeeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.top.equalTo(inviteNumTextField.mas_bottom).offset(60);
    }];
    //同意并阅读标签
    [readAndAgreeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(argeeBtn.mas_right).offset(10);
        make.top.equalTo(inviteNumTextField.mas_bottom).offset(60);
    }];
    
    //协议按钮
    [propertyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(argeeBtn);
        make.left.equalTo(readAndAgreeLable.mas_right).offset(-10);
        make.width.mas_equalTo(100);
    }];
    //下一步按钮
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(readAndAgreeLable.mas_bottom).offset(20);
    }];
    //已有账号,直接登录
    [directLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.equalTo(nextBtn.mas_bottom).offset(70);
        make.width.mas_equalTo(200);
    }];
}




#pragma mark -注册并登陆 按钮点击
- (void)nextBtnClick {
//    self.yzmStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
//    NSLog(@"-----%@-%@-----",self.yzmStr,self.passwordTextField.text);
    
    if (self.passwordTextField.text == self.yzmStr ){
      
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString *para2 = [NSString stringWithFormat:@"&pwd=%@",self.psdField.text];
        NSString *para3 = [NSString stringWithFormat:@"&type=%@",self.userType];

        NSString *domainSt = [NSString stringWithFormat:@"http://ma.beidaivf04.com/index.php/Home/Login/Login?tel=%@%@%@",self.phoneTextField.text,para2,para3];
        
//        NSLog(@"下一步中domainStr =  %@",domainSt);
        
        NSString *domainStr = [domainSt stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

      //  NSLog(@"下一步中domainStr =  %@",domainSt);
        
        [manager GET:domainStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            self.checkWord = html;
            
            if ([self.checkWord isEqualToString:@"注册成功"]) {
                
//                NSLog(@"-232---%@--%@----",self.checkWord,html);
                
                XFRootVC *vc = [[XFRootVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                
//                NSLog(@"-238---%@--%@----",self.checkWord,html);
                

                
                [MBProgressHUD showError:@"失败" toView:self.navigationController.view];
                
                
            }


            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
           // NSLog(@"%@",error);
        }];
        

    } else {
        
        
//                     NSLog(@"-257---%@------",self.checkWord);
//    NSLog(@"-258----%@-%@-----",self.yzmStr,self.passwordTextField.text);
            [MBProgressHUD showError:@"验证码错误" toView:self.navigationController.view];
        
    }
    

}

#pragma mark -选中同意按钮
- (void)agreeBtnClick:(UIButton *)button {
     button.selected = !button.selected;
    
    
    if (button.selected && (self.phoneTextField.text.length ==11 ) &&(self.passwordTextField.text.length >0)&&(self.psdField.text > 0 ) ) {
        self.nextBtn.enabled = YES;
        self.nextBtn.backgroundColor = [UIColor colorWithRed:8/256.0 green:65/256.0 blue:130/256.0 alpha:0.8];
    } else {
        self.nextBtn.enabled = NO;
        self.nextBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

#pragma mark -已有注册账号,直接登录按钮点击
- (void)directLoginBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark -点击获取验证码
- (void)getPwdBtnClick {
    if (self.phoneTextField.text.length != 11) {
        
        [MBProgressHUD showError:@"手机号不符合规则" toView:self.navigationController.view];
        return;
    }
//    [[NSUserDefaults standardUserDefaults] setObject:self.phoneTextField.text forKey:@"tel"];

    
    // 1.创建网络请求呢管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *domainStr = [NSString stringWithFormat:@"http://ma.beidaivf04.com/index.php/Home/Login?tel=%@",self.phoneTextField.text];
    
    NSLog(@"获取里 domainstr = %@",domainStr);
    
    
    
    [manager GET:domainStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *html = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        self.yzmStr = html;
        
     // NSLog(@"self.yzmStr %@",self.yzmStr);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];

    
    //设置按钮的交互事件
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
        [self.getPwd setTitleColor:[UIColor colorWithRed:8/255.0 green:65/255.0 blue:130/255.0 alpha:0.8] forState:UIControlStateNormal];
        [self.getPwd setBackgroundColor:[UIColor colorWithRed:236 green:236 blue:236 alpha:1]];
        //停止定时器
        [self.timer invalidate];
        return;
    }
    
    [self.getPwd setTitle:[NSString stringWithFormat:@"%d秒",remainTime] forState:UIControlStateNormal];
}

#pragma mark -返回到原来的控制器
- (void)logoutBtnClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

//点击屏幕退出输入框
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
