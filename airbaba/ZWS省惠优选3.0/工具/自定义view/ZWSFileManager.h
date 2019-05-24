//
//  ZWSFileManager.h
//  yixiuge
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


//缓存路径 Library/Cache
#define cachesFilePath NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0]

// 共享路径 Documents
#define documentsFilePath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]
//沙盒路径
#define resourceFilePath(name) [[ZWSFileManager defaultManager] getPathForResourceFilePath:name]



/** path 路径
 folder 文件夹
 fileName 文件名
 */
#define  getFilePath(path,folder,imageName) [NSString stringWithFormat:@"%@/%@/%@",path,folder,imageName]

@interface ZWSFileManager : NSFileManager

+(ZWSFileManager*)defaultManager;

/** 缓存路径 Library/Cache*/
-(NSString *)getCachesFilePath:(NSString*)name;
/** 共享路径 Documents*/
-(NSString *)getDocumentsFilePath:(NSString*)name;
/** 沙盒路径 */
-(NSString *)getPathForResourceFilePath:(NSString*)name;

/**文件/文件夹是否存在*/
-(BOOL)isFileExistsAtPath:(NSString*)filePath;
/**创建文件夹是*/
-(BOOL)setCreateDirectoryAtPath:(NSString*)filePath;
/**获取文件及目录的大小*/
-(float)sizeOfDirectory:(NSString *)filePath;

/**写入文件*/
-(void)writeFile:(NSString *)path andData:(NSData*)data  andBlock:(void(^)(BOOL status))block;
/**获取文件*/
-(void)getFile:(NSString *)path andBlock:(void(^)(id data))block;
/**复制*/
-(void)copyFile:(NSString *)path topath:(NSString *)topath andBlock:(void(^)(BOOL status))block;
/**移动/剪切*/
-(void)moveFile:(NSString *)path topath:(NSString *)topath andBlock:(void(^)(BOOL status))block;
/**删除*/
-(void)deleteFile:(NSString *)path andBlock:(void(^)(BOOL status))block;

@end

NS_ASSUME_NONNULL_END
