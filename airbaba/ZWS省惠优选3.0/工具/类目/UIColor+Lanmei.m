//
//  UIColor+Lanmei.m
//  paiKe
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIColor+Lanmei.h"

@implementation UIColor (Lanmei)
/** 文字颜色 灰色*/
+(UIColor*)titleColor
{
    return color(0, 0, 0, 1);
}
/** 线条 */
+(UIColor*)lineColor
{
    return color(205, 205, 205, 1);
}
/** 文字颜色*/
+(UIColor*)textColor
{
    return color(97, 97, 97, 1);
}
/**  文字颜色*/
+(UIColor*)timerColor
{
    return color(143, 143, 143, 1);
}

+(UIColor*)backColor
{
    return color(244, 244, 244, 1);
}
/** 选中 */
+(UIColor*)selectColor
{

    return color(21, 147, 240, 1);
}
+(UIColor*)myGreenColor
{
    return color(46, 185, 0, 1);
}
+(UIColor*)myRedColor
{
    return color(246, 46, 57, 1);
}
+(UIColor*)myOrangeColor
{
    return color(250, 164, 51, 1);
}


-(NSArray *)getColorRGBA
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    //    NSLog(@"Red: %f", components[0]);
    //    NSLog(@"Green: %f", components[1]);
    //    NSLog(@"Blue: %f", components[2]);
    //    NSLog(@"a: %f", components[3]);
    
    return @[[NSNumber numberWithFloat:components[0]],[NSNumber numberWithFloat:components[1]],[NSNumber numberWithFloat:components[2]],[NSNumber numberWithFloat:components[3]]];
}

+ (CAGradientLayer *)shadowAsInverse:(CGRect)frame statrColor:(UIColor*)statrColor endColor:(UIColor*)endColor
{
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    
    newShadow.frame = frame;
    //添加渐变的颜色组合
    newShadow.colors = [NSArray arrayWithObjects:(id)statrColor.CGColor,(id)endColor.CGColor,nil];
    return newShadow;
}

//2. 16进制颜色值转换到RGB值（cocos2d-iPhone版）
+(UIColor*)colorWithHexString: (NSString *) stringToConvert andAlpha:(CGFloat)alpha
{
    //去掉前后空格换行符
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
    return [UIColor whiteColor];
    
    if ([cString hasPrefix:@"0X"])
    cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"])
    cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6)
    return [UIColor whiteColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"r = %u, g = %u, b = %u",r, g, b);
    return color(r, g, b,alpha);
}

@end
