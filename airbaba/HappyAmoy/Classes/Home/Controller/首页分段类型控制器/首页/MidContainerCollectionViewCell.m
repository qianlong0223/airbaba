//
//  MidContainerCollectionViewCell.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/5/22.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "MidContainerCollectionViewCell.h"

@implementation MidContainerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"MidContainerCollectionViewCell" owner:self options:nil].lastObject;
    }
    
    return self;
}
@end
