//
//  XFfindHosVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/3.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFfindHosVC.h"

@interface XFfindHosVC ()

@end

@implementation XFfindHosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    self . tabBarController . tabBar . hidden = YES ;
}

@end
