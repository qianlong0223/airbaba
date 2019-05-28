//
//  UIView+DWQEmptyView.m
//  DWQEmptyView
//
//  Created by 杜文全 on 16/9/9.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "UIView+DWQEmptyView.h"
#import <objc/runtime.h>
#import "Masonry.h"

//屏幕高
#define LSCREENH [UIScreen mainScreen].bounds.size.height
///屏幕宽
#define LSCREENW [UIScreen mainScreen].bounds.size.width
@interface UIView ()

@property (nonatomic,copy) void(^reloadAction)();

@end


@implementation UIView (DWQEmptyView)
- (void)setReloadAction:(void (^)())reloadAction{
    objc_setAssociatedObject(self, @selector(reloadAction), reloadAction, OBJC_ASSOCIATION_COPY);
}
- (void (^)())reloadAction{
    return objc_getAssociatedObject(self, _cmd);
}


//DWQErrorPageView
- (void)setErrorPageView:(DWQErrorPageView *)errorPageView{
    [self willChangeValueForKey:NSStringFromSelector(@selector(errorPageView))];
    objc_setAssociatedObject(self, @selector(errorPageView), errorPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:NSStringFromSelector(@selector(errorPageView))];
}
- (DWQErrorPageView *)errorPageView{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)configReloadAction:(void (^)())block{
    self.reloadAction = block;
    if (self.errorPageView && self.reloadAction) {
        self.errorPageView.didClickReloadBlock = self.reloadAction;
    }
}

- (void)showErrorPageView{
    
    if (!self.errorPageView) {
        self.errorPageView = [[DWQErrorPageView alloc]initWithFrame:self.bounds];
        if (self.reloadAction) {
            self.errorPageView.didClickReloadBlock = self.reloadAction;
        }
    }
    [self addSubview:self.errorPageView];
    [self bringSubviewToFront:self.errorPageView];
}
- (void)hideErrorPageView{
    if (self.errorPageView) {
        [self.errorPageView removeFromSuperview];
        self.errorPageView = nil;
    }
}

//OSCBlankPageView
- (void)setBlankPageView:(DWQBlankPageView *)blankPageView{
    [self willChangeValueForKey:NSStringFromSelector(@selector(blankPageView))];
    objc_setAssociatedObject(self, @selector(blankPageView), blankPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
    [self didChangeValueForKey:NSStringFromSelector(@selector(blankPageView))];
}
- (DWQBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)showBlankPageView{
    
    if (!self.blankPageView) {
        self.blankPageView = [[DWQBlankPageView alloc]initWithFrame:self.bounds];
    }
    [self addSubview:self.blankPageView];
    [self bringSubviewToFront:self.blankPageView];
}
- (void)hideBlankPageView{
    if (self.blankPageView) {
        [self.blankPageView removeFromSuperview];
        self.blankPageView = nil;
    }
}


@end

#pragma mark ---  DWQErrorPageView
@interface DWQErrorPageView ()
@property (nonatomic,weak) UIImageView* errorImageView;
@property (nonatomic,weak) UILabel* errorTipLabel;
@property (nonatomic,weak) UIButton* reloadButton;

@end
@implementation DWQErrorPageView
- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView* errorImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"暂无网络"]];
        _errorImageView = errorImageView;
        [self addSubview:_errorImageView];
        
        UILabel* errorTipLabel = [[UILabel alloc]init];
        errorTipLabel.numberOfLines = 1;
        errorTipLabel.font = [UIFont systemFontOfSize:16];
        errorTipLabel.textAlignment = NSTextAlignmentCenter;
        errorTipLabel.textColor = ColorWithHexString(@"#333333");
        errorTipLabel.text = @"暂无网络";
        _errorTipLabel = errorTipLabel;
        [self addSubview:_errorTipLabel];
        
        UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        reloadButton.layer.masksToBounds = YES;
        reloadButton.layer.cornerRadius = 20;
        [reloadButton setTitle:@"  点击刷新" forState:UIControlStateNormal];
        reloadButton.titleLabel.font =[UIFont systemFontOfSize:15];
        [reloadButton setTitleColor:ColorWithHexString(@"#333333") forState:UIControlStateNormal];
        [reloadButton setImage:[UIImage imageNamed:@"DWQrefresh_white" ] forState:UIControlStateNormal];
        reloadButton.backgroundColor = ColorWithHexString(@"#F5F5F5");
        [reloadButton addTarget:self action:@selector(_clickReloadButton:) forControlEvents:UIControlEventTouchUpInside];
        _reloadButton = reloadButton;
        [self addSubview:_reloadButton];

        [_errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.mas_centerY).offset(-140);
        }];
        
        [_errorTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@20);
            make.top.equalTo(_errorImageView.mas_bottom).offset(20);
        }];
        
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(44);
            make.centerX.equalTo(self);
            make.top.equalTo(_errorTipLabel.mas_bottom).offset(20);
        }];
    }
    return self;
}
- (void)_clickReloadButton:(UIButton* )btn{
    if (_didClickReloadBlock) {
        _didClickReloadBlock();
    }
}

@end


#pragma mark --- DWQBlankPageView
@interface DWQBlankPageView ()
@property (nonatomic,weak) UIImageView* nodataImageView;
@property (nonatomic,weak) UILabel* nodataTipLabel;
@property (nonatomic,weak) UIButton* reloadButton;
@end

@implementation DWQBlankPageView

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView* nodataImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"加载失败"]];
        _nodataImageView = nodataImageView;
        [self addSubview:_nodataImageView];
        
        UILabel* nodataTipLabel = [[UILabel alloc]init];
        nodataTipLabel.numberOfLines = 1;
        nodataTipLabel.font = [UIFont systemFontOfSize:15];
        nodataTipLabel.textAlignment = NSTextAlignmentCenter;
        nodataTipLabel.textColor = ColorWithHexString(@"#333333");
        nodataTipLabel.text = @"暂无订单";
        _nodataTipLabel = nodataTipLabel;
        [self addSubview:_nodataTipLabel];
        UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        reloadButton.layer.masksToBounds = YES;
        reloadButton.layer.cornerRadius = 20;
        [reloadButton setTitle:@"  点击刷新" forState:UIControlStateNormal];
        [reloadButton setTitleColor:ColorWithHexString(@"#333333") forState:UIControlStateNormal];
        reloadButton.titleLabel.font =[UIFont systemFontOfSize:15];
        [reloadButton setImage:[UIImage imageNamed:@"DWQrefresh_white" ] forState:UIControlStateNormal];
        reloadButton.backgroundColor = ColorWithHexString(@"#F5F5F5");
        [reloadButton addTarget:self action:@selector(_clickReloadButton:) forControlEvents:UIControlEventTouchUpInside];
        _reloadButton = reloadButton;
        [self addSubview:_reloadButton];
        
        [_nodataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-150);
        }];
        
        [_nodataTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@20);
            make.top.equalTo(_nodataImageView.mas_bottom).offset(20);
        }];
        [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(44);
            make.centerX.equalTo(self);
            make.top.equalTo(_nodataTipLabel.mas_bottom).offset(20);
        }];
    }
    return self;
}

@end
