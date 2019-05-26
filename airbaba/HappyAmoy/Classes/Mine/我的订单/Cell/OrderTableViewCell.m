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
    JLViewBorderRadius(self.goPayBtn, 8.f, 1, QHMainColor);
    JLViewBorderRadius(self.cancelOrderBtn, 8.f, 1, ColorWithHexString(@"#222222"));
}
- (IBAction)goPayBtnClicked:(id)sender {
}
- (IBAction)cancelOrderBtnClicked:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
