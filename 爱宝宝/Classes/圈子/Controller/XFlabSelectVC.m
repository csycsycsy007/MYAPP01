//
//  XFlabSelectVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/10/14.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFlabSelectVC.h"
#import "UIView+MM_Ext.h"
#import "XFpostVC.h"


@interface XFlabSelectVC ()<UIScrollViewDelegate>

@property(nonatomic,weak) UIButton * labBtn1;
@property(nonatomic,weak) UIButton * labBtn2;
@property(nonatomic,weak) UIButton * labBtn3;

@property(nonatomic,weak) UIButton * labSeBtn1;
@property(nonatomic,weak) UIButton * labSeBtn2;
@property(nonatomic,weak) UIButton * labSeBtn3;
@property(nonatomic,weak) UIButton * labSeBtn4;
@property(nonatomic,assign) NSInteger * hhh;
@property(nonatomic,assign) NSInteger * margin;


@property(nonatomic,strong) UIScrollView * scV;

@end

@implementation XFlabSelectVC

static CGFloat appW = 0;
static CGFloat margin = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutVC];
    [self setUpScrolV];
    // Do any additional setup after loading the view.
}
//布局整个界面
- (void)layoutVC {

    float a = [UIScreen mainScreen].bounds.size.width;
    

    
    
   
    
    NSArray *titleA = @[@"备孕经验",@"晒好孕",@"试管婴儿",@"不孕不育"];
//    NSArray *btns = @[self.labSeBtn1,self.labSeBtn2,self.labSeBtn3,self.labSeBtn4];
    //四个标签组
    for (int i =0 ;i<4; i++) {

        
//            NSLog(@"都隐藏");
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10 + i*((a-50)/4 + 10), 74, (a - 50)/4, 44)];
            [btn setTitle:titleA[i] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if(a<375) {
            
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            
        }
            [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateSelected];
            
            if (i == 0) {
//                btn.selected = YES;
                [self labBtnSelect:btn];
            }
            if (i == 0) {
                self.labSeBtn1 = btn;
            } else if (i == 1) {
                self.labSeBtn2 = btn;
            } else if (i == 2) {
                self.labSeBtn3 = btn;
            } else {
                self.labSeBtn4 = btn;
            }
            
            
            //区分按钮
            btn.tag = i;
            
            [btn addTarget:self action:@selector(labBtnSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:btn];
            

    }
    
    
}
//上面的 labBtn 的点击事件
-(void)btn1Click {

    if (self.labBtn3) {
        
        [self.labBtn1 setTitle:self.labBtn2.titleLabel.text forState:UIControlStateNormal];
        [self.labBtn2 setTitle:self.labBtn3.titleLabel.text forState:UIControlStateNormal];
        
        [self.labBtn3 removeFromSuperview];
    } else if (self.labBtn2) {
        
        [self.labBtn1 setTitle:self.labBtn2.titleLabel.text forState:UIControlStateNormal];
        
        [self.labBtn2 removeFromSuperview];
    } else {
        [self.labBtn1 removeFromSuperview];
        self.scV.frame = CGRectMake(0, 128, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 84);
        self.labSeBtn1.y = 74;
        self.labSeBtn2.y = 74;
        self.labSeBtn3.y = 74;
        self.labSeBtn4.y = 74;
    }

    

    

}
-(void)btn2Click {

    if (_labBtn3) {
        [self.labBtn2 setTitle:self.labBtn3.titleLabel.text forState:UIControlStateNormal];
        
        [self.labBtn3 removeFromSuperview];
    } else {
        [_labBtn2 removeFromSuperview];
    }
    
    

    
}
-(void)btn3Click {
    [_labBtn3 removeFromSuperview];


}

//中部标签选择点击事件
-(void)labBtnSelect:(UIButton *)btn {


    float a =  [UIScreen mainScreen].bounds.size.width;
    
    self.labSeBtn1.selected = NO;
    self.labSeBtn2.selected = NO;
    self.labSeBtn3.selected = NO;
    self.labSeBtn4.selected = NO;
    btn.selected = YES;
    
    if (btn == self.labSeBtn2) {
        [self.scV setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    } else if (btn == self.labSeBtn1) {
        
        [self.scV setContentOffset:CGPointMake(0, 0) animated:YES];
        
    } else if (btn == self.labSeBtn3) {
        
        [self.scV setContentOffset:CGPointMake(2*a, 0) animated:YES];
        
    } else {
        [self.scV setContentOffset:CGPointMake(3*a, 0) animated:YES];
    }
    
    
    
//为什么用 tag 调用 btn 不好用
    
}


//页面创建时候 设置标题 设置右边按钮完成
-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = @"添加标签";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(200, 0, 50, 40)];
    [btn setTitle:@"完成" forState: UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor] forState:<#(UIControlState)#>]
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    [btn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
}
//创建滑动表单
-(void)setUpScrolV {
    
    float a = [UIScreen mainScreen].bounds.size.width;
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 128, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 178)];
    self.scV = sc;
    self.scV.delegate = self;
    self.scV.contentSize = CGSizeMake(a * 4, 0);
    self.scV.bounces = NO;
    self.scV.scrollEnabled = NO;
    
    self.scV.pagingEnabled = YES;
    
    self.scV.showsHorizontalScrollIndicator = NO;
    self.scV.showsVerticalScrollIndicator = NO;
    
//    self.scV.scrollEnabled = NO;
    [self.view addSubview:self.scV];
    
    
    UIView *aa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, a, 500)];
    UIView *bb = [[UIView alloc]initWithFrame:CGRectMake(a, 0, a, 500)];
    UIView *cc = [[UIView alloc]initWithFrame:CGRectMake(2*a, 0, a, 500)];
    UIView *dd = [[UIView alloc]initWithFrame:CGRectMake(3*a, 0, a, 500)];
// 在 aa 里设置里面的按钮 标签
    
    if (a < 375) {
        appW = 90;
        margin = 10;
    } else {
        appW = 100;
        margin = 20;
    }
    
    
//    appW = 100;
    CGFloat appH = 30;
    // 列数
    NSInteger columnCount = 3;
    // 格子间间距
//    CGFloat margin = 20;
    // 计算左边边距 =  (控制器view的宽  - (格子的宽 * 列数) - (列数 - 1) * 间距) * 0.5
    CGFloat leftMargin = (self.view.bounds.size.width - (appW * columnCount) - (columnCount - 1) * margin) * 0.5;
    // 顶部间距
    CGFloat topMargin = 20;

    //特殊一个小屏手机

    
    NSArray *lab1 = @[@"经期状况",@"备孕心情",@"生男生女",@"早早孕",@"二胎备孕",@"孕前检查",@"备孕饮食",@"不孕筛查",@"中医备孕",@"孕前准备",@"其他"];
    
    {
        
        
        for (int i = 0; i< 11; i++) {
            UIButton *appView = [[UIButton alloc]init];
//            UIView *appView = [[UIView alloc] init];

            if (a < 375) {
                appView.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            // 计算列号
            NSInteger col = i % columnCount;
            // 计算appX   appX  = 左边边距  + (格子的宽  + 格子之间的间距) * 列号
            CGFloat appX = leftMargin + (appW + margin) * col;
            
            // 计算行号
            NSInteger row = i / columnCount;
            // 计算appY   appY = 顶部边距 + (格子的高  + 格子之间的间距) * 行号
            CGFloat appY = topMargin + (appH + margin) * row;
            // 设置frame
            appView.frame = CGRectMake(appX, appY, appW, appH);
            
            [appView setTitle:lab1[i] forState:UIControlStateNormal];
            
            [aa addSubview:appView];
            [appView addTarget:self action:@selector(labelBtnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            appView.layer.borderWidth = 2.0f;
            [appView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
//            NSLog(@"%@",appView);
        }
    }
    
//  bbView上的
    NSArray *lab2 = @[@"晒好孕",@"怀孕症状"];
    
    {
        for (int i = 0; i< 2; i++) {
            UIButton *appView = [[UIButton alloc]init];
            //            UIView *appView = [[UIView alloc] init];
            if (a < 375) {
                appView.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            
            // 计算列号
            NSInteger col = i % columnCount;
            // 计算appX   appX  = 左边边距  + (格子的宽  + 格子之间的间距) * 列号
            CGFloat appX = leftMargin + (appW + margin) * col;
            
            // 计算行号
            NSInteger row = i / columnCount;
            // 计算appY   appY = 顶部边距 + (格子的高  + 格子之间的间距) * 行号
            CGFloat appY = topMargin + (appH + margin) * row;
            // 设置frame
            appView.frame = CGRectMake(appX, appY, appW, appH);
            [appView setTitle:lab2[i] forState:UIControlStateNormal];
            
            [bb addSubview:appView];
            
            [appView addTarget:self action:@selector(labelBtnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            appView.layer.borderWidth = 2.0f;
            [appView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            //            NSLog(@"%@",appView);
        }

        
    }
//    cc里的标签
    NSArray *lab3 = @[@"试管经验",@"促排卵",@"选性别",@"第三代技术",@"供精提卵",@"同性试管",@"高龄试管",@"试管失败",@"试管费用",@"泰国试管",@"试管成功率",@"第二代技术",@"第一代技术",@"其他"];
    {
        for (int i = 0; i< 14; i++) {
            UIButton *appView = [[UIButton alloc]init];
            //            UIView *appView = [[UIView alloc] init];
            if (a < 375) {
                appView.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            // 计算列号
            NSInteger col = i % columnCount;
            // 计算appX   appX  = 左边边距  + (格子的宽  + 格子之间的间距) * 列号
            CGFloat appX = leftMargin + (appW + margin) * col;
            
            // 计算行号
            NSInteger row = i / columnCount;
            // 计算appY   appY = 顶部边距 + (格子的高  + 格子之间的间距) * 行号
            CGFloat appY = topMargin + (appH + margin) * row;
            // 设置frame
            appView.frame = CGRectMake(appX, appY, appW, appH);
            [appView setTitle:lab3[i] forState:UIControlStateNormal];
            [cc addSubview:appView];
            
            [appView addTarget:self action:@selector(labelBtnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            appView.layer.borderWidth = 2.0f;
            [appView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            //            NSLog(@"%@",appView);
        }

    }
    
    NSArray *lab4 = @[@"染色体异常",@"卵巢早衰",@"子宫问题",@"多囊卵巢",@"流产胎停",@"辅助生殖",@"排卵障碍",@"内膜异位",@"中医治疗",@"男科不育",@"输卵管不通",@"其他"];
    {
        for (int i = 0; i< 12; i++) {
            UIButton *appView = [[UIButton alloc]init];
            //            UIView *appView = [[UIView alloc] init];
            if (a < 375) {
                appView.titleLabel.font = [UIFont systemFontOfSize:14];
            }
            // 计算列号
            NSInteger col = i % columnCount;
            // 计算appX   appX  = 左边边距  + (格子的宽  + 格子之间的间距) * 列号
            CGFloat appX = leftMargin + (appW + margin) * col;
            
            // 计算行号
            NSInteger row = i / columnCount;
            // 计算appY   appY = 顶部边距 + (格子的高  + 格子之间的间距) * 行号
            CGFloat appY = topMargin + (appH + margin) * row;
            // 设置frame
            appView.frame = CGRectMake(appX, appY, appW, appH);
            [appView setTitle:lab4[i] forState:UIControlStateNormal];
            [dd addSubview:appView];
            
            [appView addTarget:self action:@selector(labelBtnSelectClick:) forControlEvents:UIControlEventTouchUpInside];
            
            appView.layer.borderWidth = 2.0f;
            [appView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            //            NSLog(@"%@",appView);
        }

    }
    
    
    
    
    [self.scV addSubview:aa];
    [self.scV addSubview:bb];
    [self.scV addSubview:cc];
    [self.scV addSubview:dd];
    
}


-(void)labelBtnSelectClick:(UIButton *)btn {
   
    float a = [UIScreen mainScreen].bounds.size.width;
    
    if (!_labBtn1 || !_labBtn2 || !_labBtn3) {
        
//        NSLog(@"%@",self.labBtn1);
//        NSLog(@"%@  ------ %@",_labBtn2,_labBtn3);
        
        if (!_labBtn1) {
            self.scV.frame = CGRectMake(0, 178, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 84);
            self.labSeBtn1.y = 134;
            self.labSeBtn2.y = 134;
            self.labSeBtn3.y = 134;
            self.labSeBtn4.y = 134;
            
            UIButton *labBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 74, (a - 60)/3, 30)];
            self.labBtn1 = labBtn;
            //        self.labBtn1.backgroundColor = [UIColor magentaColor];
            [self.labBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.labBtn1.layer.borderWidth = 2.0f;
            [self.labBtn1 setTitle:btn.titleLabel.text forState:UIControlStateNormal];
            
            [self.labBtn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:self.labBtn1];
            
        } else if (!_labBtn2) {
            UIButton *labBtn = [[UIButton alloc]initWithFrame:CGRectMake(30+(a-60)/3, 74, (a - 60)/3, 30)];
            self.labBtn2 = labBtn;
            //        self.labBtn1.backgroundColor = [UIColor magentaColor];
            [self.labBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.labBtn2.layer.borderWidth = 2.0f;
            [self.labBtn2 setTitle:btn.titleLabel.text forState:UIControlStateNormal];
            
            [self.labBtn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:self.labBtn2];

        }else if (!_labBtn3) {
            
            UIButton *labBtn = [[UIButton alloc]initWithFrame:CGRectMake(40+(a-60)/3*2, 74, (a - 60)/3, 30)];
            self.labBtn3 = labBtn;
            //        self.labBtn1.backgroundColor = [UIColor magentaColor];
            [self.labBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.labBtn3.layer.borderWidth = 2.0f;
            [self.labBtn3 setTitle:btn.titleLabel.text forState:UIControlStateNormal];
            
            [self.labBtn3 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
            
            [self.view addSubview:self.labBtn3];

        }
        

        
     

    }
    
    
//    NSLog(@"%@",btn.titleLabel.text);
}


-(void)finishBtnClick {
    
    XFpostVC *finishVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];

    
        finishVC.labBtn1.titleLabel.text = self.labBtn1.titleLabel.text;
        finishVC.labBtn2.titleLabel.text = self.labBtn2.titleLabel.text;
        finishVC.labBtn3.titleLabel.text = self.labBtn3.titleLabel.text;
    
    finishVC.labBtn1.hidden = NO;
    finishVC.labBtn2.hidden = NO;
    finishVC.labBtn3.hidden = NO;

     [self.navigationController popToViewController:finishVC animated:YES];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
