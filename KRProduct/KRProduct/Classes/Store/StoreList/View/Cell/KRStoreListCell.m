//
//  KRStoreListCell.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRStoreListCell.h"

@interface KRStoreListCell ()

@property (nonatomic, strong) UIImageView *storeImgView;
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *storeAddressLabel;
@property (nonatomic, strong) UILabel *storeDistanceLabel;
@property (nonatomic, strong) UILabel *storeScoreLabel;

@end

@implementation KRStoreListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView addSubview:self.storeImgView];
    [contentView addSubview:self.storeNameLabel];
    [contentView addSubview:self.storeAddressLabel];
    UIImageView *storeDistanceImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_located"]];
    [contentView addSubview:storeDistanceImgView];
    [contentView addSubview:self.storeDistanceLabel];
    UIImageView *storeScoreImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_rated_score"]];
    [contentView addSubview:storeScoreImgView];
    [contentView addSubview:self.storeScoreLabel];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = GRAY_LINE_COLOR;
    [contentView addSubview:lineView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 12, 0, 12));
    }];
    [_storeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.centerY.equalTo(contentView);
        make.width.height.mas_equalTo(60);
    }];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeImgView);
        make.leading.equalTo(_storeImgView.mas_trailing).offset(15);
        make.trailing.equalTo(contentView);
    }];
    [_storeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeNameLabel.mas_bottom).offset(10);
        make.leading.trailing.equalTo(_storeNameLabel);
    }];
    [storeDistanceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_storeAddressLabel);
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
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(contentView);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIImageView *)storeImgView {
    if (!_storeImgView) {
        _storeImgView = [[UIImageView alloc] init];
        _storeImgView.backgroundColor = [UIColor lightGrayColor];
        _storeImgView.layer.cornerRadius = 5;
        _storeImgView.clipsToBounds = YES;
    }
    return _storeImgView;
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
        _storeDistanceLabel = [UILabel labelWithText:@"1.1km" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _storeDistanceLabel;
}

- (UILabel *)storeScoreLabel {
    if (!_storeScoreLabel) {
        _storeScoreLabel = [UILabel labelWithText:@"评分5.0" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _storeScoreLabel;
}
@end
