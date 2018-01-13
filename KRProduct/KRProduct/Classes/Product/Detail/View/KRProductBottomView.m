//
//  KRProductBottomView.m
//  KRProduct
//
//  Created by LX on 2018/1/8.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRProductBottomView.h"

@interface KRProductBottomView ()

@property (nonatomic, strong) UIButton *storeBtn;

@property (nonatomic, strong) UIButton *shoppingCartBtn;

@property (nonatomic, strong) UIButton *addShoppingCartBtn;

@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation KRProductBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:bottomView];
    [bottomView addSubview:self.storeBtn];
    [bottomView addSubview:self.shoppingCartBtn];
    [bottomView addSubview:self.addShoppingCartBtn];
    [bottomView addSubview:self.buyBtn];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.mas_equalTo(47);
    }];
    [_storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.equalTo(bottomView);
        make.width.equalTo(bottomView).multipliedBy(0.2);
    }];
    [_shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.leading.equalTo(_storeBtn.mas_trailing);
        make.width.equalTo(bottomView).multipliedBy(0.2);
    }];
    [_addShoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.leading.equalTo(_shoppingCartBtn.mas_trailing);
        make.width.equalTo(bottomView).multipliedBy(0.3);
    }];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.leading.equalTo(_addShoppingCartBtn.mas_trailing);
        make.width.equalTo(bottomView).multipliedBy(0.3);
    }];
}

- (UIButton *)createVerticalButtonWithTitle:(NSString *)title image:(NSString *)imageName action:(SEL)action {
    UIButton *button = [UIButton buttonWithTitle:title fontSize:12 titleColor:FONT_COLOR_33 target:self action:action];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [button sizeToFit];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.height+2.5,-button.imageView.width, 0,0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(-(button.titleLabel.height+2.5), 0,0, -button.titleLabel.width)];
    return button;
}

#pragma mark - Action

- (void)storeBtnClick {
    
}

- (void)shoppingCartBtnClick {
    
}

- (void)addGoodsBtnClick {
    
}

- (void)buyBtnClick {
    if ([_delegate respondsToSelector:@selector(orderButtonClick:)]) {
        [_delegate orderButtonClick:self];
    }
}

#pragma mark - Setter/Getter
- (UIButton *)storeBtn {
    if (!_storeBtn) {
        _storeBtn = [self createVerticalButtonWithTitle:@"店铺" image:@"ic_store" action:@selector(storeBtnClick)];
    }
    return _storeBtn;
}

- (UIButton *)shoppingCartBtn {
    if (!_shoppingCartBtn) {
        _shoppingCartBtn = [self createVerticalButtonWithTitle:@"购物车" image:@"ic_cart" action:@selector(shoppingCartBtnClick)];
    }
    return _shoppingCartBtn;
}

- (UIButton *)addShoppingCartBtn {
    if (!_addShoppingCartBtn) {
        _addShoppingCartBtn = [UIButton buttonWithTitle:@"加入购物车" fontSize:16 titleColor:[UIColor whiteColor] target:self action:@selector(addGoodsBtnClick)];
        [_addShoppingCartBtn setBackgroundColor:RGB(74, 237, 170)];
    }
    return _addShoppingCartBtn;
}

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithTitle:@"立即购买" fontSize:16 titleColor:[UIColor whiteColor] target:self action:@selector(buyBtnClick)];
        [_buyBtn setBackgroundColor:GLOBAL_COLOR];
    }
    return _buyBtn;
}

@end
