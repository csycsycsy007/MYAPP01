//
//  XFpostVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/12.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFpostVC.h"
#import "XFlabSelectVC.h"
#import "XFThirdVC.h"
#import "MBProgressHUD+Ex.h"
#import "AppDelegate.h"

@interface XFpostVC ()<UITextViewDelegate>
//发布按钮
@property(nonatomic,weak) UIButton *post;
//整体页面简历在 scroll 上
@property(nonatomic,strong) UIScrollView *scrollV;
//标题和文本内容的 txtfield
@property(nonatomic,strong) UITextField * titTxfield;

//监听的文章内容
@property (nonatomic, strong) UITextView *contextV;
//添加标签按钮

@end

@implementation XFpostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutBtnandLab];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//布局整体界面
- (void)layoutBtnandLab {
    
    float a = [UIScreen mainScreen].bounds.size.width;
    //添加标签的按钮
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 100, 24)];
    
    addBtn.backgroundColor = [UIColor magentaColor];
    
    addBtn.layer.cornerRadius = 10;
    addBtn.layer.masksToBounds = YES;
    
    [addBtn setTitle:@"添加标签" forState:UIControlStateNormal];
    self.addLabBtn = addBtn;
    [self.addLabBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, a, [UIScreen mainScreen].bounds.size.height)];
    
    [self.view addSubview: sc];
    self.scrollV = sc;
    self.scrollV.contentSize = CGSizeMake(0, 1200);
    [self.scrollV addSubview: addBtn];
    
    
    //三个透明 button
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(8, 60, (a-16-20)/3, 30)];
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(8+(a-16-20)/3+10, 60, (a-16-20)/3, 30)];
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(8+20+(a-16-20)/3*2, 60, (a-16-20)/3, 30)];
    
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [btn1 setTitle:@"占位符展位" forState:UIControlStateNormal];
    [btn2 setTitle:@"占位符展位" forState:UIControlStateNormal];
    [btn3 setTitle:@"占位符展位" forState:UIControlStateNormal];
    
//    btn1.titleLabel.font = [UIFont systemFontOfSize:17];
//        btn2.titleLabel.font = [UIFont systemFontOfSize:17];
//        btn3.titleLabel.font = [UIFont systemFontOfSize:17];
    
    btn1.userInteractionEnabled = NO;
    btn2.userInteractionEnabled = NO;
    btn3.userInteractionEnabled = NO;
    

    
    btn1.hidden = YES;
    btn2.hidden = YES;
    btn3.hidden = YES;
    
    [self.scrollV addSubview:btn1];
    [self.scrollV addSubview:btn2];
    [self.scrollV addSubview:btn3];
    
    
    btn1.layer.borderWidth = 2.0f;
    btn2.layer.borderWidth = 2.0f;
    btn3.layer.borderWidth = 2.0f;
    
    self.labBtn1 = btn1;
    self.labBtn2 = btn2;
    self.labBtn3 = btn3;
    
    
    
    self.labBtnS = @[self.labBtn1,self.labBtn2 ,self.labBtn3];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake( 30, 100, 50, 30)];
    
    titleLab.text = @"标题";
    
    titleLab.font = [UIFont systemFontOfSize:20];
    
    UILabel *contLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 140, 50, 30)];
    
    contLab.font = [UIFont systemFontOfSize:20];
    
    contLab.text = @"正文";
    
    [self.scrollV addSubview:titleLab];
    [self.scrollV addSubview:contLab];
    
    UITextField *titleTxt = [[UITextField alloc]initWithFrame:CGRectMake(85, 100, 200, 30)];
    
    self.titTxfield = titleTxt;
    
    titleTxt.layer.borderWidth = 2.0f;
//    titleTxt.layer.cornerRadius = 5;
    
    [self.scrollV addSubview:titleTxt];
    titleTxt.placeholder = @"请输入标题";
    
    UITextView *contTxtV = [[UITextView alloc]initWithFrame:CGRectMake(30, 180, a-60, 600)];
    contTxtV.font = [UIFont systemFontOfSize:16];
    contTxtV.delegate = self;
    [self.scrollV addSubview:contTxtV];
    
    UILabel *placeholderLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 16)];
    placeholderLab.text = @"请输入正文";
    placeholderLab.textColor = [UIColor lightGrayColor];
    [placeholderLab sizeToFit];
    [contTxtV setValue:placeholderLab forKey:@"_placeholderLabel"];
    [contTxtV addSubview:placeholderLab];
    
    self.contextV = contTxtV;
    
    
}



-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    self . tabBarController . tabBar . hidden = YES ;
    self.navigationItem.title = @"发帖";
    
//
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 0, 50, 40)];
    [btn setTitle:@"发布" forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor] forState:<#(UIControlState)#>]
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    self.post = btn;
    
    [self.post addTarget:self action:@selector(postClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)addBtnClick {
    
    XFlabSelectVC *labVC = [[XFlabSelectVC alloc]init];
    
    
    [self.navigationController pushViewController:labVC animated:YES];
//    [self presentViewController:labVC animated:YES completion:nil];
    
    
}

/*
 发帖接口
 接口路径：http://ma.beidaivf04.com/admin.php/Forum
 传值方式：GET 参数 name=用户名 title=标题 content=文章内容 tag=标签
 返回值：纯文本 “添加成功”and”添加失败”
 
 titTxfield; *contextV;     self.labBtn1
 self.labBtn2
 self.labBtn3


 */
-(void)postClick {
 
    XFThirdVC *thirdVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    
    if (self.titTxfield.text.length > 0 && self.contextV.text.length >0) {
        
        AppDelegate *ap = [[UIApplication sharedApplication]delegate];
        
        NSString *str1 = [NSString stringWithFormat:@"%@%@%@",self.labBtn1.titleLabel.text,self.labBtn2.titleLabel.text,self.labBtn3.titleLabel.text];
        
        NSString *Str = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Forum?name=%@&title=%@&content=%@&tag=%@",ap.idNumber,self.titTxfield.text, self.contextV.text,str1];
        NSString *URLString = [Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // URL

        NSURL *URL= [NSURL URLWithString:URLString];
        
        // 请求
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        // 发送异步请求
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            // 处理响应
            if (connectionError == nil && data != nil) {
                
                            [MBProgressHUD showSuccess:@"请输入标题或正文" toView: self.navigationController.view];
                
            } else {
                NSLog(@"%@",connectionError);
            }
        }];
        
        [self.navigationController popToViewController:thirdVC animated:YES];
        
    } else {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"请输入标题或正文" toView: self.navigationController.view];
            
        });
        
        
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
