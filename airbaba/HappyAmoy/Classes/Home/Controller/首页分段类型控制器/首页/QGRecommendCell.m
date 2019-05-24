//
//  QGRecommendCell.m
//  HappyAmoy
//
//  Created by 钱龙 on 2019/3/28.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "QGRecommendCell.h"

@implementation QGRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"QGRecommendCell" owner:self options:nil].lastObject;
    }
    
    return self;
}

@end
