//
//  QGCodePopView.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/26.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "QGCodePopView.h"
@interface QGCodePopView()

@end

@implementation QGCodePopView
-(void)awakeFromNib{
    [super awakeFromNib];
    ViewRadius(self.qcopyBtn, 5.f);
}
-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    
}

- (IBAction)closeBtnClicked:(id)sender {
    if (_closeBtnBlock) {
        self.closeBtnBlock();
    }
}
- (IBAction)qcopyBtnClicked:(id)sender {
    
}
- (IBAction)shareBtnClicked:(id)sender {
    
}

@end
