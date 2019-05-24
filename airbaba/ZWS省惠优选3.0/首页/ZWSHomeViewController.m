//
//  ZWSHomeViewController.m
//  HappyAmoy
//
//  Created by apple on 2018/10/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZWSHomeViewController.h"

#import "MySegmentedControl.h"

#import "ZWSHomeListViewController.h"
@interface ZWSHomeViewController ()<MySegmentedControlDelegate>

@property(nonatomic,weak)MySegmentedControl * mySegmentedControl;

@end

@implementation ZWSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataArr addObject:@{@"name":@"精选"}];

    self.scrollView.frame=CGRectMake(0, myHeight(self.mySegmentedControl), myDeviceScreenWidth, myDeviceScreenHeight-myHeight(self.mySegmentedControl));
    
    [self refreshing];
    [self addViewController:0];
    [self setBarButtonItem];
}

-(void)setBarButtonItem
{
   
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonPressed:)];
    
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed:)];
    
    self.navigationItem.leftBarButtonItem.width=40;
    
    UIButton * button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, myDeviceScreenWidth-80, 40)];
    button.layer.masksToBounds=YES;
    button.layer.cornerRadius=myHeight(button)/2;
    button.backgroundColor=[UIColor backColor];
    NSMutableAttributedString * mstr=[NSMutableAttributedString new];
    [mstr appendAttributedString:[NSAttributedString setImage:[UIImage imageNamed:@""] andRect:CGRectMake(0, 0, 30, 30)]];
    [mstr appendAttributedString:[[NSAttributedString alloc]initWithString:@" 输入商品关键字，搜索商品优惠劵" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:mytextFont],NSForegroundColorAttributeName:[UIColor whiteColor]}]];
    [button setAttributedTitle:mstr forState:UIControlStateNormal];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
//    button.contentEdgeInsets
    self.navigationItem.titleView=button;
}

-(void)leftButtonPressed:(UIBarButtonItem*)bar
{
    
}
-(void)rightButtonPressed:(UIBarButtonItem*)bar
{
    
}

-(MySegmentedControl *)mySegmentedControl
{
    if (_mySegmentedControl==nil) {
        MySegmentedControl * seg=[[MySegmentedControl alloc]initWithFrame:CGRectMake(0, 0, myDeviceScreenWidth, 40)];
        seg.dataArr=@[@{@"name":@"精选"}];
        seg.delegate=self;
        [self.view addSubview:seg];
        _mySegmentedControl=seg;
    }
    return _mySegmentedControl;
}
-(NSString *)mySegmentedControl:(MySegmentedControl *)mySegmentedControl andTextIndex:(NSInteger)index
{
    return mySegmentedControl.dataArr[index][@"name"];
}
-(void)mySegmentedControl:(MySegmentedControl *)mySegmentedControl andSelectIndex:(NSInteger)index
{
    [self addViewController:index];
}

#pragma mark 添加界面
-(void)addViewController:(NSInteger)index
{
    if ([self.dataArr[index]isKindOfClass:[UIViewController class]]) {
        return;
    }
    NSString * text=self.dataArr[index][@"name"];
    UIViewController * viewController=nil;

    if ([text containsString:@"精选"])
    {
        viewController=[ZWSHomeListViewController new];
    }
    if (viewController) {
        viewController.view.frame=CGRectMake(myDeviceScreenWidth*index,0, myDeviceScreenWidth, myHeight(self.scrollView));
        [self.scrollView addSubview:viewController.view];
        [self addChildViewController:viewController];
        
        self.dataArr[index]=viewController;
    }
}


-(void)refreshing
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    WeakSelf
    [[NetworkSingleton sharedManager] getRequestWithUrl:@"/commodity/categories" parameters:parameters successBlock:^(id response) {
        if ([response[@"code"] integerValue] == RequestSuccess)
        {
            id data=response[@"data"];
            if ([data isKindOfClass:[NSArray class]])
            {
                NSMutableArray * dataArr=[NSMutableArray new];
                [data addObject:@{@"name":@"精选"}];
                [dataArr addObjectsFromArray:data];
                weakSelf.dataArr=dataArr;
                weakSelf.mySegmentedControl.dataArr=dataArr;
                [weakSelf addViewController:0];
            }
        } else {
            [weakSelf showText:response[@"msg"]];
        }
    } failureBlock:^(NSString *error) {
        [weakSelf showFailure];

    }];
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
