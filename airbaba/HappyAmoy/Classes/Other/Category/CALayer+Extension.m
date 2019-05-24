//
//  CALayer+Extension.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/3/27.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "CALayer+Extension.h"
@implementation CALayer (Extension)
- (void)setBorderColorFromUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}
@end
