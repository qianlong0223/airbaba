
//
//  JSONDataDemo.h
//  baihuijie
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifndef JSONDataDemo_h
#define JSONDataDemo_h

#define htmlIp @"http://112.74.200.84"

#define encryptKey @"$^&*lanmei$@#1"

#define myApp_id @""

#define htmlPath(type) [NSString stringWithFormat:@"%@/api/%@?",htmlIp,type]

#define gethtmlPath(type,conditions) [NSString stringWithFormat:@"%@/api/%@?%@",htmlIp,type,conditions]

//测试使用
#define  datatoDic(data) [NSJSONSerialization JSONObjectWithData:[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil] options:NSJSONReadingMutableContainers error:nil]


#define af_timeoutInterval 10

#endif /* JSONDataDemo_h */
