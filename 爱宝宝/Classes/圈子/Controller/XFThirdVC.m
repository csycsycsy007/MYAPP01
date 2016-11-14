//
//  XFThirdVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/13.
//  Copyright © 2016年 PUHIM. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "XFThirdVC.h"
#import "WZCImagePlayView.h"
#import "Masonry.h"
#import "XFpicAndLab.h"
#import "XFthirdCell.h"
#import "XFpostVC.h"
#import "XFdetailedCircle.h"
#import "XFcercleCellModel.h"
#import "HSHTTPClient.h"


@interface XFThirdVC ()<UISearchBarDelegate,WZCImagePlayViewDelegate,UITableViewDataSource, UITableViewDelegate>
//图片轮播
@property (nonatomic,strong) NSArray *imagesP;
//button
@property(nonatomic,weak) UIButton * findBtn;
@property(nonatomic,weak) UIButton * hotBtn;
@property(nonatomic,weak) UIButton * videoBtn;
@property(nonatomic,weak) UIButton * knoBtn;

//声明一个首页的scrollview
@property(nonatomic,strong) UIScrollView * scrollView;
@property(nonatomic,strong) UIScrollView * hScrollView;

//按钮 全部,最新,热门,精华,求助
@property(nonatomic,weak) UIButton * allBtn;
@property(nonatomic,weak) UIButton * newwBtn;
@property(nonatomic,weak) UIButton * hotdoorBtn;
@property(nonatomic,weak) UIButton * classicBtn;
@property(nonatomic,weak) UIButton * helpBtn;
//table

//发帖按钮
@property(nonatomic,weak) UIButton * postBtn;

//模型数组
@property(nonatomic,strong) NSMutableArray *circleModels;

@property(nonatomic,strong) XFcercleCellModel * cirModel;

@property(nonatomic,strong) UITableView * table;

@property(nonatomic,assign) CGFloat keyboardHeight;
//编辑状态下的蒙板
@property(nonatomic,strong) UIView * mengbanV;

@end

@implementation XFThirdVC
static NSString *UUUrl = @"http://ma.beidaivf04.com/admin.php/Index/forum?page=1";
//懒加载
-(NSArray *)circleModels {
    
    if (_circleModels == nil) {
//        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"doctorInf.plist" ofType:nil]];
//        
//        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];

        
        
//        _circleModels = arrM;
        
    }
    return _circleModels;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpSearchbar];
    [self setUpLayout];
//    [self setUpButton];
    [self loadTable];
    [self registerForKeyboardNotifications];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 60, self.view.bounds.size.height - 100, 40, 40)];
    
    [btn setImage:[UIImage imageNamed:@"ft1"] forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    
    [self.view bringSubviewToFront:btn];
    
    [btn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(NSArray *)imagesP
{
    if (_imagesP) {
        return _imagesP;
    }
    
    _imagesP = @[
                 [UIImage imageNamed:@"lbt1"],
                 [UIImage imageNamed:@"lbt2"],
                 [UIImage imageNamed:@"image_03"],
                 [UIImage imageNamed:@"image_04"]
                 ];
    
    return _imagesP;
    
}
- (void)imageViewStartPlay
{
    float a = [UIScreen mainScreen].bounds.size.width;
    if (a <= 375) {
        WZCImagePlayView *imagePlay = [[WZCImagePlayView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140) imagesUrlString:@[@"http://ma.beidaivf04.com/cirle/images/1.jpg",
                                                                                                                                                              @"http://ma.beidaivf04.com/cirle/images/2.jpg",
                                                                                                                                                              
                                                                                                                                                              @"http://ma.beidaivf04.com/cirle/images/3.jpg"]
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
        WZCImagePlayView *imagePlay = [[WZCImagePlayView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 280) imagesUrlString:@[@"http://ma.beidaivf04.com/cirle/images/1.jpg",
                                                                                                                                                              @"http://ma.beidaivf04.com/cirle/images/2.jpg",
                                                                                                                                                              
                                                                                                                                                              @"http://ma.beidaivf04.com/cirle/images/3.jpg"]
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
//图片的点击事件
-(void)WZCImagePlayViewImageDidClickWithImageView:(UIImageView *)imageView arrayIndex:(NSInteger)idx {
    
    
    //    NSLog(@"按了%zd",idx);
    
    
}





//搜索栏
- (void)setUpSearchbar
{
    //(50,20,UIscreen-50,40)
    
    
    UISearchBar *sb = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width - 40, 40)];
    [self.view addSubview:sb];
    sb.delegate = self;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, 20, 40, 40)];
//    [btn setBackgroundColor:[UIColor magentaColor]];
    [btn setImage:[UIImage imageNamed:@"ft"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    self.postBtn = btn;
    [self.postBtn addTarget:self action:@selector(postBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
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


-(void)postBtnClick {
    
    XFpostVC *vc = [[XFpostVC alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)setUpLayout
{
    float a = [UIScreen mainScreen].bounds.size.width;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 104)];
    if (a <= 375) {
        self.scrollView.contentSize = CGSizeMake(0, 1020);
    } else {
        self.scrollView.contentSize = CGSizeMake(0, 1160);
    }
    
    
    
    self.scrollView.scrollsToTop = NO;
    self.scrollView.bounces = NO;
    
    //添加轮播器
    [self imageViewStartPlay];
    
    [self.view addSubview:self.scrollView];
    
    
    //按钮区  scrollView
    if (a <=375) {
        self.hScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 140, a, 110)];
    } else {
        
        self.hScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 280 , a, 110)];
    }
    int b = 5;
    
    self.hScrollView.contentSize = CGSizeMake(40+60*b+(b-1)*30, 0);
    
    [self.hScrollView setShowsHorizontalScrollIndicator:NO];
    
    [self.scrollView addSubview:self.hScrollView];
    
    //关闭滚动
    self.hScrollView.scrollEnabled = NO;
    
    //代码,按钮区
    
    NSArray *titleName = @[@"备孕交流圈",@"育儿妈妈圈",@"试管婴儿圈",@"生男生女圈"];
    NSArray *iconName = @[@"byq",@"hyq",@"sgq",@"snsnq"];
    
    for (int i = 0; i<4; i++) {
        
        
        UIButton *btn = [[UIButton alloc]init];
        
        btn.frame = CGRectMake(20+i*(60+(a-280)/3), 10, 60, 60);
        
        [btn setImage:[UIImage imageNamed:iconName[i]] forState:UIControlStateNormal];
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10+i*(60+(a-280)/3), 80, 80, 20)];
        lab.font = [UIFont systemFontOfSize:14];
        [lab setText:titleName[i]];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [self.hScrollView addSubview:lab];
        [self.hScrollView addSubview:btn];
        
        
    }
    
    //区分线
    
    if (a <=375) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 250, a, 5)];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.scrollView addSubview:line];
    } else {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 390, a, 5)];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.scrollView addSubview:line];
    }
    
    NSArray *btnName = @[@"全部",@"最新",@"热门",@"精华",@"求助"];
    
    if (a<=375) {


        {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(8, 260, (a-16)/5, 40)];
            [btn1 setTitle:btnName[0] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            btn1.selected = YES;
            self.allBtn = btn1;
            [self.scrollView addSubview:self.allBtn];
            [self.allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
        {
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(8 + (a-16)/5, 260, (a-16)/5, 40)];
            [btn2 setTitle:btnName[1] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            
            self.newwBtn = btn2;
            [self.scrollView addSubview:self.newwBtn];
            [self.newwBtn addTarget:self action:@selector(newwBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        {
            UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(8 + 2*(a-16)/5, 260, (a-16)/5, 40)];
            [btn3 setTitle:btnName[2] forState:UIControlStateNormal];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn3 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            self.hotdoorBtn = btn3;
            [self.scrollView addSubview:self.hotdoorBtn];
            [self.hotdoorBtn addTarget:self action:@selector(hotdoorBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        {
            UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(8 + 3*(a-16)/5, 260, (a-16)/5, 40)];
            [btn4 setTitle:btnName[3] forState:UIControlStateNormal];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn4 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            self.classicBtn = btn4;
            [self.scrollView addSubview:self.classicBtn];
            [self.classicBtn addTarget:self action:@selector(classicBtnClick) forControlEvents:UIControlEventTouchUpInside];

        }
        {
            UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(8 + 4*(a-16)/5, 260, (a-16)/5, 40)];
            [btn5 setTitle:btnName[4] forState:UIControlStateNormal];
            [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn5 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0]forState:UIControlStateSelected];
            self.helpBtn = btn5;
            [self.scrollView addSubview:self.helpBtn];
            [self.helpBtn addTarget:self action:@selector(helpBtnClick) forControlEvents:UIControlEventTouchUpInside];

        }
        
    } else {

        {
            UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(8, 400, (a-16)/5, 40)];
            [btn1 setTitle:btnName[0] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn1 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            btn1.selected = YES;
            self.allBtn = btn1;
            [self.scrollView addSubview:self.allBtn];
            [self.allBtn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        
        {
            UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(8 + (a-16)/5, 400, (a-16)/5, 40)];
            [btn2 setTitle:btnName[1] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn2 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            
            self.newwBtn = btn2;
            [self.scrollView addSubview:self.newwBtn];
            [self.newwBtn addTarget:self action:@selector(newwBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        {
            UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(8 + 2*(a-16)/5, 400, (a-16)/5, 40)];
            [btn3 setTitle:btnName[2] forState:UIControlStateNormal];
            [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn3 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            self.hotdoorBtn = btn3;
            [self.scrollView addSubview:self.hotdoorBtn];
            [self.hotdoorBtn addTarget:self action:@selector(hotdoorBtnClick) forControlEvents:UIControlEventTouchUpInside];
        }
        {
            UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(8 + 3*(a-16)/5, 400, (a-16)/5, 40)];
            [btn4 setTitle:btnName[3] forState:UIControlStateNormal];
            [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn4 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            self.classicBtn = btn4;
            [self.scrollView addSubview:self.classicBtn];
            [self.classicBtn addTarget:self action:@selector(classicBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
        }
        {
            UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(8 + 4*(a-16)/5, 400, (a-16)/5, 40)];
            [btn5 setTitle:btnName[4] forState:UIControlStateNormal];
            [btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn5 setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0]forState:UIControlStateSelected];
            self.helpBtn = btn5;
            [self.scrollView addSubview:self.helpBtn];
            [self.helpBtn addTarget:self action:@selector(helpBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    //区分线
    if (a <=375) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 305, a, 5)];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.scrollView addSubview:line];
    } else {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 390, a, 5)];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.scrollView addSubview:line];
    }


    
    
}
//标签按钮的点击事件
-(void)allBtnClick {
    self.allBtn.selected = YES;
    self.newwBtn.selected = NO;
    self.hotdoorBtn.selected = NO;
    self.classicBtn.selected = NO;
    self.helpBtn.selected = NO;
    
    
}
-(void)newwBtnClick {
    self.allBtn.selected = NO;
    self.newwBtn.selected = YES;
    self.hotdoorBtn.selected = NO;
    self.classicBtn.selected = NO;
    self.helpBtn.selected = NO;
    
    
    NSString *Str = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/forum?page=1&form=%@",self.newwBtn.titleLabel.text];
    
   // NSLog(@"%@",self.newwBtn.titleLabel.text);
    NSString *nsUrl = [Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    UUUrl = nsUrl;
    [self.table reloadData];
    //
//    [HSHTTPClient request:GET URLString:nsUrl parameters:nil success:^(id json) {
//        //        NSLog(@"%@",(NSDictionary *)json);
//        
//        
//        [self.table reloadData];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];

    
   
    
    
}

-(void)hotdoorBtnClick {
    self.allBtn.selected = NO;
    self.newwBtn.selected = NO;
    self.hotdoorBtn.selected = YES;
    self.classicBtn.selected = NO;
    self.helpBtn.selected = NO;
    NSString *Str = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/forum?page=1&form=%@",self.hotdoorBtn.titleLabel.text];
    
    NSString *nsUrl = [Str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    UUUrl = nsUrl;
    [self.table reloadData];
    //
//    NSLog(@"%@",self.hotdoorBtn.titleLabel.text);
//    //
//    [HSHTTPClient request:GET URLString:nsUrl parameters:nil success:^(id json) {
//        //        NSLog(@"%@",(NSDictionary *)json);
//        
//        
//        [self.table reloadData];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
}
-(void)classicBtnClick {
    self.allBtn.selected = NO;
    self.newwBtn.selected = NO;
    self.hotdoorBtn.selected = NO;
    self.classicBtn.selected = YES;
    self.helpBtn.selected = NO;
}
-(void)helpBtnClick {
    self.allBtn.selected = NO;
    self.newwBtn.selected = NO;
    self.hotdoorBtn.selected = NO;
    self.classicBtn.selected = NO;
    self.helpBtn.selected = YES;
}
//四个圆形的 button
//先写一个 button 工厂
-(UIButton *)setButtonWithPic:(NSString *)picNorName Highlighted:(NSString *)picHiName
{
    UIButton *btn = [[UIButton alloc]init];
    
    [btn setImage:[UIImage imageNamed:picNorName] forState:UIControlStateNormal];
    
    [btn setImage:[UIImage imageNamed:picHiName] forState:UIControlStateHighlighted];
    
    return btn;
}

-(void)setUpButton
{

    UIButton *btn1 = [[UIButton alloc]init];
    
    [btn1 setImage:[UIImage imageNamed:@"zr1"] forState:UIControlStateNormal];
    
//    [btn1 setImage:[UIImage imageNamed:@"圈子1"] forState:UIControlStateHighlighted];
    
    self.findBtn = btn1;

    [self.scrollView addSubview:self.findBtn];
    [self.findBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(225);
        make.left.equalTo(self.scrollView).offset(25);
        make.width.equalTo(60);
        make.height.equalTo(60);
    }];
    
//第二个
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setImage:[UIImage imageNamed:@"rt2"] forState:UIControlStateNormal];
    self.hotBtn = btn2;
    [self.scrollView addSubview:self.hotBtn];
    [self.hotBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(225);
        float a = ([UIScreen mainScreen].bounds.size.width - 290)/3 + 60;
        make.left.equalTo(self.findBtn).offset(a);
        make.size.equalTo(self.findBtn);
    }];
    
    
    
    //第三个
    UIButton *btn3 = [[UIButton alloc]init];
    [btn3 setImage:[UIImage imageNamed:@"sp3"] forState:UIControlStateNormal];
    self.videoBtn = btn3;
    [self.scrollView addSubview:self.videoBtn];
    [self.videoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(225);
        float a = ([UIScreen mainScreen].bounds.size.width - 290)/3 + 60;
        make.left.equalTo(self.hotBtn).offset(a);
        make.size.equalTo(self.hotBtn);
    }];
    
    //第四个
    UIButton *btn4 = [[UIButton alloc]init];
    [btn4 setImage:[UIImage imageNamed:@"kp4"] forState:UIControlStateNormal];
    self.knoBtn = btn4;
    [self.scrollView addSubview:self.knoBtn];
    [self.knoBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).offset(225);
        float a = ([UIScreen mainScreen].bounds.size.width - 290)/3 + 60;
        make.left.equalTo(self.videoBtn).offset(a);
        make.size.equalTo(self.videoBtn);
    }];
    
    
    
    
    XFpicAndLab *picAndLab = [[XFpicAndLab alloc]initWithFrame:CGRectMake(0, 300, 414, 80)];
    [self.scrollView addSubview:picAndLab];
    
    

}


//创建一个 tableview
-(void)loadTable {
    float a = [UIScreen mainScreen].bounds.size.width;
    if(a <= 375) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 310, [UIScreen mainScreen].bounds.size.width, 1320)];
        table.delegate = self;
        table.dataSource = self;
        table.rowHeight = 140;
        [self.scrollView addSubview:table];

    } else {
//        NSLog(@"来这里了嘛");
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 450, [UIScreen mainScreen].bounds.size.width, 1400)];
        table.delegate = self;
        table.dataSource = self;
        table.rowHeight = 140;
        [self.scrollView addSubview:table];

    }
    
    
}
// 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
         //去缓存池找名叫reuseIdentifier的cell
     //这里换成自己定义的cell
    XFthirdCell *cell = [XFthirdCell cellWithTableview:tableView];
    
    
    NSString *nsUrl = [NSString stringWithFormat:@"%@", UUUrl];
    
    NSLog(@"%@",UUUrl);
//    
    [XFcercleCellModel loadDataWithURLString:nsUrl successBlock:^(NSMutableArray *circleModels) {
        self.circleModels = circleModels;
        cell.cirModel = self.circleModels[indexPath.row];
//        NSLog(@"------VC---%@------------------",self.circleModels);
        
        [self.table reloadData];
    } failedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];


    
    return cell;
}

/*
 
 @property(nonatomic,copy) NSString *cirle_title;
 @property(nonatomic,copy) NSString *user_images;
 @property(nonatomic,copy) NSString *user_name;
 @property(nonatomic,copy) NSString *cirle_time;
 @property(nonatomic,copy) NSString *cirle_look;
 @property(nonatomic,copy) NSString *cirle_commentNb;
 @property(nonatomic,copy) NSString *cirle_tag;
 @property(nonatomic,copy) NSString *cirle_content;
 @property(nonatomic,copy) NSString *cirle_share;
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFdetailedCircle *dtVC = [[XFdetailedCircle alloc]init];
    
/*
 @property(nonatomic,copy) NSString *cirle_id;
 @property(nonatomic,copy) NSString *cirle_title;
 @property(nonatomic,copy) NSString *user_images;
 @property(nonatomic,copy) NSString *user_name;
 @property(nonatomic,copy) NSString *user_time;
 @property(nonatomic,copy) NSString *cirle_look;
 @property(nonatomic,copy) NSString *cirle_commentNb;
 @property(nonatomic,copy) NSString *cirle_tag;
 */
    
    
    XFcercleCellModel *cirModel = self.circleModels[indexPath.row];
    
    dtVC.cirle_id = cirModel.cirle_id;
    dtVC.cirle_title = cirModel.cirle_title;
    dtVC.user_images = cirModel.user_images;
    dtVC.user_name = cirModel.user_name;
    dtVC.cirle_time = cirModel.user_time;
    dtVC.cirle_look = cirModel.cirle_look;
    dtVC.cirle_commentNb = cirModel.cirle_commentNb;
    dtVC.cirle_tag = cirModel.cirle_tag;
//    dtVC.cirle_content = cirModel.cirle_content;
    
    dtVC.pagE = 1;
    
    
    
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:dtVC animated:YES];
    
    self.hidesBottomBarWhenPushed=NO;
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

//-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    
//    NSLog(@"有不匹配的键值对");
//    
//}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self . tabBarController . tabBar . hidden = NO;
    

}

@end
