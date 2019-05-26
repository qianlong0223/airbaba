//
//  MineHeadView.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/23.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "MineHeadView.h"

@implementation MineHeadView
-(void)awakeFromNib{
    [super awakeFromNib];
    ViewRadius(self.memberBtn, 12.f);
}
- (IBAction)mycollectionBtnClicked:(id)sender {
    
}
- (IBAction)addressBtnClicked:(id)sender {
    
}
- (IBAction)myteamBtnClicked:(id)sender {
    
}
- (IBAction)myrepairBtnClicked:(id)sender {
    
}
- (IBAction)applyBtnClicked:(id)sender {
    
}

- (IBAction)qCodeBtnClicked:(id)sender {
    if (_qcodeBtnBlock) {
        self.qcodeBtnBlock();
    }
    NSLog(@"二维码");
}
- (IBAction)walletBtnClicked:(id)sender {
    
    if (_moneyBtnBlock) {
        self.moneyBtnBlock();
    }
}

- (IBAction)interglBtnClicked:(id)sender {
    
}
- (IBAction)ticketBtnClicked:(id)sender {
    
}
- (IBAction)memberBtnClicked:(id)sender {
    
}
- (IBAction)scanOrderBtnClicked:(id)sender {
    if (_scanOrderBtnBlock) {
        self.scanOrderBtnBlock();
    }
}
- (IBAction)dfkBtnClicked:(id)sender {
    if (_dfkBtnBlock) {
        self.dfkBtnBlock();
    }
}
- (IBAction)dfhBtnClicked:(id)sender {
    if (_dfhBtnBlock) {
        self.dfhBtnBlock();
    }
}
- (IBAction)dshBtnClicked:(id)sender {
    if (_dshBtnBlock) {
        self.dshBtnBlock();
    }
}
- (IBAction)dpjBtnClicked:(id)sender {
    if (_dpjBtnBlock) {
        self.dpjBtnBlock();
    }
}

@end
