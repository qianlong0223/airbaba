//
//  AliPay.m
//  ChiKe
//
//  Created by 刘俊臣 on 2018/1/16.
//  Copyright © 2018年 你亲爱的爸爸. All rights reserved.
//

#import "AliPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APRSASigner.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "WYProgress.h"

@implementation AliPay

+ (instancetype)share{
    static AliPay *py = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        py = [AliPay new];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPay:) name:@"AliPayResult" object:nil];
    });
    return py;
}

+ (void)onPay:(NSNotification *)noti {
    NSDictionary *resultDic = noti.userInfo;
    NSInteger code = [resultDic[@"resultStatus"] integerValue];
    if (code == 9000) {
//        [SVProgressHUD showSuccessWithStatus:@"支付成功"];
        [WYProgress showSuccessWithStatus:@"支付成功"];
    } else {
//        [SVProgressHUD showErrorWithStatus:@"支付失败"];
        [WYProgress showErrorWithStatus:@"支付失败"];

    }
}

+ (void)payWithOrder:(NSString *)orderKey amount:(float)amount title:(NSString *)title completation:(void (^)(NSDictionary *, NSInteger, NSString *))comp {
    [self share];
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2018043002610992";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC/BPM7AgeHwDYjA6Ll3v/XvHPNzyvI3yWLLf9frG2DyyhSmYzUt2b00Pph+YM62t0VVaImN0pLHee4KXe0nQ7YJ2utt3iwt44QPfnVqUGwNykMTwdMqWkzjd+bxkDqFaOyb7Up6Da9sFZMv63vEzASzUInR1ZQXfGrBfA2TDeZzz6/Jy5oua85Z9rxTwC5XREMREUo5HdK1YP/tBRahP3eg21lE70ACRhUL2AkiCMc70+tOhaSRcgV9MtCVZLkmepMxhtvfuxEbU4p2F9eA1vVjbg16ahXFrF6elzL7VWG6cTAuKfWymgW2mMmhUmjqtCymv1p1YeACXvHZ2kiTJnTAgMBAAECggEAQ05HNd99L8P2T1gUqdJta2KnmzkIQHsAC45lkRx8ahfHWXNpP/pveIu57ZOxPaeohr/ppnWM4/Lhlu5lk2pTtK4PLuKa0AmdMPPld/dvgdutxvyBoe1/d/7hb03nyZNeXp0lxGJiB2x+vAQ+ESM9qSJR0O096Itxf8VT4o3weW0EwxO2IV+Anj82yra71uVhyKIdR+vlLMyqCvbaFgiyNn9hdxtIJrrnXmtEF0TjhGQIawm6tqHJAE8SIwxGz+mRm0z0JMMyYEJjCdoYdeK7iy4IGJYXPabkPhqREiz9E+8gdyHQrSXp6BazP3PdMcQ5u6M4vrUB4cOPUJx1AP3poQKBgQDmZqGfPvPMbIC6TlI8r/veE0fpZLWE8PRZqRBneg3Xw52LmUWQdNSA8gcvkTl+oH3etGANAe1qBN1RocDK7M1KuXye+wtE9R84mHstdtJX8NM0R26yVgcUxenS+ZNsFqBVJ4s2GfKNYdyjj9YgyMn+YOVwoeCQfqzukqJuv6kPnQKBgQDUPi0I1QNH4trr2HMjDG0IEbsmqd/Ho8f9mV4htuJINv6gZ6riVVZnH0Go8Te63aalQ65iEjlrTXGORKxDVPZsWRQwvXMs4YtU45Df9HWZn4iuKafiOrq3TQihzcLLaEIdW95Krokb9a7SogB6372HbE4id10fjLhJwadtQ/bsLwKBgGCiBQGEZr6Dd44sUUOQ0AN5dLzH93X1lZaRWQb9YxbuvYISW+HVjlcyq57guwuIBqLEZlCuUUQZHDYjsHer0AKaP1Fym2xlnp2fHnKYFmq53+taVmxHtpqY05QgBxvbdY2hkzqysU9pDyAusLF5ZXbibvjJfCU+bAt3xtbKXf7lAoGAb8BpH+xgtNoKoQGv5fVl90i2vO3W6RwgcjPtr1zHGnTybu0GufNq8hMwFE8mI9sPIpdXW0XzO79kGh+ogC9dLMFecyddXHVJUqIbpv/lZ8TrR6ChR+naZCdIc0GO3mD/5st3aOUrRjB/I2KvVAM4nPR204j73F/QrO0tRcfyXHsCgYEA0AlQgcb2jPOiBMZH9+ytYX+ZUMvKSMrAxoDv3qKq+ov6NbD+qrN/c3K8GTUxTLZs6bb+wJD4pZ9NL20LI5lFreo2CFQoUQnXB/P5/hRHwSD7YD7xdgS9IlswZ/sBoL4A3ZIzeXllXqbQ7Z8PXXHbF6MgAYIgyFX7Mb2WXUZT69c=";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    APOrderInfo* order = [APOrderInfo new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    order.notify_url = @"http://112.74.200.84/api/callback/alipay";
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [APBizContent new];
    order.biz_content.body = @"支付";
    order.biz_content.subject = title;
    order.biz_content.out_trade_no = orderKey; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", amount]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    WYLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"HappyAmoy";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            WYLog(@"reslut = %@",resultDic);
            comp(resultDic, [resultDic[@"resultStatus"] integerValue] , @"");
        }];
    }
}
@end
