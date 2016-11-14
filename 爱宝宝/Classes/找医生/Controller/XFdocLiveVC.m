//
//  XFdocLiveVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/3.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFdocLiveVC.h"
#import "XFdocLiveCell.h"
#import "XFvideAfVC.h"

@interface XFdocLiveVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * table;
@end

@implementation XFdocLiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUPtable];
}


-(void)setUPtable {
    
    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    tab.dataSource = self;
    
    tab.separatorStyle = NO;
    tab.delegate = self;
    
    
    
    self.table = tab;
    self.table.rowHeight = 160;
    
    [self.view addSubview:tab];
    
    
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFdocLiveCell *cell = [XFdocLiveCell cellWithTableview:tableView];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    XFvideAfVC *vc = [[XFvideAfVC alloc]init];
    
    [self presentViewController:vc animated:YES completion:^{
        
        
    }];

}
-(void)viewWillAppear:(BOOL)animated {
    

    self.navigationController.navigationBarHidden = NO;
    self . tabBarController . tabBar . hidden = YES ;
}


@end
