//
//  KRProductListView.m
//  KRProduct
//
//  Created by LX on 2018/1/16.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRProductListView.h"
#import <KRProductCell.h>

static const CGFloat kSortHeaderHeight = 40;
static NSString *kProductCellIdentifier = @"kProductCellIdentifier";

@interface KRProductListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) KRSortHeaderView *sortHeaderView;

@property (nonatomic, strong) UITableView *productTableView;
@end

@implementation KRProductListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    [self addSubview:self.sortHeaderView];
    [self addSubview:self.productTableView];
}

#pragma mark - UITableViewDataSource/Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.productDetailBlock();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kProductCellIdentifier forIndexPath:indexPath];
    cell.cellLineHeight = 0.5;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

#pragma mark - Setter/Getter
- (void)setProductSortBlock:(void (^)(ProductSortType))productSortBlock {
    _productSortBlock = productSortBlock;
    self.sortHeaderView.productSortBlock = productSortBlock;
}

- (KRSortHeaderView *)sortHeaderView {
    if (!_sortHeaderView) {
        _sortHeaderView = [[KRSortHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSortHeaderHeight)];
    }
    return _sortHeaderView;
}

- (UITableView *)productTableView {
    if (!_productTableView) {
        _productTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSortHeaderHeight, SCREEN_WIDTH, self.height-kSortHeaderHeight) style:UITableViewStylePlain];
        _productTableView.backgroundColor = GLOBAL_BACKGROUND_COLOR;
        _productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _productTableView.delegate = self;
        _productTableView.dataSource = self;
        [_productTableView registerClass:[KRProductCell class] forCellReuseIdentifier:kProductCellIdentifier];
    }
    return _productTableView;
}

@end
