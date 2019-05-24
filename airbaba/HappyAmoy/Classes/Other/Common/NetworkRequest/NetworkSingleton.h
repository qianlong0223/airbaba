//
//  NetworkSingleton.h
//  WY_DYZB
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

// 请求超时时间
#define TIMEOUT 60

typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSString *error);

/**     请求结果    */
typedef NS_ENUM(NSUInteger,RequestResultType) {
    /**     请求成功    */
    RequestSuccess = 0,
    /**     请求参数错误    */
    RequestFailure = 400,
    /**     未登录    */
    RequestFailureOfUnLogin = 401,
    /**     意料之外的错误，未处理的错误    */
    RequestFailureOfUnexpected = 500,
};

// 服务器的URL
static NSString *const baseUrl = @"http://192.168.0.155:8084/wroot_sqw";
//static NSString *const baseUrl = @"http://112.74.200.84/api";
//static NSString *const baseUrl = @"http://tk.sdydfc.cn/tkweb";
// 上传文件的URL
//static NSString *const uploadFileUrl = @"http://112.74.200.84/ajax/upfile/";


@interface NetworkSingleton : NSObject

+ (NetworkSingleton *)sharedManager;
- (AFHTTPSessionManager *)baseHttpRequest;

/**     Post请求     */
- (void)postRequestWithUrl:(NSString *)url parameters:(id)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

/**     Post请求，是否自动消失菊花     */
- (void)postRequestWithUrl:(NSString *)url parameters:(id)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock shouldDismissHud:(BOOL)shouldDismissHud;

/**     Post请求，json格式的参数     */
- (void)postJsonRequestWithUrl:(NSString *)url parameters:(id)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

/**     Get请求     */
- (void)getRequestWithUrl:(NSString *)url parameters:(id)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

/**     Get请求，是否自动消失菊花     */
- (void)getRequestWithUrl:(NSString *)url parameters:(id)parameters successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock shouldDismissHud:(BOOL)shouldDismissHud;

/**     上传图片     */
- (void)uploadImageWithUrl:(NSString *)url parameters:(id)parameters image:(UIImage *)image successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
