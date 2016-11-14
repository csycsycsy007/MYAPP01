//
//  XFFourthVC.m
//  爱宝宝
//
//  Created by 小凡 席 on 16/9/13.
//  Copyright © 2016年 PUHIM. All rights reserved.
//
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "XFFourthVC.h"
#import "XFfourBtnLines.h"
@interface XFFourthVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak) UIButton *imgVBtn;
@property(nonatomic,weak) UIButton *nicNameBtn;

@property(nonatomic,strong) NSArray * settingA;

@property(nonatomic,strong) UIScrollView * scV;
@end

@implementation XFFourthVC

-(NSArray *)settingA
{
    _settingA = @[@"试管婴儿",@"分享给好友",@"设置"];
    return _settingA;
}

//,@"编辑资料",@"意见反馈",@"关于爱宝宝",@"版本检测",@"退出"

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpScrollView];
    [self setUpIcon];
    [self creatFourBtn];
    [self loadTable];

}


- (void)setUpIcon
{
    UIButton *imgBtn = [[UIButton alloc]init];
    [imgBtn setImage:[UIImage imageNamed:@"tx"] forState: UIControlStateNormal];

    [self.scV addSubview:imgBtn];
    
    [imgBtn makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.scV);
        make.size.equalTo(CGSizeMake(100, 100));
        make.top.equalTo(self.scV).offset(40);
    }];
    [imgBtn addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"昵称" forState: UIControlStateNormal];

    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.scV addSubview:btn];
    
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scV);
        make.top.equalTo(imgBtn).offset(120);
        make.size.equalTo(CGSizeMake(100, 21));
        NSLog(@"%@",btn);
    }];
    
    [btn addTarget:self action:@selector(nicNameClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arLab = @[@"关注",@"粉丝",@"等级",@"积分"];
    
    for (int i = 0; i<4; i++) {
        
        float a = [UIScreen mainScreen].bounds.size.width;
        
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake((a - 240)/5 + ((a - 240)/5 + 60)*i, 230, 60, 21)];
        
        lab.text = arLab[i];
        
        lab.textAlignment = UITextAlignmentCenter;
        
        [self.scV addSubview:lab];
        
        
        
    }
    
    
    for (int i = 0; i<4; i++) {
        
        float a = [UIScreen mainScreen].bounds.size.width;
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((a - 240)/5 + ((a - 240)/5 + 60)*i, 200, 60, 21)];
        
        [btn setTitle:@"0" forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        
        [self.scV addSubview: btn];
        
        btn.tag = i;
        
        [btn addTarget:self action:@selector(numberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
//标签按钮


//关注,粉丝,等级,积分
-(void)numberBtnClick:(UIButton *)btn {
    
    NSLog(@"%zd",btn.tag);
    
}


- (void)nicNameClick
{
//    修改用户名
    NSLog(@"在这里修改用户名");
    
}

- (void)imgBtnClick
{
    NSLog(@"点这里换头像");
}

- (void)creatFourBtn
{
    float a = [UIScreen mainScreen].bounds.size.width;


    XFfourBtnLines *vieW = [[XFfourBtnLines alloc]initWithFrame:CGRectMake(0, 260, a, 120)];
    vieW.backgroundColor = [UIColor whiteColor];
    
    
    [self.scV addSubview:vieW];
}

-(void)setUpScrollView {
    
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width , ([UIScreen mainScreen].bounds.size.height) - 64)];
    
    self.scV = sc;
    
    self.scV.contentSize = CGSizeMake(0, 880);
    
    
    
    [self.view addSubview:self.scV];
    
}

-(void)loadTable{
    
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 380, [UIScreen mainScreen].bounds.size.width, 500)];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 60;
    [self.scV addSubview:table];
    
    table.scrollEnabled = NO;
    
    
    
    
    
}
//数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSLog(@"zzzzzzzz");
    static NSString *ID = @"hero";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.settingA[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:@"圈子"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.row == 8) {
        
        tableView.rowHeight = 80;
        cell.textLabel.text = @"退出";
        cell.textAlignment = UITextAlignmentCenter;
        
    }
    
    
    return cell;
}


-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    
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

@end
