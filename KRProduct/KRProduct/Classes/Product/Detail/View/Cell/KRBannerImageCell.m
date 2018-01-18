//
//  KRBannerImageCell.m
//  KRProduct
//
//  Created by LX on 2018/1/12.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRBannerImageCell.h"

@interface KRBannerImageCell ()

@property (nonatomic, strong) UIImageView *goodsImgView;

@end

@implementation KRBannerImageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.goodsImgView];
        [_goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (UIImageView *)goodsImgView {
    if (!_goodsImgView) {
        _goodsImgView = [[UIImageView alloc] init];
        _goodsImgView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }
    return _goodsImgView;
}

@end
