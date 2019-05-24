//
//  HomeViewController.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/21.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "HomeViewController.h"
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "MLViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThrViewController.h"
#import "FouViewController.h"
@interface HomeViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) HMSegmentedControl *segmented;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, assign) NSInteger currentSelectIndex;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation HomeViewController
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
    [self setNavUI];
    MLViewController *vv = [[MLViewController alloc] init];
    OneViewController *one = [[OneViewController alloc] init];
    TwoViewController *two = [[TwoViewController alloc] init];
    ThrViewController *thr = [[ThrViewController alloc] init];
    FouViewController *fou = [[FouViewController alloc] init];
    
    self.VCArray = @[vv, one, two, thr, fou];
    self.sectionTitles = @[@"首页", @"类型1", @"类型2", @"类型3", @"类型4"];
    
    self.view.backgroundColor = ColorWithHexString(@"#F7F3F7");
    
    self.segmented.sectionTitles = self.sectionTitles;
    [self.pageVC setViewControllers:@[self.VCArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self.view addSubview:self.segmented];
    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    
}
-(void)setNavUI{
    //左item
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _messageBtn.frame = CGRectMake(0, 0, 44, 44);
    _messageBtn.adjustsImageWhenHighlighted = NO;
    [_messageBtn setImage:ImageWithNamed(@"ic_message_nor") forState:UIControlStateNormal];
    [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:_messageBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = 12;//ios7以后右边距默认值18px，负数相当于右移，正数左移
    self.navigationItem.leftBarButtonItems=@[negativeSpacer,item];
    //右item
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, 0, 44, 44);
    _selectBtn.adjustsImageWhenHighlighted = NO;
    [_selectBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [_selectBtn setTitleColor:ColorWithHexString(@"#222222") forState:UIControlStateNormal];
    _selectBtn.titleLabel.font = TextFont(14);
    [_selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1=[[UIBarButtonItem alloc]initWithCustomView:_selectBtn];
    UIBarButtonItem *negativeSpacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer1.width = -12;//ios7以后右边距默认值18px，负数相当于右移，正数左移
    self.navigationItem.rightBarButtonItems=@[negativeSpacer1,item1];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(10, 10, SCREEN_WIDTH - 100, 30);
    _searchBtn.backgroundColor = QHWhiteColor;
    [_searchBtn setTitle:@"搜索你想要的商品名称" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = TextFont(14);
    [_searchBtn setTitleColor:ColorWithHexString(@"#999999") forState:UIControlStateNormal];
    _searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20 , 0, -20);
    _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30 , 0, -30);
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_searchBtn addTarget:self action:@selector(homePageSearchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _searchBtn;
    ViewRadius(_searchBtn, 15);
    _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 16, 16)];
    _searchImageView.image = [UIImage imageNamed:@"ic_search_nor"];
    [_searchBtn addSubview:_searchImageView];
}
-(void)selectAction{
    
}

-(void)messageAction{
    
}
-(void)homePageSearchButtonClick{
    
}
#pragma mark - UIPageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.VCArray indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    return (UIViewController *)[self.VCArray objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.VCArray indexOfObject:viewController];
    if(index == NSNotFound || index == self.VCArray.count - 1) {
        return nil;
    }
    return (UIViewController *)[self.VCArray objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(nonnull NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.pageVC.viewControllers[0];
    NSUInteger index = [self.VCArray indexOfObject:viewController];
    self.currentSelectIndex = index;
    [self.segmented setSelectedSegmentIndex:index animated:YES];
}

- (void)segmentedControlChangedValue:(UISegmentedControl *)segment {
    long index = segment.selectedSegmentIndex;
    [self navigationDidSelectedControllerIndex:index];
}

- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    if (index == 0) {
        [self.pageVC setViewControllers:@[[self.VCArray objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }
    else {
        [self.pageVC setViewControllers:@[[self.VCArray objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                options:options];
        _pageVC.view.frame = CGRectMake(0, kNavHeight+40, SCREEN_WIDTH, SCREEN_HEIGHT-kNavHeight-40);
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    return _pageVC;
}

- (HMSegmentedControl *)segmented {
    if (!_segmented) {
        _segmented = [[HMSegmentedControl alloc] init];
        _segmented.frame = CGRectMake(0, kNavHeight, SCREEN_WIDTH, 40);
        _segmented.selectionIndicatorHeight = 2.0f;
        _segmented.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmented.backgroundColor = ColorWithHexString(@"#F7F3F7");
        _segmented.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSFontAttributeName] = TextFont(14);
        dict[NSForegroundColorAttributeName] = ColorWithHexString(@"#222222");
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
        dict1[NSFontAttributeName] = TextFontBold(14);
        dict1[NSForegroundColorAttributeName] = ColorWithHexString(@"#222222");
        _segmented.titleTextAttributes = dict;
        _segmented.selectedTitleTextAttributes = dict1;
        _currentSelectIndex = 0;
        _segmented.selectedSegmentIndex = _currentSelectIndex;
        [_segmented addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmented;
}

@end
