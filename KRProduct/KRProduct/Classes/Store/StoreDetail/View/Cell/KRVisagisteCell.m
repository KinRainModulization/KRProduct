//
//  KRVisagisteCell.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRVisagisteCell.h"

@interface KRVisagisteCell ()

@property (nonatomic, strong) UIImageView *visagisteImgView;
@property (nonatomic, strong) UILabel *visagisteNameView;

@end

@implementation KRVisagisteCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.visagisteImgView];
        [self addSubview:self.visagisteNameView];
        
        [_visagisteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(self);
            make.height.mas_equalTo(self.width);
        }];
        [_visagisteNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_visagisteImgView.mas_bottom).offset(10.5);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (UIImageView *)visagisteImgView {
    if (!_visagisteImgView) {
        _visagisteImgView = [[UIImageView alloc] init];
        _visagisteImgView.layer.cornerRadius = 5;
        _visagisteImgView.clipsToBounds = YES;
        
        _visagisteImgView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }
    return _visagisteImgView;
}

- (UILabel *)visagisteNameView {
    if (!_visagisteNameView) {
        _visagisteNameView = [UILabel labelWithText:@"医师名" textColor:FONT_COLOR_33 fontSize:12];
    }
    return _visagisteNameView;
}

@end
