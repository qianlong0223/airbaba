//
//  OrderTableViewCell.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/26.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    JLViewBorderRadius(self.goPayBtn, 12.f, 1, QHMainColor);
    JLViewBorderRadius(self.cancelOrderBtn, 12.f, 1, ColorWithHexString(@"#222222"));
    JLViewBorderRadius(self.scanLogistcs, 12.f, 1, QHMainColor);
    JLViewBorderRadius(self.sureBtn, 12.f, 1, ColorWithHexString(@"#222222"));
    JLViewBorderRadius(self.qScanLogistcs, 12.f, 1, QHMainColor);
    JLViewBorderRadius(self.qJudge, 12.f, 1, ColorWithHexString(@"#222222"));
    JLViewBorderRadius(self.qShouHouBtn, 12.f, 1, QHMainColor);
    JLViewBorderRadius(self.fScanLogistcs, 12.f, 1, QHMainColor);
}
//去付款
- (IBAction)goPayBtnClicked:(id)sender {
    
}
//取消订单
- (IBAction)cancelOrderBtnClicked:(id)sender {
    if (_cancelOrderBlock) {
        self.cancelOrderBlock();
    }
}
//查看物流
- (IBAction)scanLogistcsClicked:(id)sender {
    
}
//确认收货
- (IBAction)sureBtnClicked:(id)sender {
    
}
//确认收货页面的查看物流按钮
- (IBAction)qScanLogistcsClicked:(id)sender {
    
}
- (IBAction)qJudgeBtnClicked:(id)sender {
    
}
- (IBAction)qShouhouBtnClicked:(id)sender {
    
}

- (IBAction)fScanLogistcsClicked:(id)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
