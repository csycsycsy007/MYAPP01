//
//  XFRootVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/13.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFRootVC.h"
#import "XFFirstVC.h"
#import "XFSecondVC.h"
#import "XFThirdVC.h"
#import "XFFourthVC.h"


@interface XFRootVC ()

@end

@implementation XFRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setUpAllChildViewController];

}



-(void)setUpAllChildViewController
{
    //1.
    XFFirstVC *fiVC = [[XFFirstVC alloc]init];
    [self setUpOneChildViewController:fiVC image:[UIImage imageNamed:@"首页"] title:@"首页" selectedImage:[UIImage imageNamed:@"首页1"]];

    
    
    
    //2.
    XFSecondVC *sVC = [[XFSecondVC alloc]init];
    [self setUpOneChildViewController:sVC image:[UIImage imageNamed:@"找医院"] title:@"发现" selectedImage:[UIImage imageNamed:@"找医院1"]];

  
    //3.
    XFThirdVC *tVC = [[XFThirdVC alloc]init];
    [self setUpOneChildViewController:tVC image:[UIImage imageNamed:@"圈子"] title:@"圈子" selectedImage:[UIImage imageNamed:@"圈子1"]];
    
//    //4.

    XFFourthVC *foVC = [[XFFourthVC alloc]init];
    [self setUpOneChildViewController:foVC image:[UIImage imageNamed:@"我"] title:@"我" selectedImage:[UIImage imageNamed:@"我1"]];
    

    
}

-(void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image title:(NSString *)title selectedImage:(UIImage *)image2
{
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:viewController];
    
    navVC.title = title;
    
    navVC.tabBarItem.image = image;
    image2 = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navVC.tabBarItem setSelectedImage:image2];
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:246/255.0 green:75/255.0 blue:132/255.0 alpha:1.0] forKey:NSForegroundColorAttributeName];
    [navVC.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    
    
    
//    [navVC setNavigationBarHidden:YES animated:YES];
    
    
    
    //展示 nav
//    [navVC.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
//    viewController.navigationItem.title = title;
    

    [self addChildViewController:navVC];
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
-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    
    
}

@end
