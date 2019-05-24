//
//  UIColor+Lanmei.h
//  paiKe
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface UIColor (Lanmei)


/** 文字颜色 灰色*/
+(UIColor*)titleColor;
/** 文字颜色 灰色*/
+(UIColor*)textColor;
/**  文字颜色 */
+(UIColor*)timerColor;
/** 选中 */
+(UIColor*)selectColor;

/** 线条 灰色*/
+(UIColor*)lineColor;
/** 背景 */
+(UIColor*)backColor;

+(UIColor*)myGreenColor;
+(UIColor*)myRedColor;
+(UIColor*)myOrangeColor;


/** UIColor获取RGB值 @[r,g,b,a]*/
-(NSArray*)getColorRGBA;

//2. 16进制颜色值转换到RGB值（cocos2d-iPhone版）
+(UIColor*)colorWithHexString: (NSString *) stringToConvert andAlpha:(CGFloat)alpha;
/** 渐变色 [_view.layer addSublayer:CAGradientLayer] */
+ (CAGradientLayer *)shadowAsInverse:(CGRect)frame statrColor:(UIColor*)statrColor endColor:(UIColor*)endColor;

@end
