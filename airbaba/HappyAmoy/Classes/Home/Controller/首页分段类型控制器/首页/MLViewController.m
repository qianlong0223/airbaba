//
//  MLViewController.m
//  MLPageVC
//
//  Created by 玛丽 on 2017/12/11.
//  Copyright © 2017年 玛丽. All rights reserved.
//

#define JianGe 10
#define GeShu 2
#import "MLViewController.h"
#import "QGSelectCollectionReusableView.h"
#import "QGRecommendCell.h"
@interface MLViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**    collectionview    */
@property (nonatomic,strong)UICollectionView * mycollection;
/**    轮播图    */
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
/**    顶部banner    */
@property (strong, nonatomic) NSMutableArray *bannerArray;
/**    为你推荐    */
@property (strong, nonatomic) NSMutableArray *recommandArray;
@end
static NSString * const reuseIdentifierHeader =  @"QGSelectCollectionReusableView";
@implementation MLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ColorWithHexString(@"#F7F3F7");
    [self.view addSubview:self.mycollection];
    [self.mycollection.mj_header beginRefreshing];
}
//为你推荐
-(NSMutableArray *)recommandArray{
    if (_recommandArray == nil) {
        _recommandArray = [[NSMutableArray alloc]init];
    }
    return _recommandArray;
}
//顶部轮播
- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
//        WeakSelf
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160) delegate:nil placeholderImage:PlaceHolderMainImage];
        cycleScrollView.localizationImageNamesGroup = @[ImageWithNamed(@"banner")];
        cycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
//            if (weakSelf.bannerArray.count == 0) {
//                return ;
//                [WYPackagePhotoBrowser showPhotoWithImageArray:[NSMutableArray arrayWithObject:ImageWithNamed(@"banner")] currentIndex:0];
//            }
//            else {
//                BannerItem *item = weakSelf.bannerArray[currentIndex];
                
//                if (item.urlType == 1) { // 页面url
//                    WebViewController *webVc = [[WebViewController alloc] init];
//                    webVc.urlString = item.target;
//                    webVc.title = item.title;
//                    [weakSelf.navigationController pushViewController:webVc animated:YES];
                    //                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:item.target]]) {
                    //                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.target]];
                    //                    }
//                } else if (item.urlType == 2) { // 特色分类列表
//                    GoodsListOfNewController *listVc = [[GoodsListOfNewController alloc] init];
//                    listVc.specialCategoriesId = item.target;
//                    listVc.title = item.title;
//                    [weakSelf.navigationController pushViewController:listVc animated:YES];
//                }
//                [weakSelf didClickBannerWithBannerId:item.bannerId];
//            }
        };
        _cycleScrollView = cycleScrollView;
    }
    return _cycleScrollView;
}
-(UICollectionView *)mycollection{
    if (_mycollection == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavHeight) collectionViewLayout:layout];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        //        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
        
        [collectionView registerNib:[UINib nibWithNibName:@"QGSelectCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader];
        [collectionView registerClass:[QGRecommendCell class] forCellWithReuseIdentifier:@"QGRecommendCell"];
        
        self.mycollection = collectionView;
        
        WeakSelf
        self.mycollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            [weakSelf getCollectionsDataWithPageNo:1];
        }];
        
        self.mycollection.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            [weakSelf getCollectionsDataWithPageNo:_pageNo];
        }];
    }
    return _mycollection;
}
#pragma mark - Data
//- (void)getCollectionsDataWithPageNo:(NSInteger)pageNo {
//
//    WeakSelf
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"page"] = [NSString stringWithFormat:@"%zd",pageNo];
//    parameters[@"size"] = [NSString stringWithFormat:@"%zd",PageSize];
//    [[NetworkSingleton sharedManager] getRequestWithUrl:@"/api/home/recommended" parameters:parameters successBlock:^(id response) {
//        if ([response[@"code"] integerValue] == RequestSuccess) {
//            if (pageNo == 1) {
//                weakSelf.pageNo = 1;
//                weakSelf.recommandArray = [QGRecommendListModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"datas"]];
//            } else {
//                [weakSelf.recommandArray addObjectsFromArray:[QGRecommendListModel mj_objectArrayWithKeyValuesArray:response[@"data"][@"datas"]]];
//            }
//            if ([response[@"data"][@"datas"] count] == 0) {
//                [weakSelf.mycollection.mj_footer endRefreshingWithNoMoreData];
//            } else {
//                if ((weakSelf.recommandArray.count % PageSize != 0) || weakSelf.recommandArray.count == 0) { // 有余数说明没有下一页了
//                    [weakSelf.mycollection.mj_footer endRefreshingWithNoMoreData];
//                } else {
//                    weakSelf.pageNo++;
//                    [weakSelf.mycollection.mj_footer endRefreshing];
//                }
//            }
//
//            [weakSelf.mycollection reloadData];
//
//        } else {
//            [weakSelf.mycollection.mj_footer endRefreshing];
//            [WYProgress showErrorWithStatus:response[@"msg"]];
//        }
//        [weakSelf.mycollection.mj_header endRefreshing];
//
//    } failureBlock:^(NSString *error) {
//        [weakSelf.mycollection.mj_header endRefreshing];
//        [weakSelf.mycollection.mj_footer endRefreshing];
//    } shouldDismissHud:NO];
//}

//定义每个UICollectionView 的大小

- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath {
    //宽高比1：1.5
    return CGSizeMake((SCREEN_WIDTH - JianGe*(GeShu+1)) / GeShu, (SCREEN_WIDTH - JianGe*(GeShu+1)) / GeShu *1.5 );
    
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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        QGSelectCollectionReusableView *view = (QGSelectCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        headerView = view;
        view.button1.btnType = TOP;
        view.button2.btnType = TOP;
        view.button3.btnType = TOP;
        view.button4.btnType = TOP;
        view.button6.btnType = TOP;
        view.button7.btnType = TOP;
        view.button8.btnType = TOP;
        view.button9.btnType = TOP;
        [view.bannerView addSubview:self.cycleScrollView];
        [view setCategoryTouch:^(NSInteger tag) {
            //            CommoditySpecialCategoriesItem *item = self.commoditySpecialCategory[indexPath.row];
            
        }];
        
    }
    return headerView;
}
// 设置Header的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    return CGSizeMake(screenWidth, 900);
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
    if (self.recommandArray.count) {
//        cell.model = self.recommandArray[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
