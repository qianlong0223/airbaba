//
//  NSAttributedString+Lanmei.h
//  paiKe
//
//  Created by apple on 2018/7/13.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Lanmei)
/** 图片 转换 文字*/
+(NSAttributedString *)setImage:(UIImage*)image andRect:(CGRect)frame;
/**画删除线 */
+(NSAttributedString*)setoldPriceLabelText:(NSString*)string;
/**html 转换 */
+(NSAttributedString*)setHtml:(NSString*)html;
/** 计算高度 */
-(CGFloat)setHeight:(CGSize)size;

@end
