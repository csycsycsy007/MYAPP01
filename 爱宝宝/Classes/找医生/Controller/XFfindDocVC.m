//
//  XFfindDocVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/3.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFfindDocVC.h"
#import "XFfindCell.h"


@interface XFfindDocVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * table;

@end

@implementation XFfindDocVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUPtable];
}

-(void)setUPtable {
    
    UITableView *tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    tab.dataSource = self;
    
    tab.delegate = self;
    
    self.table = tab;
    self.table.rowHeight = 160;
    
    [self.view addSubview:tab];
    
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XFfindCell *cell = [XFfindCell cellWithTableview:tableView];
    
    return cell;
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
