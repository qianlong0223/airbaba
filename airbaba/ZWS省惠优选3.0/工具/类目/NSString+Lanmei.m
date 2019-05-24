//
//  NSString+Lanmei.m
//  paiKe
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+Lanmei.h"

@implementation NSString (Lanmei)


#pragma mark  // 拨打电话
- (BOOL)callPhone
{
    if ([self isMobileNumber])
    {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", self];
        return [callPhone openUrl];
    }
    
    return NO;
    
}
#pragma mark 打开浏览器
- (BOOL)openUrl
{
    UIApplication * application = [UIApplication sharedApplication];
    NSURL * openUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",self]];
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)])
    {
        [application openURL:openUrl options:@{} completionHandler:nil];
        return YES;
    }else
    return [application openURL:openUrl];
    
}
#pragma mark 是否手机号码
- (BOOL)isMobileNumber
{
    NSString *MOBILE = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9]|7[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

//判断是否为整形：
- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//用正则表达式 网址
- (BOOL)isUrl
{
    return [self rangeOfString:@"http"].length;
}
/**十六进制 转换 十进制*/
-(long long)get16to10
{
    unsigned long long result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanHexLongLong:&result];
    
    return result;
}

#pragma mark 文字高度
- (CGFloat)getTextHeight:(CGSize)size andAttDic:(NSDictionary *)dic
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
}



-(NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

+(NSString*)setDicToString:(id)dic
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:NULL];
    
    return [[NSString alloc] initWithData :data encoding : NSUTF8StringEncoding];
}

-(NSDictionary*)setStringtoDic
{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}
#pragma mark //翻译拼音 带音标
-(NSMutableString*)PinYinTranslationSoundmark
{
    NSMutableString *mstu = [[NSMutableString alloc] initWithString:self];
    //把中文翻译成 拼音
    if (CFStringTransform((__bridge CFMutableStringRef)mstu, 0, kCFStringTransformMandarinLatin, NO)) {
        
        return mstu;// wǒ shì zhōng guó rén
    }
    //把中文翻译成 拼音
    if (CFStringTransform((__bridge CFMutableStringRef)mstu, 0, kCFStringTransformStripDiacritics, NO)) {
        
        return mstu;// wo shi zhong guo ren
    }
    return mstu;
}
//翻译拼音
-(NSMutableString*)PinYinTranslation
{
    NSMutableString *mstu = [[NSMutableString alloc] initWithString:self];
    //把中文翻译成 拼音
    if (CFStringTransform((__bridge CFMutableStringRef)mstu, 0, kCFStringTransformMandarinLatin, NO)) {
        
        //        return mstu;// wǒ shì zhōng guó rén
    }
    //把中文翻译成 拼音
    if (CFStringTransform((__bridge CFMutableStringRef)mstu, 0, kCFStringTransformStripDiacritics, NO)) {
        
        return mstu;// wo shi zhong guo ren
    }
    return mstu;
}
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}


// 自适应尺寸大小
+ (NSString *)htmlAutoWebAutoImageWidth:(CGFloat)width andHtml:(NSString*)html
{
    NSString *str = [NSString stringWithFormat:@"<head><style>img{max-width:%f !important;height:auto}</style></head>%@",width,html];
    
    return str;
}


@end
