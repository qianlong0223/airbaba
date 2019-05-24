//
//  JSONData.h
//  随手生活
//
//  Created by apple on 15/4/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

/**
 1 将AFNetWorking文件夹导入项目
 
 2 添加类库 Security.framework、MobileCoreServices.framework、SystemConfiguration.framework
 3 在使用的地方  #import "AFNetworking.h"
 
 解决编译时警告：
 
 Prefix.pch文件中加入
 #import <SystemConfiguration/SystemConfiguration.h>
 #import <MobileCoreServices/MobileCoreServices.h>
 
 
 注：AFNetWorking使用了ARC ，在不使用ARC项目中使用时，对AFNetWorking的所有.m文件添加“-fobjc-arc”
 在使用ARC项目中，使用“不使用ARC”的类库时，对类库的.m文件添加“-fno-objc-arc”
 */
#import <Foundation/Foundation.h>

#import "AFNetworking.h"

#import "UIKit+AFNetworking.h"

#import "JSONDataDemo.h"

@interface JSONData : NSObject


@property(nonatomic,weak)UIView * view;

@property(nonatomic,weak)UIActivityIndicatorView * activity;
//加载时是否 锁屏 默认NO 不锁屏
@property(nonatomic)BOOL runEnabled;

@property (nonatomic,strong)NSMutableArray * operationsArr;
//取消所以线程
-(void)cancelAllOperations;

//成功回调
typedef void (^successBlock)(id  responseObject);
//失败的回调
typedef void (^failedBlock)(NSError *error);
//下载进度
typedef void (^downloadProgressBlock)(CGFloat bytesRead);
//成功回调
typedef void (^downloadSuccessBlock)(NSData * data);


/** 请求数据*/
-(NSURLSessionDataTask *)GETHtmlURLRequest:(NSString*)conditionsString  BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;

/** 请求数据*/
-(NSURLSessionDataTask *)GETHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;


+(NSURLSessionDataTask *)GETHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;

/** 修改数据*/
-(NSURLSessionDataTask *)PUTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;
+(NSURLSessionDataTask *)PUTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;

/** 删除数据*/
-(NSURLSessionDataTask *)DELETEHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;
/** 删除数据*/
+(NSURLSessionDataTask *)DELETEHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;
/** 添加数据*/
-(NSURLSessionDataTask *)POSTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;

+(NSURLSessionDataTask *)POSTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;

/** 添加数据 图片 文本*/
-(NSURLSessionDataTask *)POSTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure;


+(NSString *)getUrlEscapesUsingEncoding:(NSString*)conditionsString;

@end
