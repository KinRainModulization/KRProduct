//
//  KRProductSelectAttributesView.h.m
//  Yml
//
//  Created by KR on 2017/11/20.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "KRProductSelectAttributesView.h"
#import "KRGoodsAttributeCell.h"
#import <KRCustomPriceView.h>

@interface KRProductSelectAttributesView () <UITableViewDelegate,UITableViewDataSource,KRGoodsAttributeCellDelegate>

@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) KRCustomPriceView *totalPriceLabel;
@property (nonatomic, strong) UILabel *selectedAttrsLabel;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) UITableView *attrSelectTableView;
@property (nonatomic, strong) KRGoodsAttributeCell *goodsAttributeCell;
@property (nonatomic, strong) UIButton *reduceBtn;
@property (nonatomic, strong) UILabel *totalQuantityLabel;
@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *shoppingCartBtn;
@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation KRProductSelectAttributesView

static NSString *GoodsAttributeCell = @"GoodsAttributeCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    [contentView addSubview:self.goodsImageView];
    [contentView addSubview:self.totalPriceLabel];
    [contentView addSubview:self.selectedAttrsLabel];
    [contentView addSubview:self.closeBtn];
    [contentView addSubview:self.attrSelectTableView];
    
    UIView *bottomView = [[UIView alloc] init];
    [contentView addSubview:bottomView];
    [bottomView addSubview:self.shoppingCartBtn];
    [bottomView addSubview:self.buyBtn];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(-20);
        make.left.equalTo(contentView).offset(13);
        make.width.height.equalTo(@90);
    }];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(16);
        make.left.equalTo(_goodsImageView.mas_right).offset(15);
        make.height.mas_equalTo(_totalPriceLabel.height);
    }];
    [_selectedAttrsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_goodsImageView);
        make.leading.equalTo(_goodsImageView.mas_trailing).offset(15);
    }];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(20);
        make.trailing.equalTo(contentView).offset(-11);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    [_attrSelectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsImageView.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(12);
        make.trailing.equalTo(contentView).offset(-12);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.trailing.bottom.equalTo(contentView);
        make.height.mas_equalTo(48.5);
    }];
    [_shoppingCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(bottomView);
        make.right.equalTo(_buyBtn.mas_left);
        make.width.equalTo(_buyBtn);
    }];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(bottomView);
        make.width.height.equalTo(_shoppingCartBtn);
    }];
}

#pragma mark - UITableViewDataSource / Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *rowData = _attrArray[indexPath.row];
    self.goodsAttributeCell.attrs = rowData;
    return [self.goodsAttributeCell heightForCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.attrArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRGoodsAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodsAttributeCell forIndexPath:indexPath];
    NSDictionary *rowData = _attrArray[indexPath.row];
    cell.delegate = self;
    cell.attrs = rowData;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] init];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = GRAY_LINE_COLOR;
    [footerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView).offset(20);
        make.leading.equalTo(footerView).offset(12);
        make.trailing.equalTo(footerView).offset(-12);
        make.height.mas_equalTo(0.5);
    }];

    UILabel *titleLabel = [UILabel labelWithText:@"选择数量" textColor:FONT_COLOR_33 fontSize:14];
    [footerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerView).offset(10);
        make.leading.equalTo(lineView);
    }];

    [footerView addSubview:self.addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.trailing.equalTo(footerView).offset(-8);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    [footerView addSubview:self.totalQuantityLabel];
    [_totalQuantityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_addBtn);
        make.trailing.equalTo(_addBtn.mas_leading);
        make.width.mas_equalTo(30);
    }];
    
    [footerView addSubview:self.reduceBtn];
    [_reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.height.equalTo(_addBtn);
        make.trailing.equalTo(_totalQuantityLabel.mas_leading);
    }];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

#pragma mark - Action

- (void)changeGoodsQuantity:(UIButton *)button {
    NSInteger currentQuantity = [_totalQuantityLabel.text integerValue];
    NSInteger quantity = button.tag == 1 ? currentQuantity+1 : currentQuantity-1;
    if (quantity > 20) {
        quantity = 20;
    }
    else if (quantity == 0) {
        quantity = 1;
    }
    _totalQuantityLabel.text = [NSString stringWithFormat:@"%ld",quantity];
}

- (void)shoppingCartBtnClick {
    MLog(@"shoppingCartBtnClick");
}

- (void)buyBtnClick {
    MLog(@"buyBtnClick");
}

- (void)closeBtnClick {
    MLog(@"closeBtnClick");
}

#pragma mark - Setter/Getter

- (void)setAttrArray:(NSArray *)attrArray {
    _attrArray = attrArray;
    [self.attrSelectTableView reloadData];
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.backgroundColor = GLOBAL_COLOR;
        _goodsImageView.layer.cornerRadius = 5;
        _goodsImageView.clipsToBounds = YES;
    }
    return _goodsImageView;
}

- (KRCustomPriceView *)totalPriceLabel {
    if (!_totalPriceLabel) {
        _totalPriceLabel = [KRCustomPriceView customPriceViewWithPrice:@"100.00" integerFontSize:24 decimalFontSize:16];
    }
    return _totalPriceLabel;
}

- (UILabel *)selectedAttrsLabel {
    if (!_selectedAttrsLabel) {
        _selectedAttrsLabel = [UILabel labelWithText:@"已选：" textColor:FONT_COLOR_33 fontSize:14];
    }
    return _selectedAttrsLabel;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UITableView *)attrSelectTableView {
    if (!_attrSelectTableView) {
        _attrSelectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _attrSelectTableView.backgroundColor = [UIColor whiteColor];
        _attrSelectTableView.delegate = self;
        _attrSelectTableView.dataSource = self;
        _attrSelectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _attrSelectTableView.showsVerticalScrollIndicator = NO;
        [_attrSelectTableView registerClass:[KRGoodsAttributeCell class] forCellReuseIdentifier:GoodsAttributeCell];
    }
    return _attrSelectTableView;
}

- (KRGoodsAttributeCell *)goodsAttributeCell {
    if (!_goodsAttributeCell) {
        _goodsAttributeCell = [[KRGoodsAttributeCell alloc] init];
    }
    return _goodsAttributeCell;
}

- (UIButton *)reduceBtn {
    if (!_reduceBtn) {
        _reduceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceBtn setImage:[UIImage imageNamed:@"ic_reduce_default"] forState:UIControlStateNormal];
        _reduceBtn.backgroundColor = RGB(240, 240, 240);
        _reduceBtn.layer.cornerRadius = 10;
        _reduceBtn.clipsToBounds = YES;
        _reduceBtn.tag = 2;
        [_reduceBtn addTarget:self action:@selector(changeGoodsQuantity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reduceBtn;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"ic_add_default"] forState:UIControlStateNormal];
        _addBtn.backgroundColor = RGB(240, 240, 240);
        _addBtn.layer.cornerRadius = 10;
        _addBtn.clipsToBounds = YES;
        _addBtn.tag = 1;
        [_addBtn addTarget:self action:@selector(changeGoodsQuantity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UILabel *)totalQuantityLabel {
    if (!_totalQuantityLabel) {
        _totalQuantityLabel = [UILabel labelWithText:@"1" textColor:FONT_COLOR_33 fontSize:16];
        _totalQuantityLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalQuantityLabel;
}

- (UIButton *)shoppingCartBtn {
    if (!_shoppingCartBtn) {
        _shoppingCartBtn = [UIButton buttonWithTitle:@"加入购物车" fontSize:16 titleColor:[UIColor whiteColor] target:self action:@selector(shoppingCartBtnClick)];
        _shoppingCartBtn.backgroundColor = RGB(74, 237, 170);
    }
    return _shoppingCartBtn;
}

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithTitle:@"立即购买" fontSize:16 titleColor:[UIColor whiteColor] target:self action:@selector(buyBtnClick)];
        _buyBtn.backgroundColor = GLOBAL_COLOR;
    }
    return _buyBtn;
}
@end
