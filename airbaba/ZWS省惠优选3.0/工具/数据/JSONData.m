//
//  JSONData.m
//  随手生活
//
//  Created by apple on 15/4/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "JSONData.h"

@interface JSONData()


@end

@implementation JSONData

- (instancetype)init
{
    self = [super init];
    if (self) {

//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachability:) name:myReachability object:nil];
    }
    return self;
}
-(NSMutableArray *)operationsArr
{
    if (_operationsArr==nil)
    {
        _operationsArr=[NSMutableArray new];
    }
    return _operationsArr;
}
+(AFHTTPSessionManager *)getManager
{
    AFHTTPSessionManager * manager=[AFHTTPSessionManager manager];
    
//    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",@"application/x-www-form-urlencoded",@"X-Requested-With", nil];
    
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept" ];
   
    return manager;
}

-(void)success:(NSURLSessionDataTask *)task
{
    self.view.userInteractionEnabled=YES;
    [self.operationsArr removeObject:task];
}
-(void)failure:(NSURLSessionDataTask *)task
{
    self.view.userInteractionEnabled=YES;
    [self.operationsArr removeObject:task];
}

-(NSURLSessionDataTask *)GETHtmlURLRequest:(NSString*)conditionsString  BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    __weak __typeof(self)weakSelf = self;

    NSLog(@"%@",conditionsString);
    AFHTTPSessionManager * _manager=[JSONData getManager];
    NSURLSessionDataTask * task=[_manager GET:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
    }
    success:^(NSURLSessionDataTask *task, id responseObject) {
        if (weakSelf)
        {
            [self success:task];
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (weakSelf)
        {
            [self failure:task];
            failure(error);
            
        }
        
    }];
    

    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.view.userInteractionEnabled=!weakSelf.runEnabled;
    });
    [weakSelf.operationsArr addObject:task];
    
    [self.activity setAnimatingWithStateOfTask:task];
    return task;
}



-(NSURLSessionDataTask *)GETHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    __weak __typeof(self)weakSelf = self;

    AFHTTPSessionManager * _manager=[JSONData getManager];
    
    NSURLSessionDataTask * task=[_manager GET:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    }success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (weakSelf)
        {
            [self success:task];
            success(responseObject);
            NSLog(@"%@",responseObject);
        }
      
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (weakSelf)
        {
            [self failure:task];
            failure(error);
            
        }
       

        
    }];
    NSLog(@"%@",conditionsString);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.view.userInteractionEnabled=!weakSelf.runEnabled;
    });
    [weakSelf.operationsArr addObject:task];

    [self.activity setAnimatingWithStateOfTask:task];
    return task;
}


+(NSURLSessionDataTask *)GETHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    AFHTTPSessionManager * _manager=[JSONData getManager];
    NSLog(@"%@",conditionsString);
  NSURLSessionDataTask * task=[_manager GET:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {

        success(responseObject);

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
        
    }];
    return task;

}


-(NSURLSessionDataTask *)PUTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    __weak __typeof(self)weakSelf = self;

    
    AFHTTPSessionManager * _manager=[JSONData getManager];
  
    NSURLSessionDataTask * task=[_manager PUT:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        self.view.userInteractionEnabled=YES;
        
        if (weakSelf)
        {
            [self success:task];
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (weakSelf)
        {
            [self failure:task];
            failure(error);
            
        }
        
    }];
    
    NSLog(@"%@",conditionsString);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.view.userInteractionEnabled=!weakSelf.runEnabled;
    });
    [weakSelf.operationsArr addObject:task];
    
    [self.activity setAnimatingWithStateOfTask:task];
    return task;
}
+(NSURLSessionDataTask *)PUTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    AFHTTPSessionManager * _manager=[JSONData getManager];
    
    NSURLSessionDataTask * task=[_manager PUT:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {

        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        failure(error);
        
    }];
    

    return task;
}
-(NSURLSessionDataTask *)DELETEHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    __weak __typeof(self)weakSelf = self;

    AFHTTPSessionManager * _manager=[JSONData getManager];
    
    NSURLSessionDataTask * task=[_manager DELETE:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        self.view.userInteractionEnabled=YES;
        
        if (weakSelf)
        {
            [self success:task];
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (weakSelf)
        {
            [self failure:task];
            failure(error);
            
        }
    }];
    
    NSLog(@"%@",conditionsString);

    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.view.userInteractionEnabled=!weakSelf.runEnabled;
    });
    [weakSelf.operationsArr addObject:task];
    
    [self.activity setAnimatingWithStateOfTask:task];
    return task;
}
+(NSURLSessionDataTask *)DELETEHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    AFHTTPSessionManager * _manager=[JSONData getManager];
    
    NSURLSessionDataTask * task=[_manager DELETE:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        failure(error);
    }];
    

    return task;
}

-(NSURLSessionDataTask *)POSTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    __weak __typeof(self)weakSelf = self;
    NSLog(@"%@",conditionsString);

    AFHTTPSessionManager * _manager=[JSONData getManager];
    
    NSURLSessionDataTask * task=
    [_manager POST:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters  progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        self.view.userInteractionEnabled=YES;
        NSLog(@"%@",responseObject);
        
        if (weakSelf)
        {
            [weakSelf success:task];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (weakSelf)
        {
            [weakSelf failure:task];
            failure(error);
            
        }
    }];
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.view.userInteractionEnabled=!weakSelf.runEnabled;
    });
    [weakSelf.operationsArr addObject:task];
    
    [weakSelf.activity setAnimatingWithStateOfTask:task];
    
    return task;
}


-(NSURLSessionDataTask *)POSTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    __weak __typeof(self)weakSelf = self;
    NSLog(@"%@",conditionsString);

    AFHTTPSessionManager * _manager=[JSONData getManager];
  
    NSURLSessionDataTask * task= [_manager POST:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        block(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (weakSelf)
        {
            [self success:task];
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (weakSelf)
        {
            [self failure:task];
            failure(error);
        }
    }];
   
    
    NSLog(@"%@",conditionsString);
    dispatch_async(dispatch_get_main_queue(), ^{

    weakSelf.view.userInteractionEnabled=!weakSelf.runEnabled;
    });
    [weakSelf.operationsArr addObject:task];
    
    [self.activity setAnimatingWithStateOfTask:task];
    return task;
}

+(NSURLSessionDataTask *)POSTHtmlURLRequest:(NSString*)conditionsString parameters:(id)parameters BlockWithSuccess:(successBlock)success failedBlock:(failedBlock)failure
{
    NSLog(@"%@",conditionsString);

    AFHTTPSessionManager * _manager=[JSONData getManager];
    
    NSURLSessionDataTask * dataTask=[_manager POST:[JSONData getUrlEscapesUsingEncoding:conditionsString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        
        success(responseObject);
    
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        failure(error);
        
    }];
    
    return dataTask;
}


-(void)cancelAllOperations
{
    for (NSURLSessionDataTask * task in _operationsArr)
    {
        [task cancel];
    }
    [_operationsArr removeAllObjects];
    _operationsArr=nil;
}

-(void)reachability:(NSNotification*)not
{
    if ([AFNetworkReachabilityManager sharedManager].reachable==AFNetworkReachabilityStatusNotReachable)
    {
        [self cancelAllOperations];
    }
}

+(NSString *)getUrlEscapesUsingEncoding:(NSString*)conditionsString
{
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9)
        {
            conditionsString=[conditionsString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }else
            conditionsString=[conditionsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        return conditionsString;
}
-(void)dealloc
{
    [self cancelAllOperations];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
