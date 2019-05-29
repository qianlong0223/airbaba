//
//  DiscountCouponViewController.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/29.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "DiscountCouponViewController.h"
#import "NonUserViewController.h"
#import "UserViewController.h"
#import "ValidViewController.h"
#import "LLSegmentBar.h"
#import "LLSegmentBarVC.h"
@interface DiscountCouponViewController ()
@property (nonatomic,weak) LLSegmentBarVC * segmentVC;
@end

@implementation DiscountCouponViewController
// lazy init
- (LLSegmentBarVC *)segmentVC{
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
        // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"优惠券";
    self.view.backgroundColor = [UIColor whiteColor];
    // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(0, kNavHeight,SCREEN_WIDTH, 50);
    [self.view addSubview:self.segmentVC.segmentBar];
    
    
    // 2 添加控制器的View
    self.segmentVC.view.frame = CGRectMake(0, kNavHeight+50,SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:self.segmentVC.view];
    
    
    NSArray *items = @[@"未使用",@"已使用",@"已失效"];
    NonUserViewController * vc0 = [[NonUserViewController alloc]init];
    UserViewController * vc1 = [[UserViewController alloc]init];
    ValidViewController * vc2 = [[ValidViewController alloc]init];
    
    // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[vc0,vc1,vc2]];
    
    
    // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemFont([UIFont systemFontOfSize:16]).itemNormalColor([UIColor grayColor]).itemSelectColor(QHMainColor).indicatorColor(QHMainColor);
    }];
}


@end
