//
//  QGSelectCollectionReusableView.h
//  HappyAmoy
//
//  Created by 钱龙 on 2019/3/26.
//  Copyright © 2019年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>
typedef void(^CategoryTouch)(NSInteger tag);

@interface QGSelectCollectionReusableView : UICollectionReusableView

@property (nonatomic, copy)CategoryTouch categoryTouch;
/**    存放轮播图的view    */
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property (weak, nonatomic) IBOutlet SYButton *button1;
@property (weak, nonatomic) IBOutlet SYButton *button2;
@property (weak, nonatomic) IBOutlet SYButton *button3;
@property (weak, nonatomic) IBOutlet SYButton *button4;
@property (weak, nonatomic) IBOutlet SYButton *button6;
@property (weak, nonatomic) IBOutlet SYButton *button7;
@property (weak, nonatomic) IBOutlet SYButton *button8;
@property (weak, nonatomic) IBOutlet SYButton *button9;

@property (nonatomic,strong)NSArray * collectionArr;//精选专题

@end
