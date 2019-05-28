//
//  allOrderViewController.m
//  DWQListOfDifferentOrderStatus
//
//  Created by 杜文全 on 15/11/1.
//  Copyright © 2015年 com.iOSDeveloper.duwenquan. All rights reserved.
//
#define JianGe 10
#define GeShu 2

#import "allOrderViewController.h"
#import "OrderTableViewCell.h"
#import "QGRecommendCell.h"
@interface allOrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**    collectionview    */
@property (nonatomic,strong)UICollectionView * mycollection;
@property (nonatomic,strong)UIView * tableFooterView;
@end

@implementation allOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.orderTableView];
    [self createTableViewFooterView];
    
}
-(void)createTableViewFooterView{
    _tableFooterView = [[UIView alloc]init];
    _tableFooterView.backgroundColor = [UIColor clearColor];
    self.orderTableView.tableFooterView = _tableFooterView;
    _tableFooterView.sd_layout
    .leftSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .topSpaceToView(self, 0)
    .heightIs((_tableFooterView.width - JianGe*(GeShu+1)) / GeShu *1.5+60);
    UILabel * buytitle = [[UILabel alloc]init];
    buytitle.text = @"大家都在买";
    buytitle.textAlignment = 1;
    buytitle.textColor = [UIColor blackColor];
    [_tableFooterView addSubview:buytitle];
    buytitle.sd_layout
    .leftSpaceToView(_tableFooterView, 0)
    .rightSpaceToView(_tableFooterView, 0)
    .topSpaceToView(self, 0)
    .heightIs(40);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, _tableFooterView.width, _tableFooterView.height-40) collectionViewLayout:layout];
//    collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[QGRecommendCell class] forCellWithReuseIdentifier:@"QGRecommendCell"];
    self.mycollection = collectionView;
    [_tableFooterView addSubview:self.mycollection];
    
}
#pragma mark - 数据源方法
// 返回行数
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString * JGFirstOneCellId = @"OrderTableViewCell";
    OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:JGFirstOneCellId];
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
#pragma mark -- collectionView
//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    //宽高比1：1.5
    return CGSizeMake((_tableFooterView.width - JianGe*(GeShu+1)) / GeShu, (_tableFooterView.width - JianGe*(GeShu+1)) / GeShu *1.5 );
    
}


//定义每个UICollectionView 的边距

- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    
    return UIEdgeInsetsMake ( JianGe , JianGe , JianGe , JianGe );
    
}

//设置水平间距 (同一行的cell的左右间距）

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return JianGe;
    
}

//垂直间距 (同一列cell上下间距)

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return JianGe;
    
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //    return self.recommandArray.count;
    return 8;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section != 0) {
        return CGSizeMake(SCREEN_WIDTH, AUTOSIZESCALEX(5));
    }
    return CGSizeZero;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    return CGSizeMake(AUTOSIZESCALEX(150), AUTOSIZESCALEX(150));
//}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID= @"QGRecommendCell";
    QGRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
//-(UICollectionView *)mycollection{
//    if (_mycollection == nil) {
//
//
//        self.mycollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            //            [weakSelf getCollectionsDataWithPageNo:1];
//        }];
//
//        self.mycollection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            //            [weakSelf getCollectionsDataWithPageNo:_pageNo];
//        }];
//    }
//    return self.mycollection;
//}

@end
