//
//  QGRecommendCell.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/3/28.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QGRecommendCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iamageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tbName;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *sellNum;

@end
