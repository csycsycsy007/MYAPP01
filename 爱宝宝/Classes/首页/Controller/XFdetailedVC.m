//
//  XFdetailedVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/21.
//  Copyright © 2016年 PUHIM. All rights reserved.
//
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS


#import "XFdetailedVC.h"
#import "XFFirstVC.h"
#import "AFNetworking.h"
#import "XFdetailedMod.h"
#import "HSHTTPClient.h"
#import "MBProgressHUD+Ex.h"
#import "XFsendArticle.h"
//获取授权
#import "UMSocial.h"

#import "AppDelegate.h"
#import "XFhotBtnMod.h"
#import "XFartCommentMod.h"
#import "XFartCommentCell.h"
#import "MJRefresh.h"
#import "Masonry.h"

@interface XFdetailedVC ()<UIWebViewDelegate,UMSocialUIDelegate,UITableViewDelegate,UITableViewDataSource>
//@property (strong, nonatomic) UITextView *textV;
@property(nonatomic,strong) NSArray * modelList;
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic,strong) NSDictionary * dict1;
@property(nonatomic,strong) XFdetailedMod * mod;
@property(nonatomic,strong) XFhotBtnMod * hotMod;
@property(nonatomic,strong) NSArray * hotAr;

//获取数据之后要在回调里给标题赋值
@property(nonatomic,strong) UILabel * titleLab;
@property(nonatomic,strong) UILabel * timeLab;
@property(nonatomic,strong) UIButton * lookBtn;
@property(nonatomic,strong) UIButton * labBtn;
@property(nonatomic,copy) NSString * agreeBtn;
@property(nonatomic,copy) NSString * adviceBtn1Name;
@property(nonatomic,copy) NSString * adviceBtn2Name;
@property(nonatomic,copy) NSString * adviceBtn3Name;
@property(nonatomic,copy) NSString * adviceBtn4Name;
@property(nonatomic,copy) NSString * adviceBtn1Url;
@property(nonatomic,copy) NSString * adviceBtn2Url;
@property(nonatomic,copy) NSString * adviceBtn3Url;
@property(nonatomic,copy) NSString * adviceBtn4Url;

@property(nonatomic,strong) UIButton * adviceBtn1;
@property(nonatomic,strong) UIButton * adviceBtn2;
@property(nonatomic,strong) UIButton * adviceBtn3;
@property(nonatomic,strong) UIButton * adviceBtn4;



@property(nonatomic,strong) UITableView * tabV;
@property(nonatomic,strong) NSMutableArray * modelArray;

@end

@implementation XFdetailedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebView];
    [self setUpComment];
    [self loaddata1];
    
    self.tabV.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tabV.mj_header.automaticallyChangeAlpha = YES;

}
//加载评论数据
-(void)loadMoreData {
    
}


- (void)setUpHeadView {
    // 添加头部视图
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, -100, [UIScreen mainScreen].bounds.size.width, 100)];
    
    view.backgroundColor = [UIColor  whiteColor];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 50)];
    
    lab.font = [UIFont boldSystemFontOfSize:18];
    lab.text = @"月经提前怎么回事?月经提前的食疗方法s";
    lab.numberOfLines = 0;
    self.titleLab = lab;
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 180, 20)];
    
    time.text = @"2016-2-15";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 80, 120, 20)];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:@"yj"] forState:UIControlStateNormal];
    
    [btn setTitle:@"2312" forState:UIControlStateNormal];
    self.timeLab = time;
    self.lookBtn = btn;
    
    [view addSubview:lab];
    [view addSubview:time];
    [view addSubview:btn];
    
    
    
    [self.webView.scrollView addSubview:view];
    
}

#pragma mark 监听 webview 的 contentsize
- (void)addObserverForWebViewContentSize{
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:0 context:nil];
}
- (void)removeObserverForWebViewContentSize{
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //在这里边添加你的代码
//    [self layoutCell];
//        NSLog(@"--------------%lf----------?---------",self.webView.scrollView.contentSize.height);
    
}
//并未使用此方法
- (void)layoutCell{
    //取消监听，因为这里会调整contentSize，避免无限递归
    [self removeObserverForWebViewContentSize];
//    UIView *viewss = [self.view viewWithTag:99999];
    CGSize contentSize = self.webView.scrollView.contentSize;
    UIView *vi = [[UIView alloc]init];
    vi.backgroundColor = [UIColor whiteColor];
    vi.userInteractionEnabled = YES;
    vi.tag = 99999;
    vi.frame = CGRectMake(0, contentSize.height, 300, 150);
    [self.webView.scrollView addSubview:vi];
    self.webView.scrollView.contentSize = CGSizeMake(contentSize.width, contentSize.height + 150);
    //重新监听
    [self addObserverForWebViewContentSize];
}

//创建底部视图
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //网页加载完成调用此方法
    [self addObserverForWebViewContentSize];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        NSLog(@"--------------%lf-------------------",self.webView.scrollView.contentSize.height);
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.webView.scrollView.contentSize.height, [UIScreen mainScreen].bounds.size.width, 550)];
        view.backgroundColor = [UIColor whiteColor];
        
        //创建底部视图里的子控件
        //分割线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(5, 55, ([UIScreen mainScreen].bounds.size.width - 10), 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        //标签按钮
        UIButton *labBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 30, 150, 20)];
        [labBtn setImage:[UIImage imageNamed:@"bq2"] forState:UIControlStateNormal];
        [labBtn setTitle:@"大姨妈,饮食健康" forState: UIControlStateNormal];
        [labBtn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        labBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        labBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        //点赞按钮
        UIButton *agreeBtn = [[UIButton alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 80), 30, 80, 20)];
        [agreeBtn setImage:[UIImage imageNamed:@"zz"] forState:UIControlStateNormal];
        [agreeBtn setImage:[UIImage imageNamed:@"z"] forState:UIControlStateSelected];
        [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [agreeBtn setTitle:self.agreeBtn forState:UIControlStateNormal];
        [agreeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
 
        
        //精彩推荐
        UILabel *labJingcai = [[UILabel alloc]initWithFrame:CGRectMake(5, 60, 70, 30)];
        labJingcai.text = @"精彩推荐";
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(5, 90, 70, 2)];
        line2.backgroundColor = [UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0];
        
        
        //推荐文章部分
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 95, [UIScreen mainScreen].bounds.size.width, 50)];
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 145, [UIScreen mainScreen].bounds.size.width, 50)];
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(0, 195, [UIScreen mainScreen].bounds.size.width, 50)];
        UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(0, 245, [UIScreen mainScreen].bounds.size.width, 50)];
        
        //btn和 self.btn 练习起来
        btn1.titleLabel.font = [UIFont systemFontOfSize:15];
        btn3.titleLabel.font = [UIFont systemFontOfSize:15];
        btn2.titleLabel.font = [UIFont systemFontOfSize:15];
        btn4.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [btn1 setTitle:self.adviceBtn1Name forState: UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn1.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [btn2 setTitle:self.adviceBtn2Name forState: UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn2.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn2.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [btn3 setTitle:self.adviceBtn3Name forState: UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn3.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [btn4 setTitle:self.adviceBtn4Name forState: UIControlStateNormal];
        [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn4.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn4.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn4.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        [btn1 setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
        [btn2 setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
        [btn3 setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
        [btn4 setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
       
        self.adviceBtn1 = btn1;
        self.adviceBtn2 = btn2;
        self.adviceBtn3 = btn3;
        self.adviceBtn4 = btn4;
        
        [btn1 addTarget:self action:@selector(advicebtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(advicebtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(advicebtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn4 addTarget:self action:@selector(advicebtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //tableview^
        
        UITableView *tb = [[UITableView alloc]init];
        tb.delegate = self;
        tb.dataSource = self;
        tb.rowHeight = 110;
        self.tabV = tb;
        tb.separatorStyle = NO;

        //全部评论
        UILabel * labAllComment = [[UILabel alloc]initWithFrame:CGRectMake(5, 300, 70, 30)];
        labAllComment.text = @"全部评论";
        UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(5, 330, 70, 2)];
        line3.backgroundColor = [UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0];
        
        [tb makeConstraints:^(MASConstraintMaker *make) {
            //        make.left.equalTo(self.view).offset(12);
            make.width.equalTo(self.view.bounds.size.width);
            make.top.equalTo(line3).offset(5);
            make.bottom.equalTo(view).offset(5);
        }];

        
        
        //文章的分割线
        [view addSubview:labAllComment];
        [view addSubview:line3];
        [view addSubview:btn1];
        [view addSubview:btn2];
        [view addSubview:btn3];
        [view addSubview:btn4];
        [view addSubview:labJingcai];
        [view addSubview:line2];
        [view addSubview:labBtn];
        [view addSubview:line];
        [view addSubview:agreeBtn];
        [view addSubview:tb];
        [self.webView.scrollView addSubview:view];
        
        [self removeObserverForWebViewContentSize];
        
    });

}
#pragma mark ----------推荐按钮点击事件
-(void)advicebtnClick:(UIButton *)btn {
    
    XFdetailedVC *vc = [[XFdetailedVC alloc]init];
    if (btn == self.adviceBtn1) {
        vc.article_id =self.adviceBtn1Url;
    } else if (btn == self.adviceBtn2 ){
        vc.article_id = self.adviceBtn2Url;
    } else if (btn ==self.adviceBtn3) {
        vc.article_id = self.adviceBtn3Url;
    } else {
        vc.article_id = self.adviceBtn4Url;
    }
    

    [self.navigationController pushViewController:vc animated:YES ];
    
}


#pragma mark __tableview数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFartCommentCell *cell =  [XFartCommentCell cellWithTableview:tableView];
    
    if (self.modelArray) {
        
        cell.cellModel = self.modelArray[indexPath.row];
        
        //        NSLog(@"cell.cellModel =  %@",cell.cellModel);
        
        cell.commentLab.text = cell.cellModel.comment_content;
        
        
        cell.nameLab.text = cell.cellModel.comment_name;
        cell.timeLab.text = cell.cellModel.comment_time;
        //        cell.floorLab.text = cell.cellModel.cirle_floor;
        //        cell.contentLab.text = @"23423";
        //        cell.nameLab.text = @"name";
//        cell.timeLab.text = cell.cellModel.cirle_time;
        
        NSString *st = [NSString stringWithFormat:@"%zd楼",cell.cellModel.comment_floor];
        cell.floorLab.text = st;
        
        
        
        //        cell.contentLab.text = cell.cellModel.cirle_content;
        //        NSLog(@"");
        
    }

    
    return cell;
}


/*
 接口路径：http://ma.beidaivf04.com/admin.php/Comment/article_love
 传值方式：GET 参数 id=文章编号 name=用户名
 返回值：赞过了则返回”已赞” 没赞过并添加成功则返回”成功” 没赞过并添加失败则返回”失败”
// 点赞按钮的点击事件  */
-(void)agreeBtnClick:(UIButton *)btn{
    
    
    
    AppDelegate *ap = [[UIApplication sharedApplication]delegate];
    
    NSString *str1 = [NSString stringWithFormat:@"id=%@&name=%@",self.article_id,ap.idNumber];
    
    NSString *URLString = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Comment/article_love?%@",str1];
    
    [HSHTTPClient request:GET URLString:URLString parameters:nil success:^(id json) {
        
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [MBProgressHUD showSuccess:@"点赞已生效" toView:self.navigationController.view];

    
    if (btn.selected ==NO) {
        btn.selected = YES;
    }
}
//创建底部评论&转发
- (void)setUpComment {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,  ([UIScreen mainScreen].bounds.size.height)-50, [UIScreen mainScreen].bounds.size.width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:view];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(5, 5 , 180 ,40 )];
    
    btn.layer.cornerRadius = 10.f;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = .2f;
    btn.layer.borderColor = [[UIColor blackColor]CGColor];
    
    
//    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"我要评论" forState: UIControlStateNormal];
    
    [btn addTarget:self action:@selector(poCommentClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    float a = [UIScreen mainScreen].bounds.size.width;
    
    // 190
    
    UIButton *star = [[UIButton alloc]initWithFrame:CGRectMake( 190 , 5, 40, 40)];
    UIButton *comment = [[UIButton alloc]initWithFrame:CGRectMake(190+40 + ((a-190-15-120)/2), 5, 40, 40)];
    UIButton *share = [[UIButton alloc]initWithFrame:CGRectMake(a - 40 - 10, 5, 40, 40)];
    
    
    [star setImage:[UIImage imageNamed:@"shoucangh"] forState:UIControlStateNormal];
    [star setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
    [comment setImage:[UIImage imageNamed:@"xt"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"zf"] forState:UIControlStateNormal];
    
    [view addSubview:star];
    [view addSubview:comment];
    [view addSubview:share];
    
    [star addTarget:self action:@selector(starBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [comment addTarget:self action:@selector(poCommentClick) forControlEvents:UIControlEventTouchUpInside];
    [share addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
//转发按钮点击事件
-(void)shareBtnClick {
    
    NSString *str = [NSString stringWithFormat:@"欢迎使用爱宝宝 %@",self.App_url];
    //如果需要分享回调，请将delegate对象设置self，并实现下面的回调方法
    
    [UMSocialData defaultData].extConfig.title = @"分享的哈哈哈哈哈哈";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57aed1e667e58ed22a00351d"
                                      shareText:str
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToDouban]
                                       delegate:self];}
//收藏按钮点击事件
-(void)starBtnClick:(UIButton *)btn {
    if (btn.selected == NO) {
        btn.selected = YES;
    }else {
        btn.selected = NO;
    }
}

//发送按钮点击事件
-(void)poCommentClick {
    
    XFsendArticle *send = [[XFsendArticle alloc]init];
    send.artID = self.article_id;
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:send animated:YES];
    self.hidesBottomBarWhenPushed=YES;
}

- (void)setUpWebView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height)-50 )];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.opaque = NO;
    
    //添加 webview 的滚动范围
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 500, 0);
    
    [self setUpHeadView];
//    [self setUpFooterView];  //加载尾部视图
    [self.view addSubview:self.webView];
    
    //    id = 22  name = 18640959557
    NSString * URLString = @"http://ma.beidaivf04.com/admin.php/Index/article_content";
    
    
    AppDelegate *ap = [[UIApplication sharedApplication]delegate];
    
    NSString *idNum = ap.idNumber;

    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:self.article_id,@"id",idNum,@"name", nil];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    [HSHTTPClient request:GET URLString:URLString parameters:dict success:^(id json) {
//        NSLog(@"%@",(NSDictionary *)json);
        self.dict1 = json;
        //注意:加载完成数据之后再去给控件赋值
//        NSLog(@"%@",self.dict1[@"article_content"]);
        
        NSString *url = [NSString stringWithFormat:@"<head><style>img{max-width:320px !important;}</style></head>%@",self.dict1[@"article_content"]];
        
        [_webView loadHTMLString:url baseURL:nil];

        XFdetailedMod *mod = [XFdetailedMod initDetModWith:self.dict1];
        
        self.mod = mod;
        
        [self.titleLab setText:self.mod.article_title];
        [self.timeLab setText:self.mod.article_time];
        [self.lookBtn setTitle:self.mod.article_look forState:UIControlStateNormal ];
        [self.labBtn setTitle:self.mod.article_type forState:UIControlStateNormal];
        
        self.agreeBtn = self.mod.article_love;
        
        
        NSMutableArray *mR = [NSMutableArray arrayWithCapacity:self.mod.hot.count];
        
        [self.mod.hot enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XFhotBtnMod *md = [XFhotBtnMod initHotModWith:obj];
            
            if (idx == 0 ) {
//                [self.adviceBtn1Name setTitle:md.hot_title forState:UIControlStateNormal];
                self.adviceBtn1Name = md.hot_title;
                self.adviceBtn1Url = md.hot_url;
                NSLog(@"___%@____",md.hot_url);
            } else if (idx == 1) {
//                [self.adviceBtn2Name setTitle:md.hot_title forState:UIControlStateNormal];
                self.adviceBtn2Name = md.hot_title;
                self.adviceBtn2Url = md.hot_url;
                                NSLog(@"___%@_____",md.hot_url);
            } else if (idx == 2) {
//                [self.adviceBtn3Name setTitle:md.hot_title forState:UIControlStateNormal];
                                NSLog(@"____3_%@_____",md.hot_url);
                self.adviceBtn3Name = md.hot_title;
                self.adviceBtn3Url = md.hot_url;
            } else {
//                [self.adviceBtn4Name setTitle:md.hot_title forState:UIControlStateNormal];
                                NSLog(@"_____4____%@_____",md.hot_url);
                self.adviceBtn4Name = md.hot_title;
                self.adviceBtn4Url = md.hot_url;
            }
            
            [mR addObject:md];
        }];


        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

-(NSDictionary *)dict1{
    if(_dict1 == nil){
        _dict1 = [[NSDictionary alloc]init];
    }
    return _dict1;
}


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loaddata1
{
    /*
     接口路径：http://ma.beidaivf04.com/admin.php/Index/article_comment
     传值方式：GET 参数 page=分页 id=文章编号
     */
    NSString *URLString = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/article_comment?page=1&id=%@",self.article_id];
    
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
                XFartCommentMod   *news = [XFartCommentMod initCommentModWith:obj];
    
                [tmpM addObject:news];
            }];
            
            // 什么时候数据加载完,就什么时候给数据源数组赋值
            
            self.modelArray = tmpM.copy;
            // 数据源数组什么时候有值,就什么时候刷新列表
            [self.tabV reloadData];
            
        } else {
            NSLog(@"%@",connectionError);
        }
    }];
}


#pragma mark - Navigation

@end
