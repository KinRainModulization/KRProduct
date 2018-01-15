//
//  KRShareModalView.m
//  KRProduct
//
//  Created by LX on 2018/1/15.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRShareModalView.h"
#import "KRPopupView.h"

@implementation KRShareModalView

+ (instancetype)sharedManager {
    static KRShareModalView *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    });
    return sharedManager;
}

- (void)buttonClick:(UIButton *)button {
    switch (button.tag) {
        case 0:
            [self wechatSessionBtnClick];
            break;
        case 1:
            [self wechatBtnClick];
            break;
        case 2:
            [self QQBtnClick];
            break;
        case 3:
            [self QZoneBtnClick];
            break;
        case 4:
            [self weiboBtnClick];
            break;
            
        default:
            break;
    }
}

- (void)wechatSessionBtnClick {
    
}

- (void)wechatBtnClick {
    
}

- (void)QQBtnClick {
    
}

- (void)QZoneBtnClick {
    
}

- (void)weiboBtnClick {
    
}


- (void)cancelBtnClick {
    [[KRPopupView sharedManager] dismiss];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        NSArray *array = @[
                           @{@"title":@"微信好友",@"image":@"ic_wechat"},
                           @{@"title":@"朋友圈",@"image":@"ic_moment"},
                           @{@"title":@"QQ",@"image":@"ic_qq"},
                           @{@"title":@"QQ空间",@"image":@"ic_zone"},
                           @{@"title":@"微博",@"image":@"ic_weibo"}
                           ];
        
        self.backgroundColor = [UIColor whiteColor];
        CGFloat contentH = 140;
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, contentH)];
        contentView.backgroundColor = GLOBAL_BACKGROUND_COLOR;
        [self addSubview:contentView];
        
        CGFloat btnW = SCREEN_WIDTH*0.2;
        for (int i = 0; i < array.count; i++) {
            NSDictionary *item = array[i];
            UIButton *button = [UIButton buttonWithTitle:item[@"title"] fontSize:12 titleColor:FONT_COLOR_33 target:self action:@selector(buttonClick:)];
            button.tag = i;
            [button setImage:[UIImage imageNamed:item[@"image"]] forState:UIControlStateNormal];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            [button sizeToFit];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.height+16.5,-button.imageView.width, 0,0)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(-(button.titleLabel.height+16.5), 0,0, -button.titleLabel.width)];
            button.frame = CGRectMake(i*btnW, 0, btnW, contentH);
            [contentView addSubview:button];
        }
        
        UIButton *cancelBtn = [UIButton buttonWithTitle:@"取消" fontSize:16 titleColor:FONT_COLOR_99 target:self action:@selector(cancelBtnClick)];
        cancelBtn.frame = CGRectMake(0, contentH, SCREEN_WIDTH, 50);
        [self addSubview:cancelBtn];
    }
    return self;
}

@end
