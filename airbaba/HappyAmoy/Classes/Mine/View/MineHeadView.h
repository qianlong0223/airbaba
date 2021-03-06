//
//  MineHeadView.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/23.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineHeadView : UIView
@property (weak, nonatomic) IBOutlet UIView *userInfoBgView;
@property (weak, nonatomic) IBOutlet UIView *orderInfoBgView;
@property (weak, nonatomic) IBOutlet UIView *toolInfoBgView;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UIButton *qCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *memberBtn;
@property (weak, nonatomic) IBOutlet UIButton *ticketBtn;
@property (weak, nonatomic) IBOutlet UILabel *ticketCount;
@property (weak, nonatomic) IBOutlet UILabel *intergl;
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UIButton *interglBtn;

@property (weak, nonatomic) IBOutlet UIButton *walletBtn;
@property (weak, nonatomic) IBOutlet UIButton *scanOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *dfkBtn;
@property (weak, nonatomic) IBOutlet UIButton *dfhBtn;
@property (weak, nonatomic) IBOutlet UIButton *dshBtn;
@property (weak, nonatomic) IBOutlet UIButton *dpjBtn;


@end

NS_ASSUME_NONNULL_END
