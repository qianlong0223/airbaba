//
//  ZWSSearchAlertViewController.h
//  HappyAmoy
//
//  Created by 曾威盛 on 2018/10/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AlertViewViewController.h"

@class ZWSSearchAlertViewController;
@protocol ZWSSearchAlertViewControllerDelegate <NSObject>

-(void)searchAlertViewController:(ZWSSearchAlertViewController*)searchAlertViewController;

@end
NS_ASSUME_NONNULL_BEGIN

@interface ZWSSearchAlertViewController : AlertViewViewController

@property(nonatomic,weak)id<ZWSSearchAlertViewControllerDelegate>delegate;

@property(nonatomic,copy)NSString * keyword;

@end

NS_ASSUME_NONNULL_END
