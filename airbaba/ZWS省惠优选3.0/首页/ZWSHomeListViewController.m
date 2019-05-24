//
//  ZWSHomeListViewController.m
//  HappyAmoy
//
//  Created by apple on 2018/10/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZWSHomeListViewController.h"

@interface ZWSHomeListViewController ()

@end

@implementation ZWSHomeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)setData
{
    [self.dataArr addObject:@[]];
    [self.dataArr addObject:@[]];
    [self.dataArr addObject:@[]];
    [self.dataArr addObject:@[]];
    [self.dataArr addObject:@[]];
}

-(void)collectionView_registerClass
{
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArr.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArr[section]count];
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
