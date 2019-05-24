//
//  CollectionViewController.m
//  youku
//
//  Created by apple on 16/3/8.
//  Copyright (c) 2016年 apple. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self collectionView_registerClass];
    [self setData];
}

#pragma mark 注册单元格
-(void)collectionView_registerClass
{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];

}


-(void)setData
{
    [self  addLegendFooterWithRefreshingTarget];
    [self  addLegendHeaderWithRefreshingTarget];
}



/** 添加上拉加载*/
-(void)addLegendFooterWithRefreshingTarget
{
    self.collectionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loading)];
    
}
/** 添加下拉刷新*/

-(void)addLegendHeaderWithRefreshingTarget
{
    self.collectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshing)];
    
}

/**mj 加载结束*/
-(void)endRefreshing
{
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    }
    if ([self.collectionView.mj_footer isRefreshing])
    {
        [self.collectionView.mj_footer endRefreshing];
    }
    
}


-(void)refreshing
{
    [self.dataArr removeAllObjects];
    [self.collectionView reloadData];
    self.page=1;
    self.collectionView.mj_footer.hidden=YES;
    [self.collectionView.mj_footer resetNoMoreData];
    
    [self.jsonData cancelAllOperations];
    [self loading];
}
#pragma mark 加载数据
-(void)loading
{
    
}
-(UICollectionViewFlowLayout *)flowLayout
{
    if (_flowLayout==nil) {
        _flowLayout=[UICollectionViewFlowLayout new];
    }
    return _flowLayout;
}
-(UICollectionView *)collectionView
{
    if (_collectionView ==nil)
    {
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, myDeviceScreenWidth, myDeviceScreenHeight) collectionViewLayout:self.flowLayout];
        [self.view addSubview:_collectionView];

        _collectionView.showsHorizontalScrollIndicator=_collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    }
    return _collectionView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor selectColor];
    return cell;
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
