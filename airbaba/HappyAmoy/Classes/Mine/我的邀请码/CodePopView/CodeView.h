//
//  CodeView.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/26.
//  Copyright © 2019年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CodeView : UIView
- (instancetype)initWithDict:(NSDictionary *)dict;
- (void)showView;

-(void)dismissAlertView;
@end

NS_ASSUME_NONNULL_END
