//
//  MineViewController.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/21.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadView.h"
#import "CodeView.h"
#import "MoneyViewController.h"
#import "IntegralViewController.h"
#import "DiscountCouponViewController.h"
#import "DWQOrderListViewController.h"
#import "allOrderViewController.h"
#import "waitingEvaluateController.h"
#import "waitingDeliveryController.h"
#import "waitingReceiveController.h"
#import "waitingPayController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * mineTable;
@property (nonatomic,strong)NSMutableArray * dataSource;
@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated{
    
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated{
    
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    self.mineTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mineTable.tableFooterView = [[UIView alloc]init];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
// 返回组头部view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 525;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.01;
}
//返回组头部view方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
//返回组头部view方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MineHeadView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"MineHeadView" owner:self options:nil]lastObject];
    [headerView setQcodeBtnBlock:^{
        CodeView * popview = [[CodeView alloc]initWithDict:@{@"image":@"img_qrcode_nor",@"code":@"20190526"}];
        [popview showView];
    }];
    [headerView setScanOrderBtnBlock:^{
        DWQOrderListViewController *dwqlistOrder=[[DWQOrderListViewController alloc]init];
        dwqlistOrder.index=0;
        [self.navigationController pushViewController:dwqlistOrder animated:YES];
    }];
    [headerView setDfkBtnBlock:^{
        DWQOrderListViewController *dwqlistOrder=[[DWQOrderListViewController alloc]init];
        dwqlistOrder.index=1;
        [self.navigationController pushViewController:dwqlistOrder animated:YES];
    }];
    [headerView setDfhBtnBlock:^{
        DWQOrderListViewController *dwqlistOrder=[[DWQOrderListViewController alloc]init];
        dwqlistOrder.index=1;
        [self.navigationController pushViewController:dwqlistOrder animated:YES];
    }];
    [headerView setDshBtnBlock:^{
        DWQOrderListViewController *dwqlistOrder=[[DWQOrderListViewController alloc]init];
        dwqlistOrder.index=2;
        [self.navigationController pushViewController:dwqlistOrder animated:YES];
    }];

    [headerView setDpjBtnBlock:^{
        DWQOrderListViewController *dwqlistOrder=[[DWQOrderListViewController alloc]init];
        dwqlistOrder.index=4;
        [self.navigationController pushViewController:dwqlistOrder animated:YES];
    }];
    [headerView setMoneyBtnBlock:^{
        MoneyViewController * vc = [[MoneyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [headerView setIntegralBtnBlock:^{
        IntegralViewController * vc = [[IntegralViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [headerView setDiscountCouponBtnBlock:^{
        DiscountCouponViewController * vc = [[DiscountCouponViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return headerView;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * identifier= @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}
-(UITableView *)mineTable{
    if (_mineTable == nil) {
        _mineTable = [[UITableView alloc]initWithFrame:CGRectMake(0,-kNavHeight, SCREEN_WIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mineTable.delegate = self;
        _mineTable.dataSource = self;
        _mineTable.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:self.mineTable];
        
    }
    return _mineTable;
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
