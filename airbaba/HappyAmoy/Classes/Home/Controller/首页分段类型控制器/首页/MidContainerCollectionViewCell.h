//
//  MidContainerCollectionViewCell.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/22.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MidContainerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@end

NS_ASSUME_NONNULL_END
