//
//  UIImage+Size.h
//  QiongLiao
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 Wynton. All rights reserved.
//

#import <UIKit/UIKit.h>


#define imageFilePath(imageName) [NSString stringWithFormat:@"%@/imageSave/%@",cachesFilePath,imageName]

@interface UIImage (Lanmei)
/**按路径获取图片*/
+(UIImage *)filePathName:(NSString*)imageName;
/**图片缩放*/
+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize;
/**等比例缩小*/
+(UIImage*)scaling:(UIImage*)image andSize:(CGSize)size;

/**获得屏幕图像*/
+ (UIImage *)imageFromView: (UIView *) theView;
/**获得某个范围内的屏幕图像*/
+ (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r;
//图片颜色
-(UIImage *)imageWithColor:(UIColor *)color;

/** 储存图片*/
-(BOOL)fileManagerImageName:(NSString*)imageName;

/** 获取图片*/
+(id)fileManagerImage:(NSString*)imageName;
/** 删除文件 */
+(BOOL)fileManagerRemoveImage:(NSString*)imageName;
#pragma mark 获取数据
+(id)imageWithZip:(NSString*)imageName;

+ (UIImage *)create3DImageWithText:(NSString *)_text Font:(UIFont*)_font ForegroundColor:(UIColor*)_foregroundColor ShadowColor:(UIColor*)_shadowColor outlineColor:(UIColor*)_outlineColor depth:(int)_depth;

+ (UIImage *)imageWith3dString:(NSString *)text;

+ (UIImage *)qrCodeImage:(NSString*)text withSize:(CGFloat) size;

@end
