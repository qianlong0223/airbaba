//
//  TableViewController.m
//  global
//
//  Created by apple on 16/3/30.
//  Copyright (c) 2016年 apple. All rights reserved.
//

#import "TableViewController.h"

//#import "UIImage+EMGIF.h"

@interface TableViewController ()

@end

@implementation TableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self tableView_registerClass];
    [self setData];
   
}

-(void)tableView_registerClass
{
    
}
-(void)setData
{
    [self addLegendFooterWithRefreshingTarget];
    [self addLegendHeaderWithRefreshingTarget];
}


/** 添加上拉加载*/
-(void)addLegendFooterWithRefreshingTarget
{
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loading)];
    
}
/** 添加下拉刷新*/

-(void)addLegendHeaderWithRefreshingTarget
{
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshing)];
    
}

/**mj 加载结束*/
-(void)endRefreshing
{
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    if ([self.tableView.mj_footer isRefreshing])
    {
        [self.tableView.mj_footer endRefreshing];
    }
    
}


-(void)refreshing
{
    [self.dataArr removeAllObjects];
    [self.tableView reloadData];
    self.page=1;
    self.tableView.mj_footer.hidden=YES;
    [self.tableView.mj_footer resetNoMoreData];

    [self.jsonData cancelAllOperations];
    [self loading];
}
#pragma mark 加载数据

-(void)loading
{
    
}
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, myDeviceScreenWidth, myDeviceScreenHeight) style:self.style];
        [self.view addSubview:_tableView];

        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.showsVerticalScrollIndicator=_tableView.showsHorizontalScrollIndicator=NO;
        _tableView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        _tableView.backgroundColor=
        [UIColor clearColor];
        _tableView.separatorColor=[UIColor lineColor];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
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
