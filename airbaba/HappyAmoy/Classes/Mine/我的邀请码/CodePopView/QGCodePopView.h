//
//  QGCodePopView.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/26.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QGCodePopView : UIView
@property (nonatomic,copy)void(^closeBtnBlock)(void);

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *qCodeImageView;
@property (weak, nonatomic) IBOutlet UILabel *inviteCodeLabel;
@property (weak, nonatomic) IBOutlet UIButton *qcopyBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (nonatomic,strong)NSDictionary * dict;
@end

NS_ASSUME_NONNULL_END
