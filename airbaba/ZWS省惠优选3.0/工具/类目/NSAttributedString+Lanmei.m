//
//  NSAttributedString+Lanmei.m
//  paiKe
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSAttributedString+Lanmei.h"

@implementation NSAttributedString (Lanmei)
+(NSAttributedString *)setImage:(UIImage*)image andRect:(CGRect)frame
{
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = image;
    // 设置图片大小
    attch.bounds = frame;
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    return string;
}

+(NSAttributedString*)setoldPriceLabelText:(NSString*)string
{
#pragma mark 画删除线
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    
    
    [attString addAttribute:NSUnderlineStyleAttributeName value:@( NSUnderlineStyleSingle) range:NSMakeRange(0,string.length)];
    
    [attString addAttribute:NSUnderlineStyleAttributeName value:[UIColor grayColor] range:NSMakeRange(0, string.length)];
    
    return attString;
}
+(NSAttributedString*)setHtml:(NSString*)html
{
    return [[NSAttributedString alloc]initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute :NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

-(CGFloat)setHeight:(CGSize)size
{
    //string 为要计算高的NSAttributedString
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
}

@end
