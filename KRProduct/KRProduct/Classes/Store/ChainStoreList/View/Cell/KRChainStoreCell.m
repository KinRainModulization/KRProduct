//
//  KRChainStoreCell.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRChainStoreCell.h"

@interface KRChainStoreCell ()

@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *storeAddressLabel;
@property (nonatomic, strong) UILabel *storeDistanceLabel;
@property (nonatomic, strong) UILabel *storeScoreLabel;
@property (nonatomic, strong) UIButton *storeHotlineBtn;

@end

@implementation KRChainStoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    UIButton *contentView = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addTarget:self action:@selector(storeDetailClick) forControlEvents:UIControlEventTouchUpInside];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    [contentView addSubview:self.storeNameLabel];
    [contentView addSubview:self.storeAddressLabel];
    UIImageView *storeDistanceImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_located"]];
    [contentView addSubview:storeDistanceImgView];
    [contentView addSubview:self.storeDistanceLabel];
    UIImageView *storeScoreImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_rated_score"]];
    [contentView addSubview:storeScoreImgView];
    [contentView addSubview:self.storeScoreLabel];
    UIView *storeLineView = [[UIView alloc] init];
    storeLineView.backgroundColor = GRAY_LINE_COLOR;
    [contentView addSubview:storeLineView];
    [contentView addSubview:self.storeHotlineBtn];
    UIView *bottomLineView =  [[UIView alloc] init];
    bottomLineView.backgroundColor = GRAY_LINE_COLOR;
    [contentView addSubview:bottomLineView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(15);
        make.leading.equalTo(contentView).offset(12);
        make.trailing.equalTo(storeLineView.mas_leading);
    }];
    [_storeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeNameLabel.mas_bottom).offset(10);
        make.leading.trailing.equalTo(_storeNameLabel);
    }];
    [storeDistanceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_storeNameLabel);
        make.bottom.equalTo(contentView).offset(-13.5);
    }];
    [_storeDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(storeDistanceImgView.mas_trailing).offset(6);
        make.bottom.equalTo(storeDistanceImgView);
    }];
    [storeScoreImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_storeDistanceLabel.mas_trailing).offset(12);
        make.bottom.equalTo(storeDistanceImgView);
    }];
    [_storeScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(storeScoreImgView.mas_trailing).offset(6);
        make.bottom.equalTo(storeDistanceImgView);
    }];
    [storeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(14);
        make.trailing.equalTo(contentView).offset(-64);
        make.bottom.equalTo(contentView).offset(-14);
        make.width.mas_equalTo(0.5);
    }];
    [_storeHotlineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.equalTo(contentView);
        make.width.mas_equalTo(64);
    }];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(contentView).offset(12);
        make.trailing.equalTo(contentView).offset(-12);
        make.bottom.equalTo(contentView);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - Action

- (void)storeDetailClick {
    if (self.storeDetailBlock) {
        self.storeDetailBlock();
    }
}

- (void)hotlineButtonClick {
    self.storeHotlineBlock();
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [UILabel labelWithText:@"店铺名" textColor:FONT_COLOR_33 fontSize:14];
        _storeNameLabel.numberOfLines = 1;
    }
    return _storeNameLabel;
}

- (UILabel *)storeAddressLabel {
    if (!_storeAddressLabel) {
        _storeAddressLabel = [UILabel labelWithText:@"店铺地址" textColor:FONT_COLOR_99 fontSize:12];
        _storeAddressLabel.numberOfLines = 1;
    }
    return _storeAddressLabel;
}

- (UILabel *)storeDistanceLabel {
    if (!_storeDistanceLabel) {
        _storeDistanceLabel = [UILabel labelWithText:@"1.3km" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _storeDistanceLabel;
}

- (UILabel *)storeScoreLabel {
    if (!_storeScoreLabel) {
        _storeScoreLabel = [UILabel labelWithText:@"评分" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _storeScoreLabel;
}

- (UIButton *)storeHotlineBtn {
    if (!_storeHotlineBtn) {
        _storeHotlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_storeHotlineBtn setImage:[UIImage imageNamed:@"phone_call"] forState:UIControlStateNormal];
        [_storeHotlineBtn addTarget:self action:@selector(hotlineButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _storeHotlineBtn;
}

@end
