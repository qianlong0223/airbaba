//
//  waitingDeliveryController.m
//  DWQListOfDifferentOrderStatus
//
//  Created by 杜文全 on 15/11/1.
//  Copyright © 2015年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "waitingDeliveryController.h"
#import "OrderTableViewCell.h"
@interface waitingDeliveryController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation waitingDeliveryController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.view.frame = [UIScreen mainScreen].bounds;
//    //        //如果无网络
//    //        [self.view showErrorPageView];
//    //        [self.view configReloadAction:^{
//    //            NSLog(@"点击我就可以刷新了啊");
//    //        }];
//
//    //空数据
//    [self.view showBlankPageView];
//    //隐藏
//    //[self.view hideBlankPageView];
//}
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
//    cell.dfkView.hidden = YES;
    cell.dshView.hidden = YES;
    cell.qrshView.hidden = YES;
    cell.finishView.hidden = YES;
    [cell setCancelOrderBlock:^{
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        NSArray * array = @[@"地址信息填写错误",@"商品信息填写错误",@"其他",@"商品无货",@"不想要了",@"商品降价"];
        KPromptView * kproptView = [[KPromptView alloc]initWithFrame:window.frame title:@"取消订单" cellArray:array indexPath:nil];
        
        [window addSubview:kproptView];
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
