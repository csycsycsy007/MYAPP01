//
//  XFdetailedCircle.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/18.
//  Copyright © 2016年 PUHIM. All rights reserved.
//
#import "AppDelegate.h"
#import "XFdetailedCircle.h"

#import "XFcirHeaderView.h"
#import "XFcommentCell.h"
#import "XFcommentCelModel.h"
#import "HSHTTPClient.h"
#import "MJRefresh.h"
#import "MBProgressHUD+Ex.h"


@interface XFdetailedCircle ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSOperationQueue *queue;
@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) XFcommentCelModel * mod;
@property(nonatomic,strong) NSMutableArray * modelArray;
@property(nonatomic,copy) NSString * userId;

//发表回复的框
@property(nonatomic,strong) UITextField * txtF;
@end

@implementation XFdetailedCircle

//static NSInteger pagE = 1;

- (void)viewDidLoad {
    
    //解决 snapshotting a view bug
    if([[[UIDevice
          currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"圈子详情";
    [self loaddata1];
    [self setUpTableView];
    [self setUpSendView];
    self.tableView.estimatedRowHeight = 100;
//     让行高自动计算
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData2)];
    self.tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}

//上拉刷新
-(void)loadData2 {
    
//    NSLog(@"上拉");
    
    // 结束刷新
    [self.tableView.mj_header endRefreshing];
}

-(void)loadMoreData {
//            NSLog(@"下拉");
    NSString *str1 = [NSString stringWithFormat:@"&page=%zd",++self.pagE];
    NSString *str2 = [NSString stringWithFormat:@"title=%@",self.cirle_title];
    NSString *str3 = [str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // URL
    NSString *URLString = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/forum_comment?%@%@",str3,str1];
    NSURL *URL= [NSURL URLWithString:URLString];
    
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 处理响应
        if (connectionError == nil && data != nil) {
            // 反序列化
            // data : 保存的是JSON对象数组的二进制数据
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
            
            //            NSLog(@"%@-----result class: %@",result,[result class]);
            
            // 定义一个可变数组
            NSMutableArray *tmpM =[NSMutableArray arrayWithCapacity:result.count];
            
            // 遍历字典数组,取出字典,实现字典转模型
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XFcommentCelModel   *news = [XFcommentCelModel commentWithDict:obj];
                
                
                
                [tmpM addObject:news];
            }];
            
            // 什么时候数据加载完,就什么时候给数据源数组赋值
            if (tmpM.count) {

                NSMutableArray *arrM = [[NSMutableArray alloc] init];
                [arrM addObjectsFromArray:self.modelArray];
                [arrM addObjectsFromArray:tmpM.copy];
                self.modelArray = arrM;

                
//                [self.modelArray insertObjects:tmpM.copy atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tmpM.count -1)]];
////                [self.modelArray addObjectsFromArray:tmpM.copy];
                
                // 数据源数组什么时候有值,就什么时候刷新列表
                [self.tableView reloadData];            }

            
        } else {
            NSLog(@"%@",connectionError);
        }
    }];

    
    
    
    
    // 结束刷新
    [self.tableView.mj_footer endRefreshing];
}






//这个是下载用户头像的队列
- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
- (void)loaddata1
{
    NSString *str1 = @"&page=1";
    NSString *str2 = [NSString stringWithFormat:@"title=%@",self.cirle_title];
    NSString *str3 = [str2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // URL
    NSString *URLString = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/forum_comment?%@%@",str3,str1];
    NSURL *URL= [NSURL URLWithString:URLString];
    
    // 请求
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    // 发送异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 处理响应
        if (connectionError == nil && data != nil) {
            // 反序列化
            // data : 保存的是JSON对象数组的二进制数据
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            
                       
//            NSLog(@"%@-----result class: %@",result,[result class]);
            
            // 定义一个可变数组
            NSMutableArray *tmpM =[NSMutableArray arrayWithCapacity:result.count];
            
            // 遍历字典数组,取出字典,实现字典转模型
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XFcommentCelModel   *news = [XFcommentCelModel commentWithDict:obj];
                
                
                
                [tmpM addObject:news];
            }];
            
            // 什么时候数据加载完,就什么时候给数据源数组赋值

                        self.modelArray = tmpM.copy;
            // 数据源数组什么时候有值,就什么时候刷新列表
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@",connectionError);
        }
    }];
}


#pragma mark ---创建 tableview 和 头部视图
-(void)setUpTableView {
    
    UITableView *tb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44)];
    
    
    
    
//    tb.bounces = NO;
    self.tableView = tb;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
    [self.view addSubview:self.tableView];
    
    XFcirHeaderView *ve = [XFcirHeaderView allocHeaderView];
    
    ve.head_titlelab.numberOfLines = 0;
    ve.contentLab.numberOfLines = 0;
    [ve.head_titlelab sizeToFit];
    [ve.contentLab sizeToFit];
    
    
    
    NSString *URLString = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/forum_content?id=%@",self.cirle_id];
    //访问网络数据给 content 赋值
    
    [HSHTTPClient request:GET URLString:URLString parameters:nil success:^(id json) {
        //        NSLog(@"%@",(NSDictionary *)json);
        NSDictionary *dic = json;
        //注意:加载完成数据之后再去给控件赋值
//                NSLog(@"%@",dic[@"cirle_content"]);
        
        
        [ve.looktimeBtn setTitle:dic[@"cirle_look"] forState:UIControlStateNormal];
        [ve.commentTimeBtn setTitle:dic[@"cirle_commentNb"] forState:UIControlStateNormal];
        [ve.labBtn setTitle:dic[@"cirle_tag"] forState:UIControlStateNormal];
        
        ve.contentLab.text = dic[@"cirle_content"];
        
        self.user_images = dic[@"user_images"];
        
        //NSLog(@"self.user_images = %@",dic[@"user_images"]);
        NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            // 下载图片 : 耗时操作
            NSURL *url = [NSURL URLWithString:self.user_images];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            
            //        NSLog(@"url = %@",url);
            
            // 图片下载完后曾只有,需要刷新UI
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // 赋值
                //            [ve.iconBtn setImage:image forState:UIControlStateNormal];
                [ve.iconBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
                //            NSLog(@"image = %@",image);
            }];
        }];
        
        // 把下载操作添加到队列
        [self.queue addOperation:op];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
    
    
    ve.head_titlelab.text = self.cirle_title;
    [ve.looktimeBtn setTitle:self.cirle_look forState:UIControlStateNormal];
    [ve.commentTimeBtn setTitle:self.cirle_commentNb forState:UIControlStateNormal];
    

    ve.userIdlab.text = self.user_name;
    ve.userTimeLab.text = self.cirle_time;
    [ve.labBtn setTitle:self.cirle_tag forState:UIControlStateNormal];
    ve.contentLab.text = self.cirle_title; //这里
    ve.line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0 ];
    [ve.labBtn setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    
    self.tableView.tableHeaderView =ve;
    
    //手势撤回键盘
    //监听键盘，键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardwill:)
                                                name:UIKeyboardWillShowNotification object:nil];
    
    //监听键盘隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keybaordhide:)
                                                name:UIKeyboardWillHideNotification object:nil];
    


    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    [self.tableView addGestureRecognizer:tap];
}

//当键盘出现时，调用此方法
-(void)keyboardwill:(NSNotification *)sender
 {
     //获取键盘高度
     NSDictionary *dict=[sender userInfo];
     NSValue *value=[dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardrect = [value CGRectValue];
     int height=keyboardrect.size.height;

     //如果输入框的高度低于键盘出现后的高度，视图就上升；
     if ((_txtF.frame.size.height + _txtF.frame.origin.y)>(self.view.frame.size.height - height))
        {
        self.view.frame = CGRectMake(0, -height, self.view.frame.size.width, self.view.frame.size.height);
         }
}

 //当键盘隐藏时候，视图回到原定
 -(void)keybaordhide:(NSNotification *)sender
 {
         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
     }

-(void)tap:(UITapGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}


#pragma mark 这里添加底部评论视图
-(void)setUpSendView {
    
    float a = [UIScreen mainScreen].bounds.size.width;
    float b = [UIScreen mainScreen].bounds.size.height;

    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(a - 68, b - 42, 60, 40)];
    
    [btn setTitle:@"发送" forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = .2f;
    btn.layer.borderColor = [[UIColor blackColor]CGColor];
    
    [self.view addSubview:btn];
    
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(8, b- 42, a - 8 - 8 - 68, 40)];
    textF.layer.cornerRadius = 10.f;
    textF.layer.masksToBounds = YES;
    textF.layer.borderWidth = .2f;
    textF.layer.borderColor = [[UIColor blackColor]CGColor];
    self.txtF = textF;
    
    [self.view addSubview:textF];
    self.txtF.placeholder = @"请输入评论";
    
    //发送按钮添加点击时间
    [btn addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    
}
//http://ma.beidaivf04.com/admin.php/Comment/forum_comment
//name=用户名 title=标题 content=内容
-(void)sendComment {
    

    
    if (self.txtF.text.length == 0) {
        
        [MBProgressHUD showError:@"请输入内容" toView:self.navigationController.view];
        
        
    } else {
        
        AppDelegate *ap = [[UIApplication sharedApplication]delegate];
        
        self.userId = ap.idNumber;
        
        NSString *str1 = [NSString stringWithFormat:@"name=%@",self.userId];
        NSString *str = [NSString stringWithFormat:@"&title=%@",self.cirle_title];
        NSString *str2 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *Str = [NSString stringWithFormat:@"&content=%@",self.txtF.text];
        NSString *str3 = [Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // URL
        NSString *URLString = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Comment/forum_comment?%@%@%@",str1,str2,str3];
        NSURL *URL= [NSURL URLWithString:URLString];
        
        // 请求
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        // 发送异步请求
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            // 处理响应
            if (connectionError == nil && data != nil) {
                
                [self.tableView reloadData];
                
            } else {
                NSLog(@"%@",connectionError);
            }
        }];
//告诉用户发送成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"评论成功" toView:self.navigationController.view];
        });
    }
            [self.view endEditing:YES];
    self.txtF.text = @"";
//    self.txtF.placeholder = @"请输入评论";
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    NSLog(@"%zd",self.modelArray.count);
    if (self.modelArray.count < 2) {
        self.tableView.separatorStyle = NO;
    } else {
        self.tableView.separatorStyle = YES;
    }
    
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建cell
    XFcommentCell *cell = [XFcommentCell cellWithTableview:tableView];

    
    
    
 
    if (self.modelArray) {
       
        cell.cellModel = self.modelArray[indexPath.row];
        
//        NSLog(@"cell.cellModel =  %@",cell.cellModel);
        
        cell.contentLab.text = cell.cellModel.cirle_content;
        cell.nameLab.text = cell.cellModel.cirle_name;
        cell.timeLab.text = cell.cellModel.cirle_time;
//        cell.floorLab.text = cell.cellModel.cirle_floor;
//        cell.contentLab.text = @"23423";
//        cell.nameLab.text = @"name";
        cell.timeLab.text = cell.cellModel.cirle_time;
        
        NSString *st = [NSString stringWithFormat:@"%zd",cell.cellModel.cirle_floor];
        cell.floorLab.text = st;
        

        
//        cell.contentLab.text = cell.cellModel.cirle_content;
//        NSLog(@"");

    }
    
    
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
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
