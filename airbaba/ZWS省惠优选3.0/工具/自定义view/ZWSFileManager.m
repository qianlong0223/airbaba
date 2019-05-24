//
//  ZWSFileManager.m
//  yixiuge
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ZWSFileManager.h"

static ZWSFileManager * fileManager;
@implementation ZWSFileManager
+(ZWSFileManager*)defaultManager
{
    if (fileManager==nil)
    {
        fileManager=[ZWSFileManager new];
    }
    return fileManager;
}

/** 缓存路径 Library/Cache*/
-(NSString *)getCachesFilePath:(NSString*)name
{
    
    return [NSString stringWithFormat:@"%@/%@",cachesFilePath,name];
}
/** 共享路径 Documents*/
-(NSString *)getDocumentsFilePath:(NSString*)name
{
    return [NSString stringWithFormat:@"%@/%@",documentsFilePath,name];
}
/**沙盒路径 */
-(NSString *)getPathForResourceFilePath:(NSString*)name
{
    return [[NSBundle mainBundle]pathForResource:name ofType:nil];
}


/**文件/文件夹是否存在*/
-(BOOL)isFileExistsAtPath:(NSString*)filePath
{
   return [self isFileExistsAtPath:filePath];
}

/**创建文件夹是*/
-(BOOL)setCreateDirectoryAtPath:(NSString*)filePath
{
    return [self createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
}
/**获取文件及目录的大小*/
// 计算整个文件夹中所有文件大小
-(float)sizeOfDirectory:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:filePath];
    if (isExist) {
        NSEnumerator *childFileEnumerator = [[fileManager subpathsAtPath:filePath] objectEnumerator];
        unsigned long long folderSize = 0;
        NSString *fileName = @"";
        while ((fileName = [childFileEnumerator nextObject]) != nil){
            NSString* fileAbsolutePath = [filePath stringByAppendingPathComponent:fileName];
            folderSize += [self sizeOfDirectory:fileAbsolutePath];
        }
        return folderSize / (1024.0 * 1024.0);
    } else {
        NSLog(@"file is not exist");
        return 0;
    }
}

/**写入文件*/
-(void)writeFile:(NSString *)path andData:(NSData*)data  andBlock:(void(^)(BOOL status))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL status= [self createFileAtPath:path contents:data attributes:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(status);
        });
    });
}
/**获取文件*/
-(void)getFile:(NSString *)path andBlock:(void(^)(id data))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data= [self contentsAtPath:path];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(data);
        });
    });
}
/**复制*/
-(void)copyFile:(NSString *)path topath:(NSString *)topath andBlock:(void(^)(BOOL status))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL status= [self copyItemAtPath:path toPath:topath error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(status);
        });
    });
}
/**移动/剪切*/
-(void)moveFile:(NSString *)path topath:(NSString *)topath andBlock:(void(^)(BOOL status))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL status= [self moveItemAtPath:path toPath:topath error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(status);
        });
    });
}
/**删除*/
-(void)deleteFile:(NSString *)path andBlock:(void(^)(BOOL status))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL status= [self removeItemAtPath:path error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(status);
        });
    });
}

@end
