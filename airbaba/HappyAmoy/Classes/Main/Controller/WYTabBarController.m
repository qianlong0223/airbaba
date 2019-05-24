//
//  WYTabBarController.m
//  DianDian
//
//  Created by apple on 17/10/9.
//  Copyright © 2017年 com.chinajieyin.www. All rights reserved.
//

#import "WYTabBarController.h"
#import "WYNavigationController.h"
#import "HomeViewController.h"
#import "FreeDesignViewController.h"
#import "ServiceManagementViewController.h"
#import "DWQCartViewController.h"
#import "MineViewController.h"
@interface WYTabBarController ()

/**    上一次点击的tabBarButton    */
@property (strong, nonatomic) UITabBarItem *previousTabBarItem;

@end

@implementation WYTabBarController

+ (void)load {
    
    // 获取指定类的UITabBarItem
    
    UITabBarItem *tabbarItem;
    if ([[UIDevice currentDevice].systemVersion floatValue] < 9.0) {
        tabbarItem = [UITabBarItem appearanceWhenContainedIn:self,nil];
    } else {
        tabbarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    }
    
    // 创建一个描述颜色属性的字典
    NSMutableDictionary *selectedDict = [[NSMutableDictionary alloc] init];
    selectedDict[NSForegroundColorAttributeName] = QHMainColor;

    [tabbarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    
    // 设置字体大小：只有设置正常状态下的字体，才会生效
    // 创建一个描述字体大小属性的字典
    NSMutableDictionary *normalDict = [[NSMutableDictionary alloc] init];
    normalDict[NSFontAttributeName] = TextFont(12);
    normalDict[NSForegroundColorAttributeName] = ColorWithHexString(@"#999999");

    [tabbarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置子控制器
    [self setupAllChildControllers];
    
    // 设置对应的tabarItem
    [self setupAllTabbarItem];

    // 设置tabbar顶部黑线
    [self setupTabbarShadowImage];
//    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(didBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];

}
#pragma mark - 设置tabbar顶部黑线
- (void)setupTabbarShadowImage {
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [RGBA(215, 215, 215, 0.7) CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // 去掉tabbar顶部黑线
    [self.tabBar setBackgroundImage:[UIImage new]];
    [self.tabBar setShadowImage:img];
    
    self.tabBar.backgroundColor = QHWhiteColor;
}

#pragma mark - 添加子控制器
- (void)setupAllChildControllers {
    // 首页
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    WYNavigationController *nav = [[WYNavigationController alloc] initWithRootViewController:homeVc];
    
    [self addChildViewController:nav];
    
    // 报修管理
    ServiceManagementViewController *serviceManagementVc = [[ServiceManagementViewController alloc] init];
    WYNavigationController *nav1 = [[WYNavigationController alloc] initWithRootViewController:serviceManagementVc];
    [self addChildViewController:nav1];
    
    // 免费设计
    FreeDesignViewController *freeDesignVc = [[FreeDesignViewController alloc] init];
    WYNavigationController *nav2 = [[WYNavigationController alloc] initWithRootViewController:freeDesignVc];
    [self addChildViewController:nav2];

    // 购物车
    DWQCartViewController *shoppingCartVc = [[DWQCartViewController alloc] init];
    WYNavigationController *nav3 = [[WYNavigationController alloc] initWithRootViewController:shoppingCartVc];
    [self addChildViewController:nav3];
    
    //个人中心
    MineViewController *mineVc = [[MineViewController alloc] init];
    WYNavigationController *nav4 = [[WYNavigationController alloc] initWithRootViewController:mineVc];
    [self addChildViewController:nav4];
}

#pragma mark - 设置对应的tabbarItem
- (void)setupAllTabbarItem {
    
    UIOffset titleOffset = UIOffsetMake(0, -1);
    
    // 首页
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"首页";
    nav.tabBarItem.titlePositionAdjustment = titleOffset;
    nav.tabBarItem.image = [UIImage imageOriginalWithNamed:@"ic_home_nor"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithNamed:@"ic_home_selected"];

    // 报修管理
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"报修管理";
    nav1.tabBarItem.titlePositionAdjustment = titleOffset;
    nav1.tabBarItem.image = [UIImage imageOriginalWithNamed:@"报修"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithNamed:@"ic_repair_selected"];
    
    // 免费设计
    UINavigationController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"免费设计";
    nav2.tabBarItem.titlePositionAdjustment = titleOffset;
    nav2.tabBarItem.image = [UIImage imageOriginalWithNamed:@"设计师"];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithNamed:@"ic_freedesign_selected"];
    
    // 购物车
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"购物车";
    nav3.tabBarItem.titlePositionAdjustment = titleOffset;
    nav3.tabBarItem.image = [UIImage imageOriginalWithNamed:@"购物车 拷贝"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithNamed:@"ic_shoppingcart_selected"];


    // 我的
    UINavigationController *nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"个人中心";
    nav4.tabBarItem.titlePositionAdjustment = titleOffset;
    nav4.tabBarItem.image = [UIImage imageOriginalWithNamed:@"ic_my_nor"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithNamed:@"ic_my_selected"];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if (self.previousTabBarItem == item) {
        // 发出通知，让对应的控制器刷新
        [[NSNotificationCenter defaultCenter] postNotificationName:TabbarTitleButtonDidRepeatClickNotificationName object:nil];
    }
    
    self.previousTabBarItem = item;
}

#pragma mark - Public

- (void)dealloc {
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
