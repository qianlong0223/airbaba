//
//  UIImage+Size.m
//  QiongLiao
//
//  Created by apple on 15/5/27.
//  Copyright (c) 2015年 Wynton. All rights reserved.
//

#import "UIImage+Lanmei.h"
#import "MyData.h"
@implementation UIImage (Lanmei)

+(void)load
{
    [self performSelectorOnMainThread:@selector(setCreateFilePath) withObject:nil waitUntilDone:NO];

}
+(void)setCreateFilePath
{
    [MyData getCreateFilePath:imageFilePath(@"")];

}
#pragma mark 图片缩放

+(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}
+(UIImage *)filePathName:(NSString*)imageName
{
    NSString*filePath=[[NSBundle mainBundle]pathForResource:imageName ofType:nil];
    
    return [[UIImage alloc]initWithContentsOfFile:filePath];
}
#pragma mark 等比例缩小
+(UIImage*)scaling:(UIImage*)image andSize:(CGSize)size
{
    CGFloat w=size.width/ (image.size.width*2);
    CGFloat h=size.height/ (image.size.height*2);
    
    CGSize imageSize;
    if (w>1&&h>1) {
        imageSize=CGSizeMake(image.size.width, image.size.height);
    }else
    if (w>h) {
        imageSize.width=image.size.width*h;
        imageSize.height=image.size.height*h;
    }
    else
    {
        imageSize.width=image.size.width*w;
        imageSize.height=image.size.height*w;
    }
        
    return [self reSizeImage:image toSize:imageSize];
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


//获得屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView
{
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView   atFrame:(CGRect)r
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(r);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

#pragma mark 写入文件
-(BOOL)fileManagerImageName:(NSString*)imageName
{
//    NSString* documentsFilePath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    imageName= [NSString stringWithFormat:@"%@/%@",documentsFilePath,imageName];
//    NSString *path_sandox = NSHomeDirectory();
//    //设置一个图片的存储路径
//    imageName= [NSString stringWithFormat:@"%@/Documents/%@",path_sandox,imageName];
    
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    NSLog(@"%@",imageFilePath(imageName));
    return [UIImagePNGRepresentation(self) writeToFile:imageFilePath(imageName) atomically:YES];
}
#pragma mark 获取数据
+(id)fileManagerImage:(NSString*)imageName
{
//    NSString* documentsFilePath= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    imageName= [NSString stringWithFormat:@"%@/%@",documentsFilePath,imageName];

    return [UIImage imageWithContentsOfFile:imageFilePath(imageName)];
}

#pragma mark 删除文件
+(BOOL)fileManagerRemoveImage:(NSString*)imageName
{
    return [[NSFileManager defaultManager]removeItemAtPath:imageFilePath(imageName) error:nil];
}

#pragma mark 获取数据
+(id)imageWithZip:(NSString*)imageName
{
//    NSString*filePath=[[NSBundle mainBundle]pathForResource:imageName ofType:nil];
//    return [[UIImage alloc]initWithContentsOfFile:filePath];
    
   
    
    return [UIImage imageWithContentsOfFile:imageFilePath(imageName)];
}


#pragma mark 3D 文字
//[UIImage create3DImageWithText:@"3" Font:[UIFont systemFontOfSize:250] ForegroundColor:[UIColor colorWithRed:(200/255.f) green:(200/255.f) blue:(200/255.f) alpha:1.0] ShadowColor:[UIColor blackColor] outlineColor:[UIColor colorWithRed:(225/255.f) green:(225/255.f) blue:(225/255.f) alpha:1.0] depth:8];
+ (UIImage *)create3DImageWithText:(NSString *)_text Font:(UIFont*)_font ForegroundColor:(UIColor*)_foregroundColor ShadowColor:(UIColor*)_shadowColor outlineColor:(UIColor*)_outlineColor depth:(int)_depth
{
    
    //calculate the size we will need for our text
    CGSize expectedSize = [_text sizeWithFont:_font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    
    //increase our size, as we will draw in 3d, so we need extra space for 3d depth + shadow with blur
    expectedSize.height+=_depth+5;
    expectedSize.width+=_depth+5;
    
    UIColor *_newColor;
    
    UIGraphicsBeginImageContextWithOptions(expectedSize, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //because we want to do a 3d depth effect, we are going to slightly decrease the color as we move back
    //so here we are going to create a color array that we will use with required depth levels
    NSMutableArray *_colorsArray = [[NSMutableArray alloc] initWithCapacity:_depth];
    
    CGFloat *components =  (CGFloat *)CGColorGetComponents(_foregroundColor.CGColor);
    
    //add as a first color in our array the original color
    [_colorsArray insertObject:_foregroundColor atIndex:0];
    
    //create a gradient of our color (darkening in the depth)
    int _colorStepSize = floor(100/_depth);
    
    for (int i=0; i<_depth; i++) {
        
        for (int k=0; k<3; k++) {
            if (components[k]>(_colorStepSize/255.f)) {
                components[k]-=(_colorStepSize/255.f);
            }
        }
        _newColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:CGColorGetAlpha(_foregroundColor.CGColor)];
        
        //we are inserting always at first index as we want this array of colors to be reversed (darkest color being the last)
        [_colorsArray insertObject:_newColor atIndex:0];
    }
    
    //we will draw repeated copies of our text, with the outline color and foreground color, starting from the deepest
    for (int i=0; i<_depth; i++) {
        
        //change color
        _newColor = (UIColor*)[_colorsArray objectAtIndex:i];
        
        //draw the text
        CGContextSaveGState(context);
        
        CGContextSetShouldAntialias(context, YES);
        
        //draw outline if this is the last layer (front one)
        if (i+1==_depth) {
            CGContextSetLineWidth(context, 1);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            
            CGContextSetTextDrawingMode(context, kCGTextStroke);
            [_outlineColor set];
            [_text drawAtPoint:CGPointMake(i, i) withFont:_font];
        }
        
        //draw filling
        [_newColor set];
        
        CGContextSetTextDrawingMode(context, kCGTextFill);
        
        //if this is the last layer (first one we draw), add the drop shadow too and the outline
        if (i==0) {
            CGContextSetShadowWithColor(context, CGSizeMake(-2, -2), 4.0f, _shadowColor.CGColor);
        }
        else if (i+1!=_depth){
            //add glow like blur
            CGContextSetShadowWithColor(context, CGSizeMake(-1, -1), 3.0f, _newColor.CGColor);
        }
        
        [_text drawAtPoint:CGPointMake(i, i) withFont:_font];
        CGContextRestoreGState(context);
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

+(UIImage *)imageWith3dString:(NSString *)text
{
    CGFloat fontSize = 150.0;
    CGFloat fontSizeDelta = 3.0;
    CGFloat fontOffset = 5.0;
    
    NSString *fontName = @"Bebas";
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    CGSize textSize = [text sizeWithFont:font
                       constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    
    CGSize size = CGSizeMake(textSize.width, fontSize);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(NULL,
                                             (int)size.width,
                                             (int)size.height,
                                             8,
                                             (int)(4 * size.width),
                                             colorSpace,
                                             kCGImageAlphaPremultipliedLast);
    
    // Draw with shadow
    CGContextSetShadowWithColor(ctx, CGSizeMake(0, 0), 10.0, [UIColor colorWithWhite:0.0 alpha:0.6].CGColor);
    
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 0.6);
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetLineWidth(ctx, 2.0);
    CGContextSetTextDrawingMode(ctx, kCGTextFillStroke);
    
    CGContextSetRGBFillColor(ctx, 222 / 255.0, 222 / 255.0, 222 / 255.0, 1.0);
    CGContextSetCharacterSpacing(ctx, 2.6);
    CGContextSelectFont(ctx, [fontName UTF8String], fontSize - fontSizeDelta, kCGEncodingMacRoman);
    CGContextShowTextAtPoint(ctx, 0.0, 3.0 + fontOffset, [text UTF8String], text.length);
    
    CGContextSetShadowWithColor(ctx, CGSizeZero, 0.0, NULL); // disable shadow
    CGContextSetCharacterSpacing(ctx, 1.0);
    CGContextSelectFont(ctx, [fontName UTF8String], fontSize, kCGEncodingMacRoman);
    CGContextShowTextAtPoint(ctx, 0.0, 3.0, [text UTF8String], text.length);
    
    
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    
    return image;
}

/** 文字 url转换二维码 */
+ (UIImage *)qrCodeImage:(NSString*)text withSize:(CGFloat) size
{
    
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = text;
    //    string=isApp_Name;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    
    
    return  [UIImage createNonInterpolatedUIImageFormCIImage:image withSize:size];
}

#pragma mark 高清 二维码
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}


@end
