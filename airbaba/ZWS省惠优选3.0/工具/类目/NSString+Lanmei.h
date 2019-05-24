//
//  NSString+Lanmei.h
//  paiKe
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CommonCrypto/CommonDigest.h>

@interface NSString (Lanmei)

/** 拨打电话 */
- (BOOL)callPhone;
/** 打开浏览器 */
- (BOOL)openUrl;
/** 是否手机号码 */
- (BOOL)isMobileNumber;

/**十六进制 转换 十进制*/
-(long long)get16to10;
//用正则表达式 网址
- (BOOL)isUrl;
//判断是否为整形：
- (BOOL)isPureInt;

/** 计算文字高度 */

- (CGFloat)getTextHeight:(CGSize)size andAttDic:(NSDictionary *)dic;

-(NSDictionary*)setStringtoDic;
/** html 设置图片最大宽度 */
+ (NSString *)htmlAutoWebAutoImageWidth:(CGFloat)width andHtml:(NSString*)html;

+(NSString*)setDicToString:(id)dic;

/** md5 加密*/
-(NSString *) md5HexDigest;

//翻译拼音 带音标
-(NSMutableString*)PinYinTranslationSoundmark;

//翻译拼音
-(NSMutableString*)PinYinTranslation;

//判断是否是纯汉字
- (BOOL)isChinese;
//判断是否含有汉字
- (BOOL)includeChinese;
@end
