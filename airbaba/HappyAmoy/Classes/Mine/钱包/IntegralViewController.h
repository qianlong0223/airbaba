//
//  IntegralViewController.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/29.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "BaseViewControll.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntegralViewController : BaseViewControll
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *outMoney;
@property (weak, nonatomic) IBOutlet UILabel *inMoney;
@property (weak, nonatomic) IBOutlet UIButton *incomeDetail;
@property (weak, nonatomic) IBOutlet UIButton *tixianBtn;
@end

NS_ASSUME_NONNULL_END
