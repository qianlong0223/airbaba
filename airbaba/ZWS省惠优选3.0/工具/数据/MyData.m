//
//  MyData.m
//  商会之家
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MyData.h"

// 获取当前设备可用内存及所占内存的头文件
#import <sys/sysctl.h>
#import <mach/mach.h>
#include <sys/mount.h>

@implementation MyData

+(void)load
{
    
    [self performSelectorOnMainThread:@selector(setCreateFilePath) withObject:nil waitUntilDone:NO];
}
+(void)setCreateFilePath
{
    //创建Documents下的other文件夹（目录）
    [MyData getCreateFilePath:plistFilePath(@"")];
    [MyData getCreateFilePath:getFilePath(cachesFilePath, @"userFilePath", @"")];
}


#pragma mark  文件路径
/**缓存路径*/
+(NSString*)filePath:(NSString*)fileName
{
    return plistFilePath(fileName);
}
/**缓存路径 文件夹*/
+(NSString* )getCreateFilePath:(NSString*)fileName
{
    fileName=[NSString stringWithFormat:@"%@",fileName];
    
    //用文件管理器创建目录
    if ([[NSFileManager defaultManager] createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:nil]) {
        
        NSLog(@"创建目录成功");
    }
    
    return fileName;
}
#pragma mark 文件路径
/**文件 路径*/
+(NSString*)filePathDirectory:(NSString*)fileName
{
    
    return plistFilePath(fileName);
}

#pragma mark 写入文件
+(BOOL)fileManagerPlist:(id)dic andFileName:(NSString*)fileName
{
    //创建一个归档器，并指明归档的 Data对象
    //作用是 数据转换操作
    fileName=[NSString stringWithFormat:@"%@.plist",fileName];

   return fileName.length?
    [NSKeyedArchiver archiveRootObject:dic toFile:[MyData filePath:fileName]]:NO;
}


+(id)fileManagerPlist:(NSString*)fileName
{
    if (fileName.length)
    {
        fileName=[NSString stringWithFormat:@"%@.plist",fileName];
        return [NSKeyedUnarchiver unarchiveObjectWithFile:[MyData filePath:fileName]];
    }
    return [NSDictionary new];
}
+(BOOL)removePlistFile:(NSString*)fileName
{
    fileName=[NSString stringWithFormat:@"%@.plist",fileName];
    return [[NSFileManager defaultManager]removeItemAtPath:[MyData filePath:fileName] error:nil];
    
}
#pragma mark 写入文件
+(BOOL)fileManager:(id)dic andFileName:(NSString*)fileName
{
    //创建一个归档器，并指明归档的 Data对象
    //作用是 数据转换操作
    fileName =[NSString stringWithFormat:@"%@",fileName];
    if (dic==nil||[dic isEqual:[NSNull null]])
    {
        dic=@{};
    }
    return fileName.length?
    [NSKeyedArchiver archiveRootObject:dic toFile:fileName]:NO;
}
#pragma mark 获取数据

+(id)fileManager:(NSString*)fileName
{
    if (fileName.length)
    {
        fileName=[NSString stringWithFormat:@"%@",fileName];
        
        return [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    }
    return [NSDictionary new];
}

+(BOOL)removeFile:(NSString*)fileName
{
    fileName =[NSString stringWithFormat:@"%@",fileName];

    return [[NSFileManager defaultManager]removeItemAtPath:fileName error:nil];
    
}

#pragma mark user写入文件
+(BOOL)fileManagerUser:(id)dic
{
    NSString * fileName=getFilePath(cachesFilePath, @"userFilePath", @"user.plist");
    return [MyData fileManager:dic andFileName:fileName];
}

#pragma mark user获取文件
+(id)fileManagerUser
{
    NSString * fileName=getFilePath(cachesFilePath, @"userFilePath", @"user.plist");
    
    NSDictionary * dic=[MyData fileManager:fileName];
    if ([dic isKindOfClass:[NSDictionary class]])
    {
        return dic.count?dic:@{};
    }
    return @{};

}
+(void)removeUserFile
{
    NSString * fileName=getFilePath(cachesFilePath, @"userFilePath", @"user.plist");
    [MyData removeFile:fileName];
}
+(BOOL)isShangJiaBundleIdentifier
{
    return [[[NSBundle mainBundle] bundleIdentifier] containsString:@"Shangjia"];
}


/**0 未知 1男 2女 */
+(NSString*)getSex:(NSInteger)sex
{
    return @[@"未知",@"男",@"女"][sex];
}
+(NSString*)setTimeInterval:(id)timeInterval
{
    timeInterval=[NSString stringWithFormat:@"%@",timeInterval];
    NSInteger time= [NSDate date].timeIntervalSince1970-[timeInterval integerValue];
                     
    if (time<60)
    {
        return @"刚刚";
    }else if(time<60*60)
    {
        return [NSString stringWithFormat:@"%d分钟前",(int)(time/60)];
    }else if(time<(60*60*24))
    {
        return [NSString stringWithFormat:@"%d小时前",(int)(time/60/60)];
    }else if(time<(60*60*24*30))
    {
        return [NSString stringWithFormat:@"%d天前",(int)(time/60/60/24)];
    }else if(time<(60*60*24*30*12))
    {
        return [NSString stringWithFormat:@"%d月前",(int)(time/60/60/24/30)];
    }else
        
        return [NSString stringWithFormat:@"%d年前",(int)(time/60/60/24/30/12)];
    
}


+(NSString *)getBinaryByhex16to2:(NSString *)hex
{
    NSMutableDictionary  *hexDic = [[NSMutableDictionary alloc] init];
    
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    
    [hexDic setObject:@"0000" forKey:@"0"];
    
    [hexDic setObject:@"0001" forKey:@"1"];
    
    [hexDic setObject:@"0010" forKey:@"2"];
    
    [hexDic setObject:@"0011" forKey:@"3"];
    
    [hexDic setObject:@"0100" forKey:@"4"];
    
    [hexDic setObject:@"0101" forKey:@"5"];
    
    [hexDic setObject:@"0110" forKey:@"6"];
    
    [hexDic setObject:@"0111" forKey:@"7"];
    
    [hexDic setObject:@"1000" forKey:@"8"];
    
    [hexDic setObject:@"1001" forKey:@"9"];
    
    [hexDic setObject:@"1010" forKey:@"A"];
    
    [hexDic setObject:@"1011" forKey:@"B"];
    
    [hexDic setObject:@"1100" forKey:@"C"];
    
    [hexDic setObject:@"1101" forKey:@"D"];
    
    [hexDic setObject:@"1110" forKey:@"E"];
    
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSMutableString *binaryString=[[NSMutableString alloc] init];
    
    for (int i=0; i<[hex length]; i++) {
        
        NSRange rage;
        
        rage.length = 1;
        
        rage.location = i;
        
        NSString *key = [hex substringWithRange:rage];
        key=[key uppercaseString];
        //NSLog(@"%@",[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]);
        [binaryString appendString:[hexDic objectForKey:key]];
        //        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,[NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    //NSLog(@"转化后的二进制为:%@",binaryString);
    
    return binaryString;
    
}
#pragma mark 获取总内存大小
+(long long)getTotalMemorySize
{
    return [NSProcessInfo processInfo].physicalMemory;
}


//获取当前可用内存
+(long long)getAvailableMemorySize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

//获取总磁盘容量
+(long long)getTotalDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}
//获取可用磁盘容量
+(long long)getAvailableDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}
//另附字符串转换函数
+(NSString *)fileSizeToString:(unsigned long long)fileSize
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (fileSize < 10)
    {
        return @"0 B";
        
    }else if (fileSize < KB)
    {
        return @"< 1 KB";
        
    }else if (fileSize < MB)
    {
        return [NSString stringWithFormat:@"%.1f KB",((CGFloat)fileSize)/KB];
        
    }else if (fileSize < GB)
    {
        return [NSString stringWithFormat:@"%.1f MB",((CGFloat)fileSize)/MB];
        
    }else
    {
        return [NSString stringWithFormat:@"%.1f GB",((CGFloat)fileSize)/GB];
    }
}

@end
