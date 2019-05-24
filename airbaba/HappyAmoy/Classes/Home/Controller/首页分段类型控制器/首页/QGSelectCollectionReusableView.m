//
//  QGSelectCollectionReusableView.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/3/26.
//  Copyright © 2019年 apple. All rights reserved.
//



#import "QGSelectCollectionReusableView.h"
#import "QGRecommendCell.h"
#import "MidContainerCollectionViewCell.h"
@interface QGSelectCollectionReusableView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *MyCollectionView1;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *myLayout1;
@property (weak, nonatomic) IBOutlet UIView *midContainerView;

/**    轮播图    */
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

/**    banner数组    */
@property (strong, nonatomic) NSMutableArray *bannerArray;


@end



@implementation QGSelectCollectionReusableView


//分类点击事件实现

- (IBAction)categoryBtnTouch:(UIButton *)sender {
    
    if (self.categoryTouch) {
        
        self.categoryTouch(sender.tag);
    }
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID= @"MidContainerCollectionViewCell";
    MidContainerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.myLayout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.myLayout1.minimumInteritemSpacing = 2;
    self.myLayout1.itemSize=CGSizeMake((SCREEN_WIDTH-20)/4, 150);  //设置每个单元格的大小
    self.myLayout1.sectionInset=UIEdgeInsetsMake(0, 2, 0, 2);
    self.MyCollectionView1.backgroundColor=[UIColor clearColor];
    self.MyCollectionView1.delegate=self;
    self.MyCollectionView1.dataSource=self;
    //注册cell
    [self.MyCollectionView1 registerClass:[MidContainerCollectionViewCell class] forCellWithReuseIdentifier:@"MidContainerCollectionViewCell"];
    
    [self.midContainerView addSubview:self.MyCollectionView1];

}



@end
