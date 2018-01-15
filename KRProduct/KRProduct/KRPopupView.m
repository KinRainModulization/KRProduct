//
//  KRPopupView.m
//  KRProduct
//
//  Created by LX on 2018/1/15.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRPopupView.h"

@interface KRPopupView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation KRPopupView

+ (instancetype)sharedManager {
    static KRPopupView *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    });
    return sharedManager;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.backgroundColor = RGBA(0, 0, 0, 0);
        _bgView.userInteractionEnabled = YES;
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        [self addSubview:_bgView];
    }
    return self;
}

//+ (void)showModal:(UIView *)view {
//    KRPopupView *popupView = [[KRPopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [popupView showModal:view];
//}

- (void)showModal:(UIView *)view {
    _contentView = view;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addSubview:view];
    
    view.frame = CGRectMake(0, SCREEN_HEIGHT, view.width, view.height);
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.backgroundColor = RGBA(0, 0, 0, 0.2);
        view.y = SCREEN_HEIGHT-view.height;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.backgroundColor = RGBA(0, 0, 0, 0);
        _contentView.y = SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_contentView removeFromSuperview];
    }];
}

@end
