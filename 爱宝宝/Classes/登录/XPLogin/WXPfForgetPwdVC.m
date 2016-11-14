//
//  forgetPwdVC.m
//  
//
//  Created by 王小鹏 on 16/7/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "WXPfForgetPwdVC.h"
#import "Masonry.h"
//#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD+Ex.h"


@interface WXPfForgetPwdVC ()
///手机号
@property (nonatomic, weak) UITextField *phoneTextField;
///验证码
@property (nonatomic, weak) UITextField *passwordTextField;
///同意按钮
@property (nonatomic, weak) UIButton *argeeBtn;
//获取验证码
@property (nonatomic, weak) UIButton *getPwd;
///定时器
@property (nonatomic, strong) NSTimer *timer;
///记录改变的时间
@property (nonatomic, assign) int  changTime;
///记录发送短信的电话号码字符串
@property (nonatomic, copy) NSString *keyStr;
@end

@implementation WXPfForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.changTime = 60;
    
    //MARK: - 创建控件并添加到父控件中
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
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];//下一步
    [self.view addSubview:nextBtn];
    
    
    #pragma mark - 设置占位文字和图片
    phoneTextField.placeholder = @"请输入你的手机号码";
    [self setTextFieldLeftImage:phoneTextField leftImage:@"手机.png"];
    passwordTextField.placeholder = @"请输入您的验证码";
    [self setTextFieldLeftImage:passwordTextField leftImage:@"锁.png"];
    
    [getPwd setBackgroundColor:[UIColor lightGrayColor]];
//    [self setTextFieldLeftImage:inviteNumTextField leftImage:@"product_img_icon_xieyi.png"];
    
    
    //设置默认状态的文字和颜色
    [getPwd setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getPwd setTitleColor:[UIColor colorWithRed:8/256.0 green:65/256.0 blue:130/256.0 alpha:1] forState:UIControlStateNormal];
    
    //设置换出输入框的格式
    phoneTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    passwordTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor colorWithRed:8/256.0 green:65/256.0 blue:130/256.0 alpha:1]];
    
    //MARK: - 设置frame信息
    //电话
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(60 + 64);
        make.left.offset(30);
        make.right.offset(-30);
    }];
    //获取验证码
    [getPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.right.offset(-30);
        make.top.equalTo(phoneTextField.mas_bottom).offset(35);
    }];
    //输入验证码
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.equalTo(getPwd.mas_left).offset(-15);
        make.top.equalTo(phoneTextField.mas_bottom).offset(35);
    }];
    //下一步按钮
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.equalTo(passwordTextField.mas_bottom).offset(50);
    }];
    
    //MARK: - 监听按钮点击
    [getPwd addTarget:self action:@selector(getPwdBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -下一步按钮点击
- (void)nextBtnClick {
    self.keyStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"tel"];
    
//    [SMSSDK commitVerificationCode:self.passwordTextField.text phoneNumber:self.keyStr zone:@"86" result:^(NSError *error) {
//        NSLog(@"%@---%@",self.passwordTextField.text,self.keyStr);
//        if (!error) {
//            NSLog(@"成功");
//            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"" message:@"验证成功" preferredStyle:UIAlertControllerStyleAlert];
//            
//            [self presentViewController:alertView animated:YES completion:^{
//                [NSThread sleepForTimeInterval:2.0];
//                [self dismissViewControllerAnimated:YES completion:^{
//                    //成功之后执行跳转重置密码
//                    [self.navigationController pushViewController:[[WXPSetPwdVC alloc] init] animated:YES];
//                    
//                }];
//            }];
//        }else{
//            NSLog(@"%@",error);
//            
//            [MBProgressHUD showError:@"验证码错误" toView:self.navigationController.view];
//        }
//    }];
    
    
}


#pragma mark -点击获取验证码
- (void)getPwdBtnClick {
    if (self.phoneTextField.text.length != 11) {
        
        [MBProgressHUD showError:@"手机号不符合规则" toView:self.navigationController.view];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneTextField.text forKey:@"tel"];
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
//        if (!error) {
//            NSLog(@"获取验证码成功");
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"获取成功" preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alertController animated:YES completion:^{
//                [NSThread sleepForTimeInterval:2.0];
//                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//            }];
//        } else {
//            NSLog(@"%@",error);
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"获取失败,请重新获取" preferredStyle:UIAlertControllerStyleAlert];
//            [self presentViewController:alertController animated:YES completion:^{
//                [NSThread sleepForTimeInterval:1.0];
//                [self dismissViewControllerAnimated:YES completion:nil];
//            }];
//        }
//    }];
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
        [self.getPwd setTitleColor:[UIColor colorWithRed:8/255.0 green:65.0/255 blue:130.0/255 alpha:0.8] forState:UIControlStateNormal];
        [self.getPwd setBackgroundColor:[UIColor colorWithRed:236 green:236 blue:236 alpha:1]];
        //停止定时器
        [self.timer invalidate];
        return;
    }
    
    [self.getPwd setTitle:[NSString stringWithFormat:@"%d秒",remainTime] forState:UIControlStateNormal];
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

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
}


@end
