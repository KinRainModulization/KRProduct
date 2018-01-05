//
//  KRGoodsSelectAttributesView.m
//  Yml
//
//  Created by KR on 2017/11/20.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "KRGoodsSelectAttributesView.h"
#import "KRGoodsAttributeCell.h"

@interface KRGoodsSelectAttributesView () <UITableViewDelegate,UITableViewDataSource,KRGoodsAttributeCellDelegate>

@property (nonatomic, strong) UIImageView *goodsImageView;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UITableView *attrSelectTableView;

@property (nonatomic, strong) KRGoodsAttributeCell *goodsAttributeCell;

@property (nonatomic, strong) UIButton *shoppingCartBtn;

@property (nonatomic, strong) UIButton *buyBtn;

@end

@implementation KRGoodsSelectAttributesView

static NSString *GoodsAttributeCell = @"GoodsAttributeCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {

    UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *bottomView = [[UIView alloc] init];
    
    [self addSubview:contentView];
    [contentView addSubview:self.goodsImageView];
    [contentView addSubview:self.priceLabel];
    [contentView addSubview:self.attrSelectTableView];
    [contentView addSubview:bottomView];
    [bottomView addSubview:self.shoppingCartBtn];
    [bottomView addSubview:self.buyBtn];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(-30);
        make.left.equalTo(contentView).offset(10);
        make.width.height.equalTo(@120);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(30);
        make.left.equalTo(_goodsImageView.mas_right).offset(10);
    }];
    
    [_attrSelectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsImageView.mas_bottom).offset(20);
        make.left.equalTo(contentView).offset(10);
        make.trailing.equalTo(contentView).offset(-10);
        make.bottom.equalTo(bottomView.mas_top);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.trailing.bottom.equalTo(contentView);
        make.height.equalTo(@50);
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

#pragma mark - Delegate

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *rowData = _attrArray[indexPath.row];
    self.goodsAttributeCell.attrs = rowData;
    return [self.goodsAttributeCell heightForCell];
}

#pragma mark - Action

- (void)setAttrArray:(NSArray *)attrArray {
    _attrArray = attrArray;
    [self.attrSelectTableView reloadData];
}

- (void)shoppingCartBtnClick {
    MLog(@"shoppingCartBtnClick");
}

- (void)buyBtnClick {
    MLog(@"buyBtnClick");
}

#pragma mark - Setter/Getter

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.backgroundColor = [UIColor redColor];
    }
    return _goodsImageView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel labelWithText:@"$100" textColor:[UIColor blackColor] fontSize:16];
    }
    return _priceLabel;
}

- (UITableView *)attrSelectTableView {
    if (!_attrSelectTableView) {
        _attrSelectTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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

- (UIButton *)shoppingCartBtn {
    if (!_shoppingCartBtn) {
        _shoppingCartBtn = [UIButton buttonWithTitle:@"加入购物车" fontSize:16 titleColor:[UIColor orangeColor] target:self action:@selector(shoppingCartBtnClick)];
        _shoppingCartBtn.backgroundColor = [UIColor lightGrayColor];
    }
    return _shoppingCartBtn;
}

- (UIButton *)buyBtn {
    if (!_buyBtn) {
        _buyBtn = [UIButton buttonWithTitle:@"立即购买" fontSize:16 titleColor:[UIColor redColor] target:self action:@selector(buyBtnClick)];
        _buyBtn.backgroundColor = [UIColor grayColor];
    }
    return _buyBtn;
}
@end
