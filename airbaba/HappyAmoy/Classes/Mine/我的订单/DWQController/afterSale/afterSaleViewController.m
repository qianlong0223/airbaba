//
//  afterSaleViewController.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/28.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "afterSaleViewController.h"
#import "OrderDetailViewController.h"
#import "OrderTableViewCell.h"
@interface afterSaleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UITableView *orderTableView;

@end

@implementation afterSaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.orderTableView];
}
#pragma mark - 数据源方法
// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString * JGFirstOneCellId = @"OrderTableViewCell";
    OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:JGFirstOneCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:JGFirstOneCellId owner:nil options:nil]lastObject];
    }
    cell.dfkView.hidden = YES;
    cell.dshView.hidden = YES;
    cell.qrshView.hidden = YES;
    cell.finishView.hidden = NO;
    [cell setOrderDetailBlock:^{
        OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 代理方法
/**
 *  设置行高
 */
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 219;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2;
}
// 添加每组的组头
- (UIView *)tableView:(nonnull UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

// 返回每组的组尾
- (UIView *)tableView:(nonnull UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

// 选中某行cell时会调用
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"选中didSelectRowAtIndexPath row = %ld", indexPath.row);
}

// 取消选中某行cell会调用 (当我选中第0行的时候，如果现在要改为选中第1行 - 》会先取消选中第0行，然后调用选中第1行的操作)
- (void)tableView:(nonnull UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSLog(@"取消选中 didDeselectRowAtIndexPath row = %ld ", indexPath.row);
}

@end
