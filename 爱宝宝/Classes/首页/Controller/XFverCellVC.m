//
//  XFverCellVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/11/1.
//  Copyright © 2016年 PUHIM. All rights reserved.
//

#import "XFverCellVC.h"
#import "XFverCellMod.h"
#import "XFverturCell.h"
#import "XFdetailedVC.h"

#import "MJRefresh.h"


@interface XFverCellVC ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView * table;
@property(nonatomic,strong) NSMutableArray * cellsList;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation XFverCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.typE;
    
    [self loadCellData];
    [self setUpTable];
    //mj上拉刷新下拉加载
    self. table.mj_header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData2)];
    self.table.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
-(void)loadMoreData {
    //            NSLog(@"下拉");
    NSString *str1 = [NSString stringWithFormat:@"page=%zd",++self.pagE];
   
    NSString *st1 = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/article?%@&type=%@",str1,self.typE];
    NSString *URLString = [st1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
                XFverCellMod   *news = [XFverCellMod initVerWithDict:obj];
                
                
                
                [tmpM addObject:news];
            }];
            
            // 什么时候数据加载完,就什么时候给数据源数组赋值
            if (tmpM.count) {
                
                NSMutableArray *arrM = [[NSMutableArray alloc] init];
                [arrM addObjectsFromArray:self.cellsList];
                [arrM addObjectsFromArray:tmpM.copy];
                self.cellsList = arrM;
                
                
                //                [self.modelArray insertObjects:tmpM.copy atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, tmpM.count -1)]];
                ////                [self.modelArray addObjectsFromArray:tmpM.copy];
                
                // 数据源数组什么时候有值,就什么时候刷新列表
                [self.table reloadData];            }
            
            
        } else {
            NSLog(@"%@",connectionError);
        }
    }];

    // 结束刷新
    [self.table.mj_footer endRefreshing];
}

//上拉刷新
-(void)loadData2 {
    
    //    NSLog(@"上拉");
    
    // 结束刷新
    [self.table.mj_header endRefreshing];
}

- (void)setUpTable {
    
    UITableView *tb = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tb.delegate = self;
    tb.dataSource = self;
    tb.rowHeight = 250;
    
    self.table = tb;
    
    [self.view addSubview:tb];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = NO;
    self . tabBarController . tabBar . hidden = YES ;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cellsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSLog(@"%zd",indexPath.row);
    XFdetailedVC *vc = [[XFdetailedVC alloc]init];
    
    XFverCellMod *mod = self.cellsList[indexPath.row];
    vc.article_id = mod.article_id;
    NSLog(@"%@",vc.article_id);
    //取消 cell 的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)loadCellData {
    
    /*
     NSString *str1 = [NSString stringWithFormat:@"name=%@",self.userId];
     NSString *str = [NSString stringWithFormat:@"&title=%@",self.cirle_title];
     NSString *str2 = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     */

    
    NSString *st1 = [NSString stringWithFormat:@"http://ma.beidaivf04.com/admin.php/Index/article?page=1&type=%@",self.typE];
    NSString *URLString = [st1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSString *URLString = @"http://ma.beidaivf04.com/admin.php/Index/hot_article?page=1";
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
            [self.table reloadData]; //这个  很重要?
            
            
        } else {
            NSLog(@"%@",connectionError);
        }
    }];
    
    
}


- (NSOperationQueue *)queue
{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

@end
