//
//  OrderDetailViewController.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/6/9.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"
#import "OrderDetailFooterView.h"
@interface OrderDetailViewController ()
@property (weak, nonatomic) IBOutlet UITableView *orderDetailTable;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.orderDetailTable];
    
}
#pragma mark - 数据源方法
// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString * JGFirstOneCellId = @"OrderDetailTableViewCell";
    OrderDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:JGFirstOneCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:JGFirstOneCellId owner:nil options:nil]lastObject];
    }    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 代理方法
/**
 *  设置行高
 */
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 140;
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
    OrderDetailFooterView * footerView = [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailFooterView" owner:self options:nil]lastObject];
    footerView.backgroundColor = [UIColor whiteColor];
    return footerView;
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
