//
//  OrderTableViewCell.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/26.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *totalCount;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
//待付款的view
@property (weak, nonatomic) IBOutlet UIView *dfkView;
@property (weak, nonatomic) IBOutlet UIButton *goPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderBtn;
//待收货的view


//已完成的view
@end

NS_ASSUME_NONNULL_END
