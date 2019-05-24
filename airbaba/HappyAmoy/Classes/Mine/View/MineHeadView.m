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
- (IBAction)qCodeBtnClicked:(id)sender {
    NSLog(@"二维码");
}
- (IBAction)walletBtnClicked:(id)sender {
}

- (IBAction)interglBtnClicked:(id)sender {
}
- (IBAction)ticketBtnClicked:(id)sender {
}
- (IBAction)memberBtnClicked:(id)sender {
}
- (IBAction)scanOrderBtnClicked:(id)sender {
}
- (IBAction)dfkBtnClicked:(id)sender {
}
- (IBAction)dfhBtnClicked:(id)sender {
}
- (IBAction)dshBtnClicked:(id)sender {
}
- (IBAction)dpjBtnClicked:(id)sender {
}

@end
