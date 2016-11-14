//
//  XFSecondVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/13.
//  Copyright © 2016年 PUHIM. All rights reserved.
// 发现

#import "XFSecondVC.h"
#import "WZCImagePlayView.h"
#import "XFfindCell.h"

#import "XFfindDocVC.h"
#import "XFfindHosVC.h"
#import "XFdocLiveVC.h"
#import "XFconsultCell.h"
#import "MJRefresh.h"
#import "XFconsulterVC.h"

@interface XFSecondVC ()<UISearchBarDelegate,WZCImagePlayViewDelegate, UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,weak) UIButton *btn ;
//图片轮播
@property(nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) NSArray *imagesP;
@property(nonatomic,strong) UITableView *abbTable;
@property(nonatomic,strong) UITableView *labTable;

@property(nonatomic,weak) UIButton * abbtj;
@property(nonatomic,weak) UIButton * sggw;
@property(nonatomic,weak) UIButton * rmjc;
@property(nonatomic,weak) UIButton * yybd;

@property(nonatomic,weak) UIButton * postBtn;
@property(nonatomic,strong) UIScrollView * scV;

@property(nonatomic,strong) UITableView *tableV1;
@property(nonatomic,strong) UITableView *tableV2;
@property(nonatomic,strong) UITableView *tableV3;
@property(nonatomic,strong) UITableView *tableV4;

@property(nonatomic,assign) CGFloat keyboardHeight;
//编辑状态下的蒙板
@property(nonatomic,strong) UIView * mengbanV;

@end

@implementation XFSecondVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpSearchbar];
    [self setUpLayout];
    [self loadTable];
    
    [self refreshTable:self.tableV1];
    [self refreshTable:self.tableV2];
    [self refreshTable:self.tableV3];
    [self refreshTable:self.tableV4];
    
    [self registerForKeyboardNotifications];
    
}

-(void)refreshTable:(UITableView *)table {
    
        //上拉
    table.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData2)];
    //下拉
    table.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    table.mj_header.automaticallyChangeAlpha = YES;
    
}
#pragma mark ----------下拉加载
-(void)loadData2{
    
}
#pragma mark ----------下拉刷新
-(void)loadMoreData {

}


- (void)imageViewStartPlay
{
    float a = [UIScreen mainScreen].bounds.size.width;
    if (a <= 375) {
        WZCImagePlayView *imagePlay = [[WZCImagePlayView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 140) imagesUrlString:@[@"http://ma.beidaivf04.com/images/banner/banner1.jpg",
                                                                                                                                                              @"http://ma.beidaivf04.com/images/banner/banner2.jpg",
                                                                                                                                                              
                                                                                                                                                              @" http://ma.beidaivf04.com/images/banner/banner3.jpg"]
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
        WZCImagePlayView *imagePlay = [[WZCImagePlayView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 280) imagesUrlString:@[@"http://ma.beidaivf04.com/images/banner/banner1.jpg",
                                                                                                                                                              @"http://ma.beidaivf04.com/images/banner/banner2.jpg",
                                                                                                                                                              
                                                                                                                                                              @" http://ma.beidaivf04.com/images/banner/banner3.jpg"]
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
    [self.view addSubview:btn];
    self.postBtn = btn;
    [self.postBtn setImage:[UIImage imageNamed:@"post"] forState:UIControlStateNormal];
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
    //nononono 这个是什么
}

-(void)setUpLayout {
    
    float a = [UIScreen mainScreen].bounds.size.width;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 104)];
    if (a <= 375) {
        self.scrollView.contentSize = CGSizeMake(0, 740);
    } else {
        self.scrollView.contentSize = CGSizeMake(0, 800);
    }
    
    
    
    self.scrollView.scrollsToTop = NO;
    
    
    //添加轮播器
    [self imageViewStartPlay];
    
    [self.view addSubview:self.scrollView];
}




-(void)loadTable
{
    float a = [UIScreen mainScreen].bounds.size.width;

    if (a <= 375) {
        UITableView *tab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 140, [UIScreen mainScreen].bounds.size.width, 120)style:UITableViewStylePlain];
//        self.abbTable = tab1;
        //把 table 加在父视图 scroll 上面
        [self.scrollView addSubview:tab1];
        //数据源和代理
        tab1.delegate = self;
        tab1.dataSource = self;
        //固定 cell行高
        tab1.rowHeight = 40;
        //关闭 table 的滚动功能
        tab1.scrollEnabled = NO;
        self.labTable = tab1;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 260, a, 10)];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.scrollView addSubview:line];
    
       // 这个360frame 好奇怪  理论上应该是320 ------ 解决
        UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 320, [UIScreen mainScreen].bounds.size.width, 420 )];
        self.scV = sc;
        self.scV.delegate = self;
        self.scV.contentSize = CGSizeMake(a * 4, 0);
        self.scV.bounces = NO;
        self.scV.scrollEnabled = NO;
        
        self.scV.pagingEnabled = YES;
        
        self.scV.showsHorizontalScrollIndicator = NO;
        self.scV.showsVerticalScrollIndicator = NO;
        
        [self.scrollView addSubview:self.scV];
        
        
        UIView *aa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, a, 420)];
        UIView *bb = [[UIView alloc]initWithFrame:CGRectMake(a, 0, a, 420)];
        UIView *cc = [[UIView alloc]initWithFrame:CGRectMake(2*a, 0, a, 420)];
        UIView *dd = [[UIView alloc]initWithFrame:CGRectMake(3*a, 0, a, 420)];
        [self.scV addSubview:aa];
        [self.scV addSubview:bb];
        [self.scV addSubview:cc];
        [self.scV addSubview:dd];
        //在 aa,bb,cc,dd里创建 tableview
        UITableView *table1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        UITableView *table2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        UITableView *table3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        UITableView *table4 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        
        [aa addSubview:table1];
        [bb addSubview:table2];
        [cc addSubview:table3];
        [dd addSubview:table4];
        self.tableV1 = table1;
        self.tableV2 = table2;
        self.tableV3 = table3;
        self.tableV4 = table4;
        
        self.tableV1.delegate = self;
        self.tableV1.dataSource = self;
        self.tableV1.rowHeight = 160;
        
        self.tableV2.delegate = self;
        self.tableV2.dataSource = self;
        self.tableV2.rowHeight = 160;
        
        self.tableV3.delegate = self;
        self.tableV3.dataSource = self;
        self.tableV3.rowHeight = 160;
        
        self.tableV4.delegate = self;
        self.tableV4.dataSource = self;
        self.tableV4.rowHeight = 160;
        
        
        //标签按钮     246  75   132 rgb
        NSArray *titleName = @[@"爱宝宝推荐",@"试管顾问",@"心理咨询师",@"营养师"];
        for (int i = 0; i<4; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i* a/4, 270, a/4, 40)];
            [btn setTitle:titleName[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
            [self.scrollView addSubview:btn];
            if (a == 320) {
                btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];

            }
            
            if (i == 0) {
                btn.selected = YES;
                self.abbtj = btn;
                [self.abbtj addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
            } else if (i==1){
                self.sggw = btn;
                [self.sggw addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
            } else if (i==2){
                self.rmjc = btn;
                [self.rmjc addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
            } else {
                self.yybd = btn;
                [self.yybd addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
    } else {
        
        UITableView *tab1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 280, [UIScreen mainScreen].bounds.size.width, 120)style:UITableViewStylePlain];
        //        self.abbTable = tab1;
        //把 table 加在父视图 scroll 上面
        [self.scrollView addSubview:tab1];
        //数据源和代理
        tab1.delegate = self;
        tab1.dataSource = self;
        //固定 cell行高
        tab1.rowHeight = 40;
        //关闭 table 的滚动功能
        tab1.scrollEnabled = NO;
        self.labTable = tab1;
        
        //设置分割线
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 400, a, 10)];
        line.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self.scrollView addSubview:line];
        
   
        
        UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 320, [UIScreen mainScreen].bounds.size.width, 420)];
        self.scV = sc;
        self.scV.delegate = self;
        self.scV.contentSize = CGSizeMake(a * 4, 0);
        self.scV.bounces = NO;
        self.scV.scrollEnabled = NO;
        
        self.scV.pagingEnabled = YES;
        
        self.scV.showsHorizontalScrollIndicator = NO;
        self.scV.showsVerticalScrollIndicator = NO;
        
        [self.scrollView addSubview:self.scV];
        
        
        UIView *aa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, a, 420)];
        UIView *bb = [[UIView alloc]initWithFrame:CGRectMake(a, 0, a, 420)];
        UIView *cc = [[UIView alloc]initWithFrame:CGRectMake(2*a, 0, a, 420)];
        UIView *dd = [[UIView alloc]initWithFrame:CGRectMake(3*a, 0, a, 420)];
        [self.scV addSubview:aa];
        [self.scV addSubview:bb];
        [self.scV addSubview:cc];
        [self.scV addSubview:dd];
        //在 aa,bb,cc,dd里创建 tableview
        UITableView *table1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        UITableView *table2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        UITableView *table3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        UITableView *table4 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, a, 420 )];
        
        [aa addSubview:table1];
        [bb addSubview:table2];
        [cc addSubview:table3];
        [dd addSubview:table4];
        self.tableV1 = table1;
        self.tableV2 = table2;
        self.tableV3 = table3;
        self.tableV4 = table4;
        
        self.tableV1.delegate = self;
        self.tableV1.dataSource = self;
        self.tableV1.rowHeight = 160;
        
        self.tableV2.delegate = self;
        self.tableV2.dataSource = self;
        self.tableV2.rowHeight = 160;
        
        self.tableV3.delegate = self;
        self.tableV3.dataSource = self;
        self.tableV3.rowHeight = 160;
        
        self.tableV4.delegate = self;
        self.tableV4.dataSource = self;
        self.tableV4.rowHeight = 160;
        //标签
        
        //标签按钮     246  75   132 rgb
        NSArray *titleName = @[@"爱宝宝推荐",@"试管顾问",@"心理咨询师",@"营养师"];
        
        for (int i = 0; i<4; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i* a/4, 410, a/4, 40)];
            [btn setTitle:titleName[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forState:UIControlStateSelected];
//            btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
            
            [self.scrollView addSubview:btn];
            if (i == 0) {
                btn.selected = YES;
                self.abbtj = btn;
                [self.abbtj addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
            } else if (i==1){
                self.sggw = btn;
                [self.sggw addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
            } else if (i==2){
                self.rmjc = btn;
                [self.rmjc addTarget:self action:@selector(btn3Click) forControlEvents:UIControlEventTouchUpInside];
            } else {
                self.yybd = btn;
                [self.yybd addTarget:self action:@selector(btn4Click) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
    }
}

-(void)btn1Click {
    self.abbtj.selected = YES;
    self.sggw.selected = NO;
    self.rmjc.selected = NO;
    self.yybd.selected = NO;
    [self.scV setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(void)btn2Click {
    self.abbtj.selected = NO;
    self.sggw.selected = YES;
    self.rmjc.selected = NO;
    self.yybd.selected = NO;
    [self.scV setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:YES];
}
-(void)btn3Click {
    float a =  [UIScreen mainScreen].bounds.size.width;
    self.abbtj.selected = NO;
    self.sggw.selected = NO;
    self.rmjc.selected = YES;
    self.yybd.selected = NO;
    [self.scV setContentOffset:CGPointMake(2*a, 0) animated:YES];
}
-(void)btn4Click {
    float a =  [UIScreen mainScreen].bounds.size.width;
    self.abbtj.selected = NO;
    self.sggw.selected = NO;
    self.rmjc.selected = NO;
    self.yybd.selected = YES;
    [self.scV setContentOffset:CGPointMake(3*a, 0) animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.abbTable) {
        return 5;
    }

    return 5;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( tableView == self.tableV1) {
        XFfindCell *cell = [XFfindCell cellWithTableview:tableView];
        //赋值 balabala
        
            
    
        
        return  cell;
    }
    
    if (tableView == self.tableV2) {
        XFconsultCell *cell = [XFconsultCell cellWithTableview:tableView];
        
        return cell;
    }
    if (tableView == self.tableV3) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        
        return cell;
    }
    if (tableView == self.tableV4) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        
        return cell;
    }

    float a = [UIScreen mainScreen].bounds.size.width;
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.imageView.image = [UIImage imageNamed:@"1zyy"];
        cell.textLabel.text = @"找医院";
        if (a == 320) {
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        }

        return cell;
    } else if (indexPath.row ==1) {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.imageView.image = [UIImage imageNamed:@"2zys"];
        cell.textLabel.text = @"找医生";

        if (a == 320) {
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        }
        
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc]init];
        cell.imageView.image = [UIImage imageNamed:@"3chl"];
        cell.textLabel.text = @"专家直播间";
        if (a == 320) {
            [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        }
        return  cell;
    }

//    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView == self.labTable&&indexPath.row == 1) {
        //找医生
        XFfindHosVC *vc = [[XFfindHosVC alloc]init];
        
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        self.hidesBottomBarWhenPushed=NO;
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    } else if (tableView == self.labTable&&indexPath.row == 0) {
        //找医院
        XFfindDocVC *vc = [[XFfindDocVC alloc]init];
        
        self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        self.hidesBottomBarWhenPushed=NO;
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    } else if (tableView == self.labTable&&indexPath.row == 2){
        //直播页面
        XFdocLiveVC *vc = [[XFdocLiveVC alloc]init];
        
        //self.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        //self.hidesBottomBarWhenPushed=NO;
        
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    } else if (tableView == self.tableV2) {
        
        XFconsulterVC *vc = [[XFconsulterVC alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated
{
    //self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
    self.tabBarController.tabBar.hidden = NO ;
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
