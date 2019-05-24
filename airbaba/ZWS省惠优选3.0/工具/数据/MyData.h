//
//  MyData.h
//  商会之家
//
//  Created by apple on 15/8/11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


#define myDeviceScreenHeight [UIScreen mainScreen].bounds.size.height
#define myDeviceScreenWidth [UIScreen mainScreen].bounds.size.width

#define viewHeight (self.frame.size.height)
#define viewWidth (self.frame.size.width)

#define myHeight(view) (view.frame.size.height)
#define myWidth(view)  (view.frame.size.width)


#define myoriginX(view) view.frame.origin.x
#define myoriginY(view) view.frame.origin.y

#define mycenterX(view) view.center.x
#define mycenterY(view) view.center.y


#define myFrameHeight(frame) (frame.size.height)
#define myFrameWidth(frame)  (frame.size.width)


#define myUserDefaults(value,key) [[NSUserDefaults standardUserDefaults]setObject:value forKey:key]

#define myUserDefaultsForKey(key) [[NSUserDefaults standardUserDefaults]objectForKey:key]


#define myUserDefaultsremoveObject(key) [[NSUserDefaults standardUserDefaults]removeObjectForKey:key]

#define myLastView ([self.splitViewController.viewControllers.lastObject view]?[self.splitViewController.viewControllers.lastObject view]:self.view)

#define mykeyWindowView [UIApplication sharedApplication].keyWindow

#import "JSONData.h"

#import "UIImageView+WebCache.h"

#import "ZWSFileManager.h"

#import "UIColor+Lanmei.h"
#import "UIView+CGContextRef.h"
#import "UIImage+Lanmei.h"
#import "NSAttributedString+Lanmei.h"
#import "NSString+Lanmei.h"


#import "MJRefresh.h"
#import "CustomNavViewController.h"


/** 当前版本*/
#define isApp_Version [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]

/**app 名称*/
#define isApp_Name [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleDisplayName"]

/**app 名称*/
#define isDeviceUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

/** 是否开启通知 ios8以上*/
#define isAllowedNotification UIUserNotificationTypeNone != [[UIApplication sharedApplication] currentUserNotificationSettings]
/** 版本判断*/
#define iosDevice(number) ([[[UIDevice currentDevice] systemVersion] floatValue] >= number)

//网络变化
#define myReachability @"reachability"

/*
 背景图片
 */

#define mybackImage [UIImage imageNamed:@"morenlogo200"]

/*
 文字大小
 */
#define mytitleFont 16
#define mytextFont 14
#define mytimeFont  11

#define  imageURL(imageName) [NSURL URLWithString:[JSONData getUrlEscapesUsingEncoding:[NSString stringWithFormat:@"%@",imageName]]]


#define myNetwork ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable)

#define myuser_id  [MyData fileManagerUser][@"id"]
//0|1=>学生|教师
#define myUser_type  [MyData fileManagerUser][@"user_type"]


//用户消息 更新
#define myUpdateUserData @"myUpdateUserData"

//退出登录
#define myLoginStatus @"loginStateChange"

//缓存plist路径
#define plistFilePath(fileName) getFilePath(cachesFilePath, @"lanmeiCache", fileName)


@interface MyData : NSObject

/**缓存路径 创建目录 文件夹*/
+(NSString* )getCreateFilePath:(NSString*)fileName;

#pragma mark 写入文件
+(BOOL)fileManager:(id)dic  andFileName:(NSString*)fileName;
#pragma mark 写入文件
+(BOOL)fileManagerPlist:(id)dic andFileName:(NSString*)fileName;
/** 删除文件 文件plist xxx*/
+(BOOL)removePlistFile:(NSString*)fileName;
/** 删除文件 文件全名   xx.mp4*/
+(BOOL)removeFile:(NSString*)fileName;

#pragma mark 获取数据
+(id)fileManager:(NSString*)fileName;
#pragma mark 获取数据 plist文件
+(id)fileManagerPlist:(NSString*)fileName;
/** 1上架版本 0企业版*/
+(BOOL)isShangJiaBundleIdentifier;

#pragma mark //用户信息
+(BOOL)fileManagerUser:(id)dic;
+(id)fileManagerUser;
+(void)removeUserFile;



/**0 未知 1男 2女 */
+(NSString*)getSex:(NSInteger)sex;

/** 一天前 */
+(NSString*)setTimeInterval:(id)timeInterval;


+(NSString *)getBinaryByhex16to2:(NSString *)hex;

/**获取总内存大小*/
+(long long)getTotalMemorySize;
/**获取当前可用内存*/
+(long long)getAvailableMemorySize;
/**获取总磁盘容量*/
+(long long)getTotalDiskSize;
/**获取可用磁盘容量*/
+(long long)getAvailableDiskSize;
/**另附字符串转换函数 */
+(NSString *)fileSizeToString:(unsigned long long)fileSize;
@end
