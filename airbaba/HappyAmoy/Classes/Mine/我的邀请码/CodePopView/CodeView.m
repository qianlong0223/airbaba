//
//  CodeView.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/26.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "CodeView.h"
#import "QGCodePopView.h"
@interface CodeView()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic,strong)NSDictionary * dictionary;
@end
@implementation CodeView
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView.frame = CGRectMake(0, 0, 300, 370);
        self.alertView.center = self.center;
        [self addSubview:self.alertView];
        self.dictionary = dict;
        QGCodePopView * qview =  [[[NSBundle mainBundle]loadNibNamed:@"QGCodePopView" owner:self options:nil]lastObject];
        qview.qCodeImageView.image = [UIImage imageNamed:dict[@"image"]];
        qview.inviteCodeLabel.text = [NSString stringWithFormat:@"邀请码:%@",dict[@"code"]];
        qview.dict = dict;
        [qview setCloseBtnBlock:^{
            [self hiddenAction];
        }];
        [self.alertView addSubview:qview];
    }
    return self;
}
- (UIView *)alertView {
    if (!_alertView) {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 5;
        _alertView.userInteractionEnabled = YES;
        _alertView.userInteractionEnabled = YES;
    }
    return _alertView;
}
- (void)showView {
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.3 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenAction {
    
    [self dismissAlertView];
}
-(void)dismissAlertView {
    [UIView animateWithDuration:.2 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.08
                         animations:^{
                             self.alertView.transform = CGAffineTransformMakeScale(0.25, 0.25);
                         }completion:^(BOOL finish){
                             [self removeFromSuperview];
                         }];
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self hiddenAction];
}

@end
