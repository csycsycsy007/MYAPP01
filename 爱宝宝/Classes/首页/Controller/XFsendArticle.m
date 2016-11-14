//
//  XFsendArticle.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/26.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFsendArticle.h"
#import "XFdetailedVC.h"
#import "HSHTTPClient.h"
#import "AppDelegate.h"

@interface XFsendArticle ()<UITextViewDelegate>
@property(nonatomic,strong) UIScrollView * scrollV;
@property(nonatomic,strong) UITextView * contextV;
@end

@implementation XFsendArticle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"回复楼主";
    float a = [UIScreen mainScreen].bounds.size.width;
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, a, [UIScreen mainScreen].bounds.size.height)];
    sc.contentSize = CGSizeMake(0, 1200);
    self.scrollV = sc;
    [self.view addSubview:self.scrollV];
    
    UITextView *contTxtV = [[UITextView alloc]initWithFrame:CGRectMake(0 , 0 , a, 600)];
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
    
//    UIBarButtonItem *itm = [[UIBarButtonItem alloc]init];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendComment)];
    self.navigationItem.rightBarButtonItem = rightBarItem;

}

- (void)sendComment {
    
    XFdetailedVC *thirdVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    /*
     文章评论接口
     接口路径：http://ma.beidaivf04.com/admin.php/Comment/article_comment
     传值方式：GET 参数 name=用户名 id=文章id  content=评论内容
     返回值：”请输入用户名” “请输入标题” “请输入内容” “添加成功” “添加失败
     */
    //发送网络请求
    if (self.contextV.text.length > 0) {
     
        AppDelegate *ap = [[UIApplication sharedApplication]delegate];
        
        NSString *str1 = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Comment/article_comment?name=%@&id=%@&content=%@",ap.idNumber,self.artID,self.contextV.text];
        
        
        
        NSString *URLString = [str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [HSHTTPClient request:GET URLString:URLString parameters:nil success:^(id json) {
            //        NSLog(@"%@",(NSDictionary *)json);
            
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        

    }
    
    
    [self.navigationController popToViewController:thirdVC animated:YES];
    
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

@end
