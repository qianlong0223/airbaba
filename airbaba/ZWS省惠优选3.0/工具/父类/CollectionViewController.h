//
//  CollectionViewController.h
//  youku
//
//  Created by apple on 16/3/8.
//  Copyright (c) 2016年 apple. All rights reserved.
//

#import "ZWSViewController.h"


#define collectionViewFooterStatus(responseObject) [responseObject isKindOfClass:[NSArray class]]&&[responseObject count]&&[responseObject count]/20?:[self.collectionView.mj_footer endRefreshingWithNoMoreData];


@interface CollectionViewController : ZWSViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property(nonatomic,assign)NSInteger page;


/** 注册单元格*/
-(void)collectionView_registerClass;
-(void)setData;

/** 上拉加载*/
-(void)addLegendFooterWithRefreshingTarget;
/** 下拉刷新*/
-(void)addLegendHeaderWithRefreshingTarget;
/** 结束刷新*/
-(void)endRefreshing;

-(void)refreshing;

-(void)loading;

@property(nonatomic,strong)UICollectionViewFlowLayout * flowLayout;
@property(nonatomic,strong)UICollectionView * collectionView;

@end
