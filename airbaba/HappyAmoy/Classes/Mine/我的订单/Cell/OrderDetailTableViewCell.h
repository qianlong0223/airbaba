//
//  OrderDetailTableViewCell.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/6/9.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UIImageView *proImage;
@property (weak, nonatomic) IBOutlet UILabel *proName;
@property (weak, nonatomic) IBOutlet UILabel *proCount;
@property (weak, nonatomic) IBOutlet UILabel *proPrice;
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;

@end

NS_ASSUME_NONNULL_END
