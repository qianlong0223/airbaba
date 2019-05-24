//
//  HomeViewController.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/21.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "BaseViewControll.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : BaseViewControll
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray<UIViewController *>  *VCArray;
@end

NS_ASSUME_NONNULL_END
