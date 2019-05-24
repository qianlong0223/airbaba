//
//  TableViewController.h
//  global
//
//  Created by apple on 16/3/30.
//  Copyright (c) 2016年 apple. All rights reserved.
//

#import "ZWSViewController.h"


#define tableViewFooterStatus(responseObject) [responseObject isKindOfClass:[NSArray class]]&&[responseObject count]&&[responseObject count]/20?:[self.tableView.mj_footer endRefreshingWithNoMoreData];

@interface TableViewController : ZWSViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic)UITableViewStyle style;

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,assign)NSInteger page;

/** 注册单元格*/
-(void)tableView_registerClass;

-(void)setData;

/** 上拉加载*/
-(void)addLegendFooterWithRefreshingTarget;
/** 下拉刷新*/
-(void)addLegendHeaderWithRefreshingTarget;
/** 结束刷新*/
-(void)endRefreshing;

-(void)refreshing;

-(void)loading;

@end
