//
//  XFFirstVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/13.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFFirstVC.h"
#import "WZCImagePlayView.h"
#import "XFtableOne.h"
#import "XFdetailedVC.h"

#import "XFverturCell.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
#import "XFbannerImage.h"
#import "UIImageView+WebCache.h"
#import "HSHTTPClient.h"
#import "XFhotTopicModel.h"
#import "AppDelegate.h"
//#import "XFlabSelectVC.h"
#import "XFverCellVC.h"
#import "XFdetailedCircle.h"
//#import "XFdetailedVC.h"


@interface XFFirstVC ()<UISearchBarDelegate,WZCImagePlayViewDelegate, UITableViewDelegate, UITableViewDataSource>

//声明一个首页的scrollview
@property(nonatomic,strong) UIScrollView * scrollView;
//声明轮播器的图片数组
@property (nonatomic,strong) NSArray *imagesP;
//声明 tableview 1 今日推荐
@property(nonatomic,weak) UITableView * tableOne;
//热门话题
//@property(nonatomic,weak) UITableView * tableTwo;
////备孕科普
//@property(nonatomic,weak) UITableView * tableThree;

@property (nonatomic, strong) NSArray *cellsList;

//声明一个滚动按钮区域
@property(nonatomic,strong) UIScrollView * hScrollView;

//按钮区
@property(nonatomic,weak) UIButton* byBtn;
@property(nonatomic,weak) UILabel* byLab;
@property(nonatomic,weak) UIButton* hyBtn;
@property(nonatomic,weak) UILabel* hyLab;
@property(nonatomic,weak) UIButton* sgyeBtn;
@property(nonatomic,weak) UILabel* sgyeLab;
@property(nonatomic,weak) UIButton* dymBtn;
@property(nonatomic,weak) UILabel* dymLab;
@property(nonatomic,weak) UIButton* yeBtn;
@property(nonatomic,weak) UILabel* yeLab;
//@property(nonatomic,weak) UIButton* byBtn;
//@property(nonatomic,weak) UILabel* byLab;

@property(nonatomic,weak) UIButton *hotBtn1;
@property(nonatomic,weak) UIButton *hotBtn2;
@property(nonatomic,weak) UIButton *hotBtn3;
@property(nonatomic,weak) UIButton *hotBtn4;

@property(nonatomic,copy) NSString *htID1;
@property(nonatomic,copy) NSString *htID2;
@property(nonatomic,copy) NSString *htID3;
@property(nonatomic,copy) NSString *htID4;


@property(nonatomic,weak) UISearchBar *sbBar;
@property (nonatomic, strong) NSOperationQueue *queue;
//自定义下拉加载
@property(nonatomic,strong) UIActivityIndicatorView * indicatorView;
@property(nonatomic,strong) UILabel * pullRefreshLabel;


@property(nonatomic,assign) CGFloat keyboardHeight;

//编辑状态下的蒙板
@property(nonatomic,strong) UIView * mengbanV;

@end

@implementation XFFirstVC


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

//    [self imagesP];
    
//    [self cellsList];
    [self setUpSearchbar];
    [self setUpLayout];
    [self loadTable];
    [self loadHotTopic];
    [self loadCellData];
    
    [self registerForKeyboardNotifications];
    
    
}

-(void)WZCImagePlayViewImageDidClickWithImageView:(UIImageView *)imageView arrayIndex:(NSInteger)idx {
    
    
//    NSLog(@"按了%zd",idx);
    
    
}


-(NSArray *)imagesP
{
    
    // 1.创建网络请求呢管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *domainStr = @"http://ma.beidaivf04.com/index.php/Home/Cirle/banner";
    
    [manager GET:domainStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
       
        NSArray *result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        
        NSLog(@"%@",result);
        
        // 定义一个可变数组
        NSMutableArray *tmpM =[NSMutableArray arrayWithCapacity:result.count];
        
        NSMutableArray *imageM = [[NSMutableArray alloc]init];
        // 遍历字典数组,取出字典,实现字典转模型
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XFbannerImage *ban = [XFbannerImage initBannerWithDict:obj];
            
            [tmpM addObject:ban];
            

            [imageM addObject:ban.banner];
            
        }];
        
        
        _imagesP = [imageM copy];
        
//        NSLog(@"_imagesP = %@",_imagesP);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];

    
    return _imagesP;

}

- (void)imageViewStartPlay
{
    
//    [self imagesP];
    float a = [UIScreen mainScreen].bounds.size.width;
    if (a <= 375) {
        WZCImagePlayView *imagePlay = [[WZCImagePlayView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) imagesUrlString:@[@"http://ma.beidaivf04.com/images/banner/banner1.jpg",
                                                                                                                                                @"http://ma.beidaivf04.com/images/banner/banner2.jpg",
                                                                                                                                                              
                                                                                                                                                              @"http://ma.beidaivf04.com/images/banner/banner3.jpg"]
                                                            placeholderImage:[UIImage imageNamed:@"lbt1"]];
        
        imagePlay.wzc_image_delegate = self;
        imagePlay.wzc_intervalTime = 1.8;
        imagePlay.wzc_resetTime = 2.0;
        imagePlay.wzc_imageViewContentMode = 0;
        imagePlay.wzc_pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        imagePlay.backgroundColor = [UIColor blackColor];
        [self.scrollView addSubview:imagePlay];
        [imagePlay wzc_imagesBeginWorking];
    } else if (a > 375) {
        WZCImagePlayView *imagePlay = [[WZCImagePlayView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 190)  imagesUrlString:@[@"http://ma.beidaivf04.com/images/banner/banner1.jpg",
                                                                                                                                                               @"http://ma.beidaivf04.com/images/banner/banner2.jpg",
                                                                                                                                                               
                                                                                                                                                               @"http://ma.beidaivf04.com/images/banner/banner3.jpg"]
                                                            placeholderImage:[UIImage imageNamed:@"lbt1"]];
        imagePlay.wzc_image_delegate = self;
        imagePlay.wzc_intervalTime = 1.0;
        imagePlay.wzc_resetTime = 2.0;
        imagePlay.wzc_imageViewContentMode = 0;
        imagePlay.wzc_pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        imagePlay.backgroundColor = [UIColor blackColor];
        [self.scrollView addSubview:imagePlay];
        [imagePlay wzc_imagesBeginWorking];

    }
    
}


//搜索栏
- (void)setUpSearchbar
{
    //(50,20,UIscreen-50,40)
    
    UISearchBar *sb = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [self.view addSubview:sb];
    self.sbBar = sb;
    self.sbBar.delegate = self;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 20, 40, 40)];
//    [btn setBackgroundColor:[UIColor magentaColor]];
    [btn setImage:[UIImage imageNamed:@"xxtx"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    //点击搜索栏之后如何取消编辑状态
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    [self.mengbanV addGestureRecognizer:tap];
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:0.2 animations:^{
        
        [self.mengbanV removeFromSuperview];
        self.mengbanV = nil;
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view endEditing:YES];
}


- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    self.keyboardHeight = keyboardSize.height;
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    ///keyboardWasShown = YES;
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    // keyboardWasShown = NO;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.mengbanV = [[UIView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60 - self.keyboardHeight)];
        [self.view addSubview:self.mengbanV];
        self.mengbanV.alpha = 0.2;
        _mengbanV.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        
    }];
    
    // 点击搜索栏之后如何取消编辑状态
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    
    [_mengbanV addGestureRecognizer:tap];
    
}


//整体Scrollview
- (void)setUpLayout
{
    float a = [UIScreen mainScreen].bounds.size.width;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 104)];
    if (a <= 375) {
        self.scrollView.contentSize = CGSizeMake(0, 2470);
    } else {
        self.scrollView.contentSize = CGSizeMake(0, 3010);
    }
    
    

    self.scrollView.scrollsToTop = NO;

    
    //添加轮播器
    [self imageViewStartPlay];
    
    [self.view addSubview:self.scrollView];
    
    
    //按钮区  scrollView
    if (a <=375) {
        self.hScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 150, a, 110)];
    } else {
        
        self.hScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 190 , a, 110)];
    }
    int b = 5;
    
    self.hScrollView.contentSize = CGSizeMake(40+60*b+(b-1)*30, 0);
    
    [self.hScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self.scrollView addSubview:self.hScrollView];
    
    // #pragma 当前关闭滚动功能
//    self.hScrollView.scrollEnabled = NO;
    
    
    //代码,按钮区
    
    NSArray *titleName = @[@"备孕",@"怀孕",@"试管婴儿",@"大姨妈",@"育儿"];
    NSArray *iconName = @[@"by",@"hy",@"sgye",@"dym",@"ye"];
    
    for (int i = 0; i<5; i++) {
        
        
        UIButton *btn = [[UIButton alloc]init];
        
        btn.frame = CGRectMake(20+i*90, 10, 60, 60);
        
        [btn setImage:[UIImage imageNamed:iconName[i]] forState:UIControlStateNormal];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20+i*90, 80, 60, 20)];
        lab.font = [UIFont systemFontOfSize:14];
        [lab setText:titleName[i]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [self.hScrollView addSubview:lab];
        [self.hScrollView addSubview:btn];
        
        btn.tag = i;
        
        if (i ==0) {
            [btn addTarget:self action:@selector(labBtn1Click) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 1){
            [btn addTarget:self action:@selector(labBtn2Click) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 2) {
            [btn addTarget:self action:@selector(labBtn3Click) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 3) {
            [btn addTarget:self action:@selector(labBtn4Click) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [btn addTarget:self action:@selector(labBtn5Click) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }

    //标签条
    if (a <= 375) {
        //330
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 260, a, 10)];
        
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        
        [self.scrollView addSubview:line];
        
    } else {

        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 300, a, 10)];
        
//        line.backgroundColor =  [UIColor colorWithRed:200 green:220 blue:223 alpha:1.0];

        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.scrollView addSubview:line];
    }
    
    if (a <= 375) {
        UIImageView *iconV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 280, 20, 20)];
        iconV.image = [UIImage imageNamed:@"tb"];
        
        [self.scrollView addSubview:iconV];
        //label热门话题
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 280, 100, 20)];
        [lab setText:@"热门话题"];
        [self.scrollView addSubview:lab];

    } else {
        UIImageView *iconV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 320, 20, 20)];
        iconV.image = [UIImage imageNamed:@"tb"];
        [self.scrollView addSubview:iconV];

        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 320, 100, 20)];

        [lab setText:@"热门话题"];
        [self.scrollView addSubview:lab];
        
    }
    
    if (a<=375) {
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 310, a/2 - 30, 40)];
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(a/2 +10, 310, a/2 - 30, 40)];
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(20, 370, a/2 - 30, 40)];
        UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(a/2 +10, 370, a/2 - 30, 40)];
       
        [btn1 setTitle:@"泰国试管婴儿胎停再战" forState: UIControlStateNormal];
        [btn2 setTitle:@"balabal" forState:UIControlStateNormal];
        [btn3 setTitle:@"aaaaaaaaaaa" forState:UIControlStateNormal];
        [btn4 setTitle:@"sxxxxx" forState:UIControlStateNormal];
        
        btn1.titleLabel.numberOfLines = 2;
        btn2.titleLabel.numberOfLines = 2;
        btn3.titleLabel.numberOfLines = 2;
        btn4.titleLabel.numberOfLines = 2;
        
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        btn2.titleLabel.font = [UIFont systemFontOfSize:14];
        btn3.titleLabel.font = [UIFont systemFontOfSize:14];
        btn4.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn1.layer.borderWidth = 0.2f;
        btn2.layer.borderWidth = 0.2f;
        btn3.layer.borderWidth = 0.2f;
        btn4.layer.borderWidth = 0.2f;
        
        btn1.layer.cornerRadius = 5;
        btn2.layer.cornerRadius = 5;
        btn3.layer.cornerRadius = 5;
        btn4.layer.cornerRadius = 5;
        //添加点击事件
        [btn1 addTarget:self action:@selector(hotBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [btn2 addTarget:self action:@selector(hotBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [btn3 addTarget:self action:@selector(hotBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [btn4 addTarget:self action:@selector(hotBtn1Click:) forControlEvents:UIControlEventTouchUpInside];
        
        self.hotBtn1 = btn1;
        self.hotBtn2 = btn2;
        self.hotBtn3 = btn3;
        self.hotBtn4 = btn4;
        
        
        
        [self.scrollView addSubview:self.hotBtn1];
        [self.scrollView addSubview:self.hotBtn2];
        [self.scrollView addSubview:self.hotBtn3];
        [self.scrollView addSubview:self.hotBtn4];
        
        
    } else {
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 350, a/2 - 30, 40)];
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(a/2 +10, 350, a/2 - 30, 40)];
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(20, 410, a/2 - 30, 40)];
        UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(a/2 +10, 410, a/2 - 30, 40)];
        [btn1 setTitle:@"泰国试管婴儿胎停再战" forState: UIControlStateNormal];
        [btn2 setTitle:@"balabal" forState:UIControlStateNormal];
        [btn3 setTitle:@"aaaaaaaaaaa" forState:UIControlStateNormal];
        [btn4 setTitle:@"sxxxxx" forState:UIControlStateNormal];

        btn1.titleLabel.numberOfLines = 0;
        btn2.titleLabel.numberOfLines = 0;
        btn3.titleLabel.numberOfLines = 0;
        btn4.titleLabel.numberOfLines = 0;

        
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        btn2.titleLabel.font = [UIFont systemFontOfSize:14];
        btn3.titleLabel.font = [UIFont systemFontOfSize:14];
        btn4.titleLabel.font = [UIFont systemFontOfSize:14];
        
        btn1.layer.borderWidth = 0.2f;
        btn2.layer.borderWidth = 0.2f;
        btn3.layer.borderWidth = 0.2f;
        btn4.layer.borderWidth = 0.2f;
        
        btn1.layer.cornerRadius = 5;
        btn2.layer.cornerRadius = 5;
        btn3.layer.cornerRadius = 5;
        btn4.layer.cornerRadius = 5;

        
        self.hotBtn1 = btn1;
        self.hotBtn2 = btn2;
        self.hotBtn3 = btn3;
        self.hotBtn4 = btn4;
        
        [self.scrollView addSubview:self.hotBtn1];
        [self.scrollView addSubview:self.hotBtn2];
        [self.scrollView addSubview:self.hotBtn3];
        [self.scrollView addSubview:self.hotBtn4];

    }

    
    if (a<=375) {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 430, 20, 20)];
        imgV.image = [UIImage imageNamed:@"tb"];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 430, 120, 20)];
        
        [lab setText:@"爱宝宝精选"];
        
        [self.scrollView addSubview:lab];
        [self.scrollView addSubview:imgV];
   
    }  else {
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 470, 20, 20)];
        imgV.image = [UIImage imageNamed:@"tb"];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(50, 470, 120, 20)];
        
        [lab setText:@"爱宝宝精选"];
        
        [self.scrollView addSubview:lab];
        [self.scrollView addSubview:imgV];

    }
    
    
    self.indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, -25, 20, 20)];
    [self.indicatorView setColor:[UIColor blackColor]];
    self.pullRefreshLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 -20, -30, 90, 30)];
    self.pullRefreshLabel.font = [UIFont fontWithName:@"heiti SC" size:14];
    [self.pullRefreshLabel setText:@"下拉刷新"];
    [self.scrollView addSubview:self.indicatorView];
    [self.scrollView addSubview:self.pullRefreshLabel];
    [self.scrollView bringSubviewToFront:self.indicatorView];
    [self.scrollView bringSubviewToFront:self.pullRefreshLabel];

    
    
}
//首页的标签选项
- (void)labBtn1Click {
    
    XFverCellVC *vc = [[XFverCellVC  alloc]init];
    vc.pagE = 1;
    vc.typE = @"备孕";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)labBtn2Click {
    
    XFverCellVC *vc = [[XFverCellVC  alloc]init];
    
    vc.typE = @"怀孕";
    vc.pagE = 1;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)labBtn3Click {
    
    XFverCellVC *vc = [[XFverCellVC  alloc]init];
    
    vc.typE = @"试管婴儿";
    vc.pagE = 1;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)labBtn4Click {
    
    XFverCellVC *vc = [[XFverCellVC  alloc]init];
    vc.pagE = 1;
    vc.typE = @"大姨妈";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)labBtn5Click {
    
    XFverCellVC *vc = [[XFverCellVC  alloc]init];
    vc.pagE = 1;
    vc.typE = @"育儿";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark _____hotBtnClick:
-(void)hotBtn1Click: (UIButton *)btn {
    
    XFdetailedCircle *dtVC = [[XFdetailedCircle alloc]init];
    
    dtVC.cirle_id = self.htID1;
    dtVC.cirle_title = btn.titleLabel.text;
    dtVC.pagE = 1;

    
    [self.navigationController pushViewController:dtVC animated:YES];
}
-(void)hotBtn2Click: (UIButton *)btn {
    
    XFdetailedCircle *dtVC = [[XFdetailedCircle alloc]init];
    
        dtVC.cirle_id = self.htID2;
    dtVC.cirle_title = btn.titleLabel.text;
    dtVC.pagE = 1;
    
    
    [self.navigationController pushViewController:dtVC animated:YES];
}
-(void)hotBtn3Click: (UIButton *)btn {
    
    XFdetailedCircle *dtVC = [[XFdetailedCircle alloc]init];
    
        dtVC.cirle_id = self.htID3;
    dtVC.cirle_title = btn.titleLabel.text;
    dtVC.pagE = 1;
    
    
    [self.navigationController pushViewController:dtVC animated:YES];
}
-(void)hotBtn4Click: (UIButton *)btn {
    
    XFdetailedCircle *dtVC = [[XFdetailedCircle alloc]init];
    
        dtVC.cirle_id = self.htID4;
    dtVC.cirle_title = btn.titleLabel.text;
    dtVC.pagE = 1;
    
    
    [self.navigationController pushViewController:dtVC animated:YES];
}

-(void)loadHotTopic {
    
    [HSHTTPClient request:GET URLString:@"http://ma.beidaivf04.com/admin.php/Index/hot_forum" parameters:nil success:^(id json) {
        //        NSLog(@"%@",json);
        NSArray * arr = (NSArray *)json;
        NSMutableArray * tempArr = [NSMutableArray arrayWithCapacity:arr.count];
        
        [arr enumerateObjectsUsingBlock:^(NSDictionary * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSLog(@"%@",obj);
            //此处进行字典转模型
            XFhotTopicModel *htMod = [XFhotTopicModel inithotTopWithDict:obj];
            
//            XFdetailedVC *vc = [[XFdetailedVC alloc]init];
            
            
            
            [tempArr addObject:htMod];
            if (idx == 0) {
                [self.hotBtn1 setTitle:htMod.forum_title forState:UIControlStateNormal];
                self.htID1 = htMod.forum_id;
                
            } else if (idx == 1) {
                [self.hotBtn2 setTitle:htMod.forum_title forState:UIControlStateNormal];
                                self.htID2 = htMod.forum_id;
            } else if (idx == 2) {
                [self.hotBtn3 setTitle:htMod.forum_title forState:UIControlStateNormal];
                                self.htID3 = htMod.forum_id;
            } else {
                [self.hotBtn4 setTitle:htMod.forum_title forState:UIControlStateNormal];
                                self.htID4 = htMod.forum_id;
            }
        }];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);        
    }];
}




- (void)loadTable{
    
    float a = [UIScreen mainScreen].bounds.size.width;
    
    if (a<=375) {
        UITableView *tab1 = [[UITableView alloc]initWithFrame:CGRectMake(20, 470, a - 40, 2000)];
        self.tableOne = tab1;
        [self.scrollView addSubview:self.tableOne];
        self.tableOne.delegate = self;
        self.tableOne.dataSource = self;
        
        self.tableOne.rowHeight = 200;
        self.tableOne.scrollEnabled = NO;
        
    } else {
        
        UITableView *tab1 = [[UITableView alloc]initWithFrame:CGRectMake(20, 510, a - 40, 2500)];
        self.tableOne = tab1;
        [self.scrollView addSubview:self.tableOne];
        self.tableOne.delegate = self;
        self.tableOne.dataSource = self;
        
        self.tableOne.rowHeight = 250;
        self.tableOne.scrollEnabled = NO;
        
    }
    
    
}



//数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    return self.cellsList.count;
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {




    
    
    XFverturCell *cell = [XFverturCell cellWithTableview:tableView];
    
    XFverCellMod *mod = self.cellsList[indexPath.row];
    
    
//    NSLog(@"%zd ____ %@",indexPath.row,mod.id);
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        // 下载图片 : 耗时操作
        NSURL *url = [NSURL URLWithString:mod.article_images];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        // 图片下载完后曾只有,需要刷新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 赋值
            cell.article_image.image = image;
        }];
    }];
    
    // 把下载操作添加到队列
    [self.queue addOperation:op];

//    AppDelegate *ap = [[UIApplication sharedApplication]delegate];
    
    cell.verMod = mod;
        
//    NSLog(@"%@",ap.idNumber);
    
        
    return cell;
}
- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"%zd",indexPath.row);
    XFdetailedVC *vc = [[XFdetailedVC alloc]init];

    XFverCellMod *mod = self.cellsList[indexPath.row];
    vc.article_id = mod.article_id;
    NSLog(@"%@",vc.article_id);
    //取消 cell 的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
    //设置 push 后隐藏 tabbar 和返回时候显示 tabbar
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES ];
    self.hidesBottomBarWhenPushed=NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
        self.tabBarController.tabBar.hidden = NO ;
}



-(void)loadCellData {
    
        // URL
        NSString *URLString = @"http://ma.beidaivf04.com/admin.php/Index/hot_article?page=1";
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
                
                // 定义一个可变数组
                NSMutableArray *tmpM =[NSMutableArray arrayWithCapacity:result.count];
                
                // 遍历字典数组,取出字典,实现字典转模型
                [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    XFverCellMod *news = [XFverCellMod  initVerWithDict:obj];
                    [tmpM addObject:news];
                }];
                
                // 什么时候数据加载完,就什么时候给数据源数组赋值
                self.cellsList = tmpM.copy;
                
                // 数据源数组什么时候有值,就什么时候刷新列表
                [self.tableOne reloadData]; //这个  很重要?
                
                
            } else {
                NSLog(@"%@",connectionError);
            }
        }];
    
    
}













@end
